until defined? Sinatra
  puts "What Sinatra implementation should I use?",
    "[R]eal Sinatra", "[A]lmost Sinatra"
  print ">> "
  case gets.strip.downcase
  when 'a' then require_relative "almost_sinatra"
  when 'r' then require 'sinatra'
  else puts "invalid input!!"
  end
end

configure do
  enable :sessions
end

helpers do
  def inc_counter
    session[:counter] ||= 0
    session[:counter] += 1
  end
end

before do
  puts " yay! got a request ".center(80, "=")
end

get '/' do
  @title = "Almost Sinatra"
  haml :index
end

# /hello?name=world
get '/hello' do
  erb :hello, locals: { name: params[:name] }
end

get '/counter' do
  inc_counter
  session[:counter].to_s
end

__END__

@@ index
%html
  %head
    %title= @title
  %body
    %a{:href => '/hello?name=World'} Say hello!
    %a{:href => '/counter'} Show Counter

@@ hello
Hello <%= name %>!
