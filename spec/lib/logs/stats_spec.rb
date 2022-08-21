# frozen_string_literal: true

require_relative '../../../lib/logs/stats'

RSpec.describe(Logs::Stats) do
  describe '.page_views' do
    subject(:page_views) { described_class.new(logs).page_views }

    let(:logs) do
      [
        { ip: '126.318.035.038', path: '/help_page/1' },
        { ip: '184.123.665.067', path: '/contact' },
        { ip: '184.123.665.067', path: '/contact' },
      ]
    end

    let(:expected_output) do
      [
        ['/contact', 2, 'visits'],
        ['/help_page/1', 1, 'visits'],
      ]
    end

    it 'returns page views' do
      expect(page_views.to_a).to match(expected_output)
    end
  end

  describe '.page_unique_views' do
    subject(:page_unique_views) { described_class.new(logs).page_unique_views }

    let(:logs) do
      [
        { ip: '126.318.035.038', path: '/help_page/1' },
        { ip: '184.123.665.067', path: '/contact' },
        { ip: '184.123.665.067', path: '/contact' },
      ]
    end

    let(:expected_output) do
      [
        ['/contact', 2, 'unique views'],
        ['/help_page/1', 1, 'unique views'],
      ]
    end

    it 'returns page views' do
      expect(page_unique_views.to_a).to match(expected_output)
    end
  end
end
