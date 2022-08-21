# frozen_string_literal: true

module Logs
  class Stats
    attr_reader :logs

    def initialize(logs)
      @logs = logs
    end

    def page_unique_views
      stats.map { |page, ips| [page, ips.values.max, 'unique views'] }
          .sort_by { |item| item[1] }
          .reverse
    end

    def page_views
      stats.map { |page, ips| [page, ips.values.sum, 'visits'] }
          .sort_by { |item| item[1] }
          .reverse
    end

    private

    def stats
      @stats ||= logs.each_with_object({}) do |log, res|
        res[log[:path]] ||= {}
        res[log[:path]][log[:ip]] = res[log[:path]][log[:ip]].to_i + 1
      end
    end
  end
end
