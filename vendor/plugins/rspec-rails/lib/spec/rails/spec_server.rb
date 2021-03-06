require 'drb/drb'
require 'rbconfig'

# This is based on Florian Weber's TDDMate
module Spec
  module Rails
    class SpecServer
      class << self
        def restart_test_server
          puts "restarting"
          config       = ::Config::CONFIG
          ruby         = File::join(config['bindir'], config['ruby_install_name']) + config['EXEEXT']
          command_line = [ruby, $0, ARGV].flatten.join(' ')
          exec(command_line)
        end

        def daemonize(pid_file = nil)
          return yield if $DEBUG
          pid = Process.fork{
            Process.setsid
            Dir.chdir(RAILS_ROOT)
            trap("SIGINT"){ exit! 0 }
            trap("SIGTERM"){ exit! 0 }
            trap("SIGHUP"){ restart_test_server }
            File.open("/dev/null"){|f|
              STDERR.reopen f
              STDIN.reopen  f
              STDOUT.reopen f
            }
            run
          }
          puts "spec_server launched (PID: %d)" % pid
          File.open(pid_file,"w"){|f| f.puts pid } if pid_file
          exit! 0
        end

        def run
          trap("USR2") { ::Spec::Rails::SpecServer.restart_test_server } if Signal.list.has_key?("USR2")
          DRb.start_service("druby://127.0.0.1:8989", ::Spec::Rails::SpecServer.new)
          DRb.thread.join
        end
      end
      
      def run(argv, stderr, stdout)
        $stdout = stdout
        $stderr = stderr
        
        require 'action_controller/dispatcher'
        dispatcher = ::ActionController::Dispatcher.new($stdout)
        dispatcher.respond_to?(:cleanup_application) ?
          dispatcher.cleanup_application :
          dispatcher.reload_application
        
        if Object.const_defined?(:Fixtures) && Fixtures.respond_to?(:reset_cache)
          Fixtures.reset_cache
        end
        
        ::ActiveSupport.const_defined?(:Dependencies) ?
          ::ActiveSupport::Dependencies.mechanism = :load :
          ::Dependencies.mechanism = :load

        unless Object.const_defined?(:ApplicationController)
          %w(application_controller.rb application.rb).each do |name|
            require_dependency(name) if File.exists?("#{RAILS_ROOT}/app/controllers/#{name}")
          end
        end
        load "#{RAILS_ROOT}/spec/spec_helper.rb"

        if in_memory_database?
          load "#{RAILS_ROOT}/db/schema.rb" # use db agnostic schema by default
          ActiveRecord::Migrator.up('db/migrate') # use migrations
        end

        ::Spec::Runner::CommandLine.run(
          ::Spec::Runner::OptionParser.parse(
            argv,
            $stderr,
            $stdout
          )
        )
      end

      def in_memory_database?
        ENV["RAILS_ENV"] == "test" and
        ::ActiveRecord::Base.connection.class.to_s == "ActiveRecord::ConnectionAdapters::SQLite3Adapter" and
        ::Rails::Configuration.new.database_configuration['test']['database'] == ':memory:'
      end
    end
  end
end
