require 'thor'
require 'fileutils'

module Termrc

  TERMRC_TEMPLATE = File.join( File.expand_path('../..', __FILE__), 'template', 'termfile.template' )

  class Cli < Thor
    include Thor::Actions

    map 'c'     => :create
    map 'init'  => :create
    map 'l'     => :list
    map 's'     => :start

    desc 'create', 'Create Termfile (Shortcut: c / init)'
    def create
      if (File.exist? '.termrc' or File.exists? 'Termfile')
        say_this "Error: 'Termfile' already exists!"
        return
      else
        say_this "Creating Termfile...", :yellow
        FileUtils.cp TERMRC_TEMPLATE, 'Termfile'

        say_this "Success! \n", :yellow
        say_this "Now run your new Termfile file by calling `termrc start`", :blue
      end
    end

    desc 'list', 'List Termfiles in folder (Shortcut: l, Argument 0: folder (optional))'
    def list(folder='.')
      folder_description = folder == "." ? 'current folder' : "'#{folder}'"
      say_this "Looking for termrc files in #{folder_description}:", :yellow

      a = `find #{folder} -name ".termrc" -o -name "Termfile"`
      say_this a

      say_this "None found.", :red if a.length < 1
    end

    desc 'start', 'Start termrc file (Shortcut: s, Argument 0: file (optional) )'
    def start(file='Termfile')
      file = '.termrc' unless File.exists?(file)

      if !File.exist? file
        say_this "Could not find Termfile! Did you run `termrc create`?", :red
        say_this "Did you run `termrc init`?", :yellow
        return
      elsif file == '.termrc'
        say_this "Using deprecated #{file} file...", :yellow
      end

      say_this "Starting termrc using: '#{file}'", :blue
      say_this "Please wait until all panes have fully launched!", :red
      begin
        Termrc::Base.new( File.expand_path(file) )
      rescue Exception => e
        say_this "Error while starting termrc:", :red
        say_this e.to_s
      end
    end

    no_commands do
      def say_this(text="", color=:white)
        say "** " + (text || ''), color
      end
    end

  end
end
