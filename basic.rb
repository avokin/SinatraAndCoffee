require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'coffee-script'


configure :development do
  COFFEE_FILES = ["application"]

  COFFEE_FILES.each do |script_file|
    get "/#{script_file}.js.map" do
      coffee(script_file.to_sym, {:sourceMap => true, :sourceFiles => [script_file + ".coffee"]})["v3SourceMap"]
    end

    get "/#{script_file}.coffee" do
      File.read "views/#{script_file}.coffee"
    end

    get "/#{script_file}.js" do
      content_type "application/javascript"
      js = coffee script_file.to_sym
      js + "//@ sourceMappingURL=#{script_file}.js.map\n"
    end
  end
end

get '/' do
  erb :index
end

get '/application.js' do
  coffee :application
end