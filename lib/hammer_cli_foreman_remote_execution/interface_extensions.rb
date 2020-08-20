require 'hammer_cli_foreman/interface'

module HammerCLIForemanRemoteExecution
  class InterfaceExtensions < ::HammerCLI::CommandExtensions
    output do |definition|
      definition.append do
        field :execution, _('Execution'), Fields::Boolean
      end
    end
  end

  ::HammerCLIForeman::Interface::InfoCommand.extend_with(InterfaceExtensions.new)
end
