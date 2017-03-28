require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require "open3"

$left = 0
$right = 0

Thread.new do # trivial example work thread
  Open3.popen3("java -jar GetBalance.jar") do |i, o, e, w|

    i.close
    o.each do |line|
      $left = line.split(",")[0]
      $right = line.split(",")[1]
    end #=> "a\n",  "b\n"
    p w.value #=> #<Process::Status: pid 32682 exit 0>
  end
end

get '/' do
  "#{$left},#{$right}"
end
