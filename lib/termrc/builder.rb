
require 'yaml'
require 'tempfile'

module Termrc

  class Builder

    SLEEP_INTERVAL  = 1
    TEMPLATE_FILE   = File.join( File.expand_path('../..', __FILE__),  'template', 'run.osascript' )
    TEMPLATE        = File.read( TEMPLATE_FILE )

    attr_accessor :layout
    attr_accessor :commands

    def initialize(yml)
      @root       = yml['root']
      @commands   = yml['commands']
      @layout     = yml['layout']
      @cmd_index  = 1
    end

    def run!
      applescript_files.each do |f|
        puts `/usr/bin/osascript #{f.path}`
        f.unlink
      end
    end

    def applescript_files
      if tabs?
        return @layout.each_with_index.map{ |layout_array, index|
          applescript_file(layout_array, index)
        }
      else
        return [ applescript_file(@layout, 0) ]
      end
    end

    def applescript_file(layout_array, index)
      t = generateContents(layout_array, index)
      writeTempFile(t)
    end

    def generateContents(layout_array, index)
      t = TEMPLATE

      if index > 0
        # All other tabs.
        t = t.gsub("[window_or_tab]",     new_tab)
        t = t.gsub("[session]",           current_session)
        t = t.gsub("[terminate_unused]",  terminate_session('last'))
      else
        # First tab.
        t = t.gsub("[window_or_tab]",     new_window)
        t = t.gsub("[session]",           new_session)
        t = t.gsub("[terminate_unused]",  terminate_session)
      end

      t = t.gsub("[rows]",      rows(layout_array))
      t = t.gsub("[sleep]",     rest)
      t = t.gsub("[panes]",     panes(layout_array))
      t = t.gsub("[commands]",  commands(layout_array))
      t
    end

    def writeTempFile(contents)
      file = Tempfile.new('termrc.osascript')
      file.write(contents)
      file.close
      file
    end

    def rows(layout_array)
      Array.new( row_count(layout_array), new_row ).join("\n")
    end

    def panes(layout_array)
      cmd =   next_pane     # back to the top
      cmd =   next_pane     # back to the top

      layout_array.each do |cmds|
        cmd << Array.new( cmds.length - 1, new_column ).join("\n")
        cmd << next_pane
        cmd << "\n"
      end

      cmd
    end

    def commands(layout_array)
      cmd = ""

      layout_array.each do |commands|
        commands.each do |name|
          cmd << execute_command( @cmd_index, @commands[name], name )
          @cmd_index += 1
        end
      end

      cmd
    end

    def row_count(layout_array)
      layout_array.length
    end

    def tabs?
      @layout[0].is_a?(Array) and @layout[0][0].is_a? Array
    end

    protected

    def rest(i=SLEEP_INTERVAL)
      "do shell script \"sleep #{i}\" \n"
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

    def new_tab
      [
        keystroke("t", "command down"),
        "set myterm to (current terminal)",
      ].join("\n")
    end

    def new_window
      [ "set myterm to (make new terminal)" ].join("\n")
    end

    def new_session
      "set mysession to (make new session at the end of sessions)"
    end

    def current_session
      "set mysession to (current session)"
    end

    def terminate_session(which='first')
      "terminate the #{which} session"
    end

    def execute_command(item, command, name)
      command = command.gsub('"', '\\"')
      command = command.gsub("'", "\\'")
      command = "cd #{@root} && " + command if @root
      <<-EOH
        tell item #{item} of sessions to set name to "#{name}" \n
        tell item #{item} of sessions to write text \"#{command}\" \n
      EOH
    end

    def keystroke(key, using="")
      cmd =   "tell application \"System Events\" to keystroke \"#{key}\" "
      cmd <<  "using {#{using}} \n" if  using
      cmd <<  "\n"                if !using
      cmd
    end

  end

end
