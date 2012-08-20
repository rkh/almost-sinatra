app = require './almost_sinatra'

app.session_secret = 'abc123'

app.helpers
  inc_counter: ->
    @session.counter ||= 0
    @session.counter += 1
  
  site_name: ->
    'Awesome.net'

app.before (next) ->
  @puts 'yay! got a request!'
  next()

app.get '/', ->
  @title = 'Almost Sinatra'
  @haml 'index'

app.get '/download/*.*', ->
  @params.splat.join ', '

app.put '/download/*.*', (path, ext) ->
  [path, ext].join ' // '

app.get '/js/socket.js', ->
  @headers 'Content-Type': 'text/javascript'
  @ejs 'socket'

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
  JSON.stringify @params

app.options '/', ->
  @headers 'Access-Control-Allow-Methods': 'GET, PUT, DELETE'
  @render ''

app.websocket '/ws/:name', ->
  @socket.onmessage = (e)=>
    @socket.send @params.name + ': ' + e.data

app.eventsource '/ws/:name', ->
  setInterval (=> @socket.send @params.name + ': PUSH!'), 5000

app.template 'index', """
%html
  %head
    %title= title
  %body
    %p= site_name()
    %a{href: '/hello?name=World'} Say hello!
    %a{href: '/counter'} Show Counter
    %ul{id: 'log'}
    %script{src: '/js/socket.js'}
"""

app.template 'socket', """
var write = function(data) {
  var log = document.getElementById('log'),
      li  = document.createElement('li');
  li.innerHTML = data;
  log.appendChild(li);
};

var ws = new WebSocket('ws://localhost:4567/ws/awesome');
ws.onmessage = function(e) {
  write(e.data);
  setTimeout(function() { ws.send('Loop') }, 2000)
};
ws.onopen = function() { ws.send('Ping!') };

var es = new EventSource('http://localhost:4567/ws/eurucamp');
es.onmessage = function(e) {
  write(e.data);
};
"""

app.template 'hello', """
Hello <%= name %>, welcome to <%= site_name() %>!
"""

app.run 4567
