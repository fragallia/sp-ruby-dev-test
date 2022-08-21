# frozen_string_literal: true

module Logs
  class Formater
    attr_reader :logs

    def initialize(logs)
      @logs = logs
    end

    def lines
      return enum_for(:lines) unless block_given?

      logs.each do |log|
        yield log.map.with_index { |_, index| format("%-#{spacing[index]}s", _) }.join(' ')
      end
    end

    private

    def spacing
      @spacing ||= logs.each_with_object([]) do |log, res|
        log.each_with_index do |column, index|
          res[index] = [res[index].to_i, column.to_s.size].max
        end
      end
    end
  end
end
