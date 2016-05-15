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
  erb :index, locals: { modules: Faker.constants.sort.map { |const| Kernel.const_get("Faker::#{const}") } }
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

def methodize mod, method
  klass = Kernel.const_get("Faker::#{mod.capitalize}")
  check_publicity(klass, method)
  klass.public_method(method.to_sym)
end

def check_publicity klass, method
  unless klass.public_methods(false).include?(method.to_sym)
    raise NameError.new(
      "#{klass}.#{method} is not allowed.  Must not be an inherited method.",
      "#{klass}.#{method}"
    )
  end
end
