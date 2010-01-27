require 'erb'
require 'lib/helpers'

class Template
  include Helpers

  def initialize(text, data)
    @text = text
    data.each {|n, v| instance_variable_set("@#{n}", v) }
  end

  def result
    ERB.new(@text).result(binding)
  end

  alias_method :to_s, :result
end
