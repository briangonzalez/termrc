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

    desc 'list', 'List termrc files in folder (Shortcut: l, Argument 0: folder (optional))'
    def list(folder='.')
      folder_description = folder == "." ? 'current folder' : "'#{folder}'"
      say "Looking for termrc files in #{folder_description}:", :yellow
      
      a = `find #{folder} | grep -w \.termrc$`
      say a

      say "None found.", :red if a.length < 1
    end

    desc 'start', 'Start termrc file (Shortcut: s, Argument 0: file (optional) )'
    def start(file=false)
      file = file || '.termrc'
      raise Thor::Error.new "File '#{file}'' does not exist!" unless File.exist? file

      say "Starting termrc file: '#{file}'", :yellow
      begin
        Termrc::Base.new( File.expand_path(file) )
      rescue Exception => e
        say "\nError while starting termrc file:", :red
        puts e
      end
    end

  end
end