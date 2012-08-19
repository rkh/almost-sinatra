app = require './almost_sinatra'

app.helpers
  inc_counter: ->
    @session.counter ||= 0
    @session.counter += 1

app.before ->
  @puts "yay! got a request!"

app.get '/', ->
  @title = 'Almost Sinatra'
  @haml 'index'

app.get '/hello', ->
  @ejs 'hello', locals: {name: @params.name}

app.get '/words/:category/:id.:format', ->
  JSON.stringify @params

app.get '/counter', ->
  @inc_counter()
  @render @session.counter.toString()

app.post '/', ->
  @status 201
  @headers 'Content-Type': 'application/json'
  JSON.stringify(@params)

app.options '/', ->
  @headers 'Access-Control-Allow-Methods': 'GET, PUT, DELETE'
  @render ''

app.template 'index', """
%html
  %head
    %title= title
  %body
    %a{href: '/hello?name=World'} Say hello!
    %a{href: '/counter'} Show Counter
"""

app.template 'hello', """
Hello <%= name %>!
"""

app.run()