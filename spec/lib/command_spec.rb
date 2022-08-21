# frozen_string_literal: true

require_relative '../../lib/command'

RSpec.describe(Command) do
  describe('.run!') do
    subject(:run!) { described_class.new(args).run! }

    let(:path) { 'spec/fixtures/simple.log' }
    let(:args) { ['-f', path] }

    context 'when log file provided' do
      let(:expected_output) do
        [
          'List of webpages with most page views',
          '',
          '/contact     2 visits',
          '/help_page/1 1 visits',
          '',
          'List of webpages with most unique page views',
          '',
          '/contact     2 unique views',
          '/help_page/1 1 unique views',
          ''
        ].join("\n")
      end

      it 'outputs header for page views stats' do
        expect { run! }.to output(expected_output).to_stdout
      end
    end

    context 'with wrong args' do
      let(:args) { ['--not-exists param'] }

      it 'outputs help' do
        expect { run! }.to raise_error(CommandError, /invalid option: --not-exists param/)
      end
    end

    context 'without args' do
      let(:args) { [] }

      it 'outputs help' do
        expect { run! }.to output(%r{Usage: bin/parser.rb [options]}).to_stdout
      end
    end
  end
end
