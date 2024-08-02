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
          type[-1] = ', ' + _('execution') + ')'
        else
          type += ' (' + _('execution') + ')'
        end
      end
      type
    end
  end

  ::HammerCLIForeman::Interface.singleton_class.prepend InterfaceExtensionsList
  ::HammerCLIForeman::Interface::InfoCommand.extend_with(InterfaceExtensionsInfo.new)
end
