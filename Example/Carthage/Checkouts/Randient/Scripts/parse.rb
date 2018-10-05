# @example
# curl https://raw.githubusercontent.com/Ghosh/uiGradients/master/gradients.json | ruby parse.rb

require 'json'
require 'erb'
require 'fileutils'
require 'active_support/core_ext/string/inflections'

def parse(body)
  @colors = JSON.parse(body).map do |color|
    {
        "name" => color["name"],
        "camelized_name" => color["name"].gsub(/(\W|\d)/, "").split(" ").join("").camelize(:lower), # dirty
        "colors" => color["colors"],
    }
  end
end

def render_swift
  ERB.new(File.read(File.dirname(__FILE__) + "/UIGradient.swift.erb"), nil, '-').result()
end

def write
  gendir = File.dirname(__FILE__) + '/gen'
  FileUtils.mkdir_p gendir
  File.open(gendir + "/UIGradient.swift", "w") do |f|
    f.write render_swift
  end
end

json_string = ARGF.read
puts("Parsing Gradient JSON")
parse(json_string)
puts("Rendering Swift file")
write()