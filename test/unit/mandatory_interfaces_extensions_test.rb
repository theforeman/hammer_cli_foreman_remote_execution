ENV['TEST_API_VERSION'] = '1.17'
require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/test_helper')
# require File.join(Gem.loaded_specs['hammer_cli_foreman'].full_gem_path, 'test/unit/apipie_resource_mock')
require 'hammer_cli_foreman_remote_execution'

describe HammerCLIForemanRemoteExecution::MandatoryInterfacesExtensions do
  context '#mandatory_interfaces' do

    class CustomCommand
      prepend HammerCLIForemanRemoteExecution::MandatoryInterfacesExtensions

      attr_accessor :mandatory_interfaces_data
      def mandatory_interfaces(host_id, nic_id)
        mandatory_interfaces_data
      end
    end

    let(:command) { CustomCommand.new }

    it 'does nothing if execution interface is not being changed' do
      command.mandatory_interfaces_data = 'unchanged'
      command.expects(:option_execution)
      command.mandatory_interfaces(1, 2).must_equal 'unchanged'
    end

    it 'does nothing when setting execution flag on execution interface' do
      command.mandatory_interfaces_data = 'unchanged'
      command.expects(:option_execution).twice.returns(true)
      command.expects(:get_interfaces).returns({ 'results' => [{'id' => 2, 'execution' => true}]})
      command.mandatory_interfaces(1, 2).must_equal 'unchanged'
    end

    it 'does nothing when unsetting execution flag on non-execution interface' do
      command.mandatory_interfaces_data = 'unchanged'
      command.expects(:option_execution).twice.returns(false)
      command.expects(:get_interfaces).returns({ 'results' => [{'id' => 2, 'execution' => false}]})
      command.mandatory_interfaces(1, 2).must_equal 'unchanged'
    end

    it 'unsets all other interfaces as execution' do
      data = [{'id' => 2, 'primary' => true}]
      command.mandatory_interfaces_data = data
      command.expects(:option_execution).times(3).returns(true)
      command.expects(:get_interfaces).returns({ 'results' => [{'id' => 2, 'execution' => false}, {'id' => 3, 'execution' => false}]})
      command.mandatory_interfaces(1, 3).must_equal [
        {'id' => 2, 'execution' => false, 'primary' => true},
        {'id' => 3, 'execution' => true}
      ]
    end

    it 'marks primary interface as execution when unsetting' do
      data = [{'id' => 2, 'primary' => true}]
      command.mandatory_interfaces_data = data
      command.expects(:option_execution).times(3).returns(false)
      command.expects(:get_interfaces).returns({ 'results' => [{'id' => 2, 'execution' => false}, {'id' => 3, 'execution' => true}]})
      command.mandatory_interfaces(1, 3).must_equal [
        {'id' => 2, 'execution' => true, 'primary' => true},
        {'id' => 3, 'execution' => false}
      ]
    end

    it 'marks primary interface as execution when unsetting' do
      data = []
      command.mandatory_interfaces_data = data
      command.expects(:option_execution).times(3).returns(false)
      command.expects(:get_interfaces).returns({ 'results' => [{'id' => 2, 'execution' => false, 'primary' => true}, {'id' => 3, 'execution' => true}]})
      command.mandatory_interfaces(1, 3).must_equal [
        {'id' => 2, 'execution' => true},
        {'id' => 3, 'execution' => false}
      ]
    end
  end
end
