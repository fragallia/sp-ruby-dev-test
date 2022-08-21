require_relative '../../lib/command'

RSpec.describe(Command) do
  describe('.run!') do
    subject(:run!) { described_class.new(args).run! }

    let(:args) { ['-f file_path'] }

    context 'with wrong args' do
      let(:args) { ['--not-exists param'] }

      it 'outputs help' do
        expect { run! }.to raise_error(CommandError, %r{invalid option: --not-exists param})
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