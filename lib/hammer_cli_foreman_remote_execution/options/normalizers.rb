module HammerCLIForemanRemoteExecution
  module Options
    module Normalizers
      class KeyFileList < ::HammerCLI::Options::Normalizers::KeyValueList
        def description
          _('Comma-separated list of key=file, where file is a path to a text file to be read')
        end

        def format(val)
          Hash[super.map { |key, path| [key, ::File.read(::File.expand_path(path))] }]
        end

        def complete(value)
          Dir[value.to_s+'*'].collect do |file|
            if ::File.directory?(file)
              file+'/'
            else
              file+' '
            end
          end
        end
      end
    end
  end
end
