require_relative '../../lib/command'

RSpec.describe(Command) do
  describe('.run!') do
    subject(:run!) { described_class.new(args).run! }

    let(:args) { ['-f file_path'] }

    context 'when args empty' do
      let(:args) { [] }

      it 'outputs help' do
        expect { run! }.to output(%r{Usage: bin/parser.rb [options]}).to_stdout
      end
    end
  end
end