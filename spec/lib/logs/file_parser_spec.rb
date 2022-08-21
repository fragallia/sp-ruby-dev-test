# frozen_string_literal: true

require_relative '../../../lib/logs/file_parser'

RSpec.describe(Logs::FileParser) do
  describe '.parsed_logs' do
    subject(:parsed_logs) { described_class.parsed_logs(path) }
    let(:path) { 'spec/fixtures/simple.log' }

    let(:expected_output) do
      [
        { ip: '126.318.035.038', path: '/help_page/1' },
        { ip: '184.123.665.067', path: '/contact' },
        { ip: '184.123.665.067', path: '/contact' },
      ]
    end

    it 'returns enumerator' do
      expect(parsed_logs).to be_a(Enumerator)
    end

    it 'returns parsed logs' do
      expect(parsed_logs.to_a).to match(expected_output)
    end
  end
end
