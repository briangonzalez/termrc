
require 'yaml'

:Builder

module Termrc

  class Base

    def initialize(file)
      @yml      = YAML.load File.read( file ) 
      @builder  = Termrc::Builder.new( @yml )
      @builder.run!
    end

  end

end