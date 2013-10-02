
require 'yaml'
require 'tempfile'

module Termrc

  class Builder

    SLEEP_INTERVAL  = 1
    TEMPLATE_FILE   = File.join( File.expand_path('../..', __FILE__),  'template', 'run.osascript' )
    TEMPLATE        = File.read( TEMPLATE_FILE )

    def initialize(yml)
      @root       = yml['root']
      @commands   = yml['commands']
      @layout     = yml['layout']
    end

    def run!
      f = applescript_file
      puts `/usr/bin/osascript #{f.path}`
      f.unlink
    end

    def applescript_file
      t = TEMPLATE
      t = t.gsub("[rows]",      rows)
      t = t.gsub("[sleep]",     sleep)
      t = t.gsub("[panes]",     panes)
      t = t.gsub("[commands]",  commands)
      t

      file = Tempfile.new('termrc.osascript')
      file.write(t)
      file.close
      file
    end

    def rows
      Array.new( row_count, new_row ).join("\n")
    end

    def panes
      cmd =   next_pane     # back to the top
      cmd =   next_pane     # back to the top
      
      @layout.each do |cmds|
        cmd << Array.new( cmds.length - 1, new_column ).join("\n")
        cmd << next_pane
        cmd << "\n"
      end

      cmd
    end

    def commands
      cmd = ""

      index = 1
      @layout.each do |commands|
        commands.each do |name|
          cmd << execute_command(index, @commands[name] )
          index += 1
        end
      end  

      cmd
    end

    def row_count
      @row_count ||= @layout.length
    end

    protected

    def sleep
      "do shell script \"sleep #{SLEEP_INTERVAL}\" \n"
    end

    def new_row
      keystroke("D", "command down")
    end

    def new_column
      keystroke("d", "command down")
    end

    def next_pane
      keystroke("]", "command down")
    end

    def execute_command(item, command)
      command = command.gsub('"', '\\"')
      command = command.gsub("'", "\\'")
      command = "cd #{@root} && " + command if @root
      "tell item #{item} of sessions to write text \"#{command}\" \n"
    end

    def keystroke(key, using="")
      cmd =   "tell application \"System Events\" to keystroke \"#{key}\" "
      cmd <<  "using #{using} \n" if  using
      cmd <<  "\n"                if !using
      cmd
    end

  end

end