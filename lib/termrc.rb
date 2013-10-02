module Termrc
  dir =               File.expand_path('..', __FILE__)
  autoload :Base,     File.join(dir, 'termrc', 'base')
  autoload :Cli,      File.join(dir, 'termrc', 'cli')
  autoload :Builder,  File.join(dir, 'termrc', 'builder')
end