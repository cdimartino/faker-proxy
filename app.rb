require 'rubygems'
require 'bundler/setup'

require 'sinatra'
require 'sinatra/reloader' if development?

require 'rdiscount'

require 'json'

require 'faker'

set :show_exceptions, :after_handler
set :views, File.dirname(__FILE__)

get '/' do
  markdown :README
end

get '/methods' do
  erb :methods, locals: {
    modules: Faker.constants.sort.map do |const|
      modularize(const)
    end
  }
end

get '/:mod' do |mod|
  erb :methods, locals: { modules: [modularize(mod.capitalize)] }
end

get '/:mod/:method/?*?' do |mod, method, extra_params|
  method = methodize(mod, method)
  method.call(*to_params(extra_params)).to_json
end

error NameError do
  [404, "I don't know nothin bout no #{env['sinatra.error'].message}"]
end

def to_params params_from_user
  params_from_user.split('/').map do |param|
    if param =~ /\A\d+\Z/
      param.to_i
    elsif %w{true false}.include?(param)
      param == "true" # heh
    else
      param
    end
  end
end

def modularize mod
  Kernel.const_get("Faker::#{mod}")
end

def methodize mod, method
  klass = modularize(mod.capitalize)
  check_publicity(klass, method)
  klass.method(method.to_sym)
end

def check_publicity klass, method
  unless klass.methods(false).include?(method.to_sym)
    raise NameError.new(
      "#{klass}.#{method} is not allowed.  Must not be an inherited method.",
      "#{klass}.#{method}"
    )
  end
end
