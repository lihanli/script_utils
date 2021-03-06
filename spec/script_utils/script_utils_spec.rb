require 'spec_helper'

RSpec.describe ScriptUtils do
  let(:test_dir) { 'spec/test_dir' }

  describe '#files' do
    context 'without a trailing slash' do
      it 'should list the files in a directory' do
        expect(ScriptUtils.files(test_dir)).to eq(["spec/test_dir/file"])
      end
    end

    context 'with a trailing slash' do
      it 'should list the files in a directory' do
        expect(ScriptUtils.files("#{test_dir}/")).to eq(["spec/test_dir/file"])
      end
    end
  end

  describe '#directories' do
    it 'should list all the directories' do
      expect(ScriptUtils.directories(test_dir)).to eq(["spec/test_dir/dog"])
    end
  end

  describe '#file_names' do
    it 'should list the files names' do
      expect(ScriptUtils.file_names(test_dir)).to eq(['file'])
    end
  end

  describe '#directory_names' do
    it 'should list the dir names' do
      expect(ScriptUtils.directory_names(test_dir)).to eq(['dog'])
    end
  end

  describe '#run' do
    def run(*args)
      ScriptUtils.run(*args)
    end

    def expect_command(cmd, output: false)
      expect(ScriptUtils).to receive(:"#{output ? 'system' : '`'}").once.with(cmd)
      allow($?).to receive(:success?).and_return(true)
    end

    context 'when ensure_success is false' do
      it 'should not raise on nonzero exit code' do
        run('false', ensure_success: false)
      end
    end

    context 'when ensure_success is true' do
      context 'when bundle exec is false' do
        context 'when output is true' do
          it 'should run the system cmd' do
            expect_command('ls', output: true)
            run('ls', output: true)
          end
        end

        context 'when output is false' do
          it 'should raise on nonzero exit code' do
            expect { run('false') }.to raise_error
          end

          it 'should run backticks' do
            expect_command('ls')
            run('ls', output: false)
          end

          context 'when working dir is set' do
            it 'should cd to the working dir' do
              expect_command('cd lib; ls')
              run('ls', working_dir: 'lib')
            end
          end
        end
      end

      context 'when bundle_exec is true' do
        context 'when working dir is set' do
          it 'should cd to the working dir' do
            expect_command('cd lib; bundle exec ls')
            run('ls', working_dir: 'lib', bundle_exec: true)
          end
        end

        it 'should add bundle exec to the cmd' do
          expect_command('bundle exec ls')
          run('ls', bundle_exec: true)
        end
      end
    end
  end
end
