# frozen_string_literal: true

require 'hammer_cli_foreman/subnet'

module HammerCLIForemanRemoteExecution
  class SubnetExtensions < ::HammerCLI::CommandExtensions
    output do |definition|
      definition.insert(:after, _("Smart Proxies")) do
        collection :remote_execution_proxies, _('Remote execution proxies'), :numbered => false do
          field :id, _('Id')
          field :name, _('Name')
        end
      end
    end
  end

  ::HammerCLIForeman::Subnet::InfoCommand.extend_with(SubnetExtensions.new)
end
