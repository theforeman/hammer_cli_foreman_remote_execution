ENV['TEST_API_VERSION'] = '1.10'

require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution/template_input'

describe HammerCLIForemanRemoteExecution::TemplateInput do
  include CommandTestHelper

  context 'ListCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::ListCommand.new('', ctx) }

    context 'output' do
      with_params ['--template-id=1'] do
        let(:expected_record_count) { cmd.resource.call(:index, :template_id => 1)['results'].length }
        it_should_print_n_records
        it_should_print_columns ['Id', 'Name', 'Input type']
      end
    end
  end

  context 'InfoCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::InfoCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'required parameters', ['--template-id=template', '--name=foo']
    end

    context 'output' do
      with_params ['--template-id=1', '--id=1'] do
        it_should_print_columns ['Id', 'Name', 'Input type', 'Fact name', 'Variable name', 'Puppet parameter name']
      end
    end
  end

  context 'DeleteCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::DeleteCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'required parameters', ['--template-id=template', '--name=foo']
    end
  end

  context 'CreateCommand' do
    let(:cmd) { HammerCLIForemanRemoteExecution::TemplateInput::CreateCommand.new('', ctx) }

    context 'parameters' do
      it_should_accept 'create options', ['--template-id=1', "--name=asdf", '--input-type=user']
    end
  end
end
