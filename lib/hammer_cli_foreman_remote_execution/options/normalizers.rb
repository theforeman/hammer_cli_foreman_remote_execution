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

      class CronLine < ::HammerCLI::Options::Normalizers::AbstractNormalizer
        def description
          _("Cron line format 'a b c d e', where:\n  a. is minute (range: 0-59)\n  b. is hour (range: 0-23)\n  c. is day of month (range: 1-31)\n  d. is month (range: 1-12)\n  e. is day of week (range: 0-6)")
        end

        def format(val)
          val
        end
      end
    end
  end
end
