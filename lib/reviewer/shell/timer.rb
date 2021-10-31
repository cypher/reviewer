# frozen_string_literal: true

require 'open3'

module Reviewer
  class Shell
    # Provides a structured interface for measuring realtime main while running comamnds
    class Timer
      attr_accessor :prep, :main

      # A 'Smart' timer that understands preparation time and main time and can easily do the math
      #   to help determine what percentage of time was prep.
      # @param prep: nil [Float] the amount of time in seconds the preparation command ran
      # @param main: nil [Float] the amount of time in seconds the primary command ran
      #
      # @return [self]
      def initialize(prep: nil, main: nil)
        @prep = prep
        @main = main
      end

      # Records the execution time for the block and assigns it to the `prep` time
      # @param &block [Block] the commands to be timed
      #
      # @return [Float] the execution time for the preparation
      def record_prep(&block)
        @prep = record(&block)
      end

      # Records the execution time for the block and assigns it to the `main` time
      # @param &block [Block] the commands to be timed
      #
      # @return [Float] the execution time for the main command
      def record_main(&block)
        @main = record(&block)
      end

      def prep_seconds
        prep.round(2)
      end

      def main_seconds
        main.round(2)
      end

      def total_seconds
        total.round(2)
      end

      def prep_percent
        return nil unless prepped?

        (prep / total.to_f * 100).round
      end

      def total
        [prep, main].compact.sum
      end

      def prepped?
        !(prep.nil? || main.nil?)
      end

      private

      def record(&block)
        Benchmark.realtime(&block)
      end
    end
  end
end
