# frozen_string_literal: true

require_relative '../../../lib/logs/formater'

RSpec.describe(Logs::Formater) do
  describe('.lines') do
    subject(:lines) { described_class.new(logs).lines }

    let(:logs) { [['some', 'line', 'content']] }

    it 'returns enumerator' do
      expect(lines).to be_a(Enumerator)
    end

    it 'returns formated string' do
      expect(lines.to_a).to match(['some line content'])
    end

    context 'with uneven strings' do
      let(:logs) do
        [
          ['some', 'line-longer', 'content'],
          ['some-longer', 'line', 'content-longer'],
        ]
      end

      let(:expected_output) do
        [
          'some        line-longer content       ',
          'some-longer line        content-longer',
        ]
      end

      it 'returns table like formated string' do
        expect(lines.to_a).to match(expected_output)
      end
    end
  end
end
