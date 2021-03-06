# frozen_string_literal: true

require 'thread'

require 'timeout'
require 'listen/event/processor'
require 'listen/thread'

module Listen
  module Event
    class Loop
      include Listen::FSM

      class Error < RuntimeError
        class NotStarted < Error; end
      end

      start_state :pre_start
      state :pre_start
      state :starting
      state :started
      state :stopped

      def initialize(config)
        @config = config
        @wait_thread = nil
        @reasons = ::Queue.new
        initialize_fsm
      end

      def wakeup_on_event
        if started? && @wait_thread&.alive?
          _wakeup(:event)
        end
      end

      def started?
        state == :started
      end

      MAX_STARTUP_SECONDS = 5.0

      def start
        # TODO: use a Fiber instead?
        return unless state == :pre_start

        transition! :starting

        @wait_thread = Listen::Thread.new("wait_thread") do
          _process_changes
        end

        Listen.logger.debug("Waiting for processing to start...")

        wait_for_state(:started, MAX_STARTUP_SECONDS) or
          raise Error::NotStarted, "thread didn't start in #{MAX_STARTUP_SECONDS} seconds (in state: #{state.inspect})"

        Listen.logger.debug('Processing started.')
      end

      def pause
        # TODO: works?
        # fail NotImplementedError
      end

      def stop
        return if stopped?
        transition! :stopped

        if @wait_thread.alive?
          @wait_thread.join
        end
        @wait_thread = nil
      end

      def stopped?
        state == :stopped
      end

      private

      def _process_changes
        processor = Event::Processor.new(@config, @reasons)

        transition! :started

        processor.loop_for(@config.min_delay_between_events)
      end

      def _wakeup(reason)
        @reasons << reason
        @wait_thread.wakeup
      end
    end
  end
end
