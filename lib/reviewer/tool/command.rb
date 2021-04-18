# frozen_string_literal: true

# Assembles tool settings into a usable command string
module Reviewer
  class Tool
    class Command
      attr_reader :settings, :quiet

      def initialize(tool:, config:, quiet: true)
        @settings = Settings.new(tool: tool, config: config)
        @quiet = quiet
      end

      def env
        Env.new(settings.env)
      end

      def body
        ''
      end

      def flags
        Flags.new(settings.flags)
      end

      def verbosity
        ''
      end
    end
  end
end
