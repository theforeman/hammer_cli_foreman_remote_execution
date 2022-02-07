# frozen_string_literal: true

require 'hammer_cli_foreman/interface'

module HammerCLIForemanRemoteExecution
  class InterfaceExtensionsInfo < ::HammerCLI::CommandExtensions
    output do |definition|
      definition.append do
        field :execution, _('Execution'), Fields::Boolean
      end
    end
  end

  module InterfaceExtensionsList
    def format_type(nic)
      type = super(nic)
      if nic['execution']
        if nic['primary'] || nic['provision']
          type[-1] = ', '+_('execution') +')'
        else
          type += ' ('+_('execution') +')'
        end
      end
      type
    end
  end

  module MandatoryInterfacesExtensions
    def mandatory_interfaces(host_id, nic_id)
      attributes = super
      return attributes if option_execution.nil?

      nics = get_interfaces(host_id)['results']
      current = nics.find { |nic| nic['id'] == nic_id.to_i }
      # We don't need to do anything if the interface we're trying to change is
      # already in its desired state
      return attributes if current['execution'] == !!option_execution

      # There needs to be exactly one interface marked as execution
      # There should be a hook on Foreman's side to mark the primary interface
      # as execution if no interface is marked as such, but it doesn't seem to
      # work reliably
      execution_id = if option_execution
                       nic_id.to_i
                     else
                       # If there's no interface marked as primary from super,
                       # let's pick the primary from server's data
                       primary = attributes.find { |nic| nic['primary'] } || nics.find { |nic| nic['primary'] }
                       primary['id']
                     end

      nics.map do |nic|
        base = attributes.find { |attr| attr['id'] == nic['id'] } || { 'id' => nic['id'] }
        base['execution'] = nic['id'] == execution_id
        base
      end
    end
  end

  ::HammerCLIForeman::Interface::UpdateCommand.prepend MandatoryInterfacesExtensions
  ::HammerCLIForeman::Interface::CreateCommand.prepend MandatoryInterfacesExtensions
  ::HammerCLIForeman::Interface.singleton_class.prepend InterfaceExtensionsList
  ::HammerCLIForeman::Interface::InfoCommand.extend_with(InterfaceExtensionsInfo.new)
end
