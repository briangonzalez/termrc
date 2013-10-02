require 'thor'
require 'fileutils'

module Termrc

  TERMRC_TEMPLATE = File.join( File.expand_path('../..', __FILE__), 'template', 'termrc_base.template' )

  class Cli < Thor
    include Thor::Actions

    map 'c' => :create
    map 'l' => :list
    map 's' => :start

    desc 'create', 'Create termrc file (Shortcut: c)'
    def create

      if File.exist? '.termrc'
        raise Thor::Error.new "Error: '.termrc' already exists!"
      else
        say "Creating .termrc file..", :yellow
        FileUtils.cp TERMRC_TEMPLATE, '.termrc'

        say "Success! \n\n", :yellow

        say "Now run your new termrc file by calling `termrc start`", :blue
      end
    end

    desc 'list', 'List termrc files (Shortcut: l, Options: --folder=<folder>)'
    method_option :folder, :type => :string, :required => false
    def list
      folder = options[:folder] || '.'
      say "Looking for termrc files in '#{folder}':", :yellow
      
      a = %x[ find #{folder} | grep "\.termrc" ]
      say a

      say "None found.", :red if a.length < 1
    end

    desc 'start', 'Start termrc file (Shortcut: s, Options: --file=<termc file>)'
    method_option :file, :type => :string, :required => false
    def start
      file = options[:file] || '.termrc'
      raise Thor::Error.new "File '#{file}'' does not exist!" unless File.exist? file

      say "Starting termrc file: '#{file}'", :yellow
      begin
        Termrc::Base.new( File.expand_path(file) )
      rescue Exception => e
        raise Thor::Error.new "Error while starting termrc file!"
        say e
      end
    end

  end
end