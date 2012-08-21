app = require '../almost_sinatra'

app.public = __dirname + '/public'
app.views  = __dirname + '/views'
app.session_secret = 'abc123'

app.helpers
  inc_counter: ->
    @session.counter ||= 0
    @session.counter += 1
  
  site_name: ->
    'Awesome.net'

app.before (next) ->
  @puts @request.method + ' ' + @request.url
  next()

app.get '/', ->
  @cookie message: {value: 'Sinatra', path: '/hello', http: true}
  @title = 'Almost Sinatra'
  @haml 'index'

app.get '/hello', ->
  @ejs 'hello', locals: {name: @params.name, message: @cookies.message}

app.get '/counter', ->
  @inc_counter()
  @render @session.counter

app.get '/words/:category/:id.:format', ->
  JSON.stringify @params

app.get '/download/*.*', ->
  @params.splat.join ', '

app.put '/download/*.*', (path, ext) ->
  [path, ext].join ' // '

app.post '/', ->
  @status 201
  @headers 'Content-Type': 'application/json'
  JSON.stringify @params

app.options '/', ->
  @headers 'Access-Control-Allow-Methods': 'GET, PUT, DELETE'
  @render ''

app.websocket '/ws/:name', ->
  @socket.onmessage = (e)=>
    @socket.send @params.name + ': ' + e.data

app.eventsource '/ws/:name', ->
  setInterval (=> @socket.send @params.name + ': PUSH!'), 5000

app.template 'hello.ejs', """
Hello <%= name %>, welcome to <%= site_name() %>! Cookie: <%= message %>
"""

app.run 4567
