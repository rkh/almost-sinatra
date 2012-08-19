# Almost Sinatra

    “until programmers stop acting like obfuscation is morally hazardous,
    they’re not artists, just kids who don’t want their food to touch.” - _why

I ported @rkh's `almost-sinatra` to CoffeeScript, for the lolz, and then I got
carried away. Berlin is a strange and wonderful place.

So, what can this version do?

* Route requests based on method and pathname
* Respond to `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, `HEAD`, `OPTIONS`
* Handle WebSocket connections
* Construct params from path data, query strings and entity bodies
* Has in-memory session support
* Set status code and headers
* Render EJS, HAML and raw text
* Define helper functions for request handlers and templates


## Run the example

    git clone git://github.com/jcoglan/almost-sinatra.git
    cd almost-sinatra
    git checkout coffee
    npm install
    ./node_modules/.bin/coffee example.coffee


### Hello world

    app = require './almost_sinatra'
    
    app.get '/', -> 'Hello, world!'
    
    app.run 4567


### Handling HTTP methods, statuses, headers, etc.

    app.get '/confs/:name', ->
      JSON.stringify @params
    
    app.post '/confs', ->
      @status 201
      @headers 'Content-Type: application/json'
      JSON.stringify @params
    
    app.options '/', ->
      @headers
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, PUT, DELETE'
      @render ''

This app responds like so:

    $ curl 'localhost:4567/confs/eurucamp?bears=awesome'
    {"name":"eurucamp","bears":"awesome"}
    
    $ curl -iX POST localhost:4567/confs -d 'horses=fake'
    HTTP/1.1 201 Created
    Content-Type: application/json
    Content-Length: 17
    Set-Cookie: sessid=cb3npo8wcb66t62o88nps16onxl2g3k; Path=/; HttpOnly
    Date: Sun, 19 Aug 2012 09:13:00 GMT
    Connection: keep-alive
    
    {"horses":"fake"}
    
    $ curl -iX OPTIONS localhost:4567/
    HTTP/1.1 200 OK
    Content-Type: text/html
    Content-Length: 0
    Set-Cookie: sessid=6xbt2xogcbo6f5z48h153k74dvy4j01s; Path=/; HttpOnly
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Methods: GET, PUT, DELETE
    Date: Sun, 19 Aug 2012 09:13:42 GMT
    Connection: keep-alive


### Wait, are those session cookies?

    app.get '/counter', ->
      @session.counter ||= 0
      @session.counter += 1
      @render @session.counter.toString()

Try it out:

    $ curl localhost:4567/counter -H 'Cookie: sessid=6xbt2xogcbo6f5z48h153k74dvy4j01s'
    1
    $ curl localhost:4567/counter -H 'Cookie: sessid=6xbt2xogcbo6f5z48h153k74dvy4j01s'
    2
    $ curl localhost:4567/counter -H 'Cookie: sessid=6xbt2xogcbo6f5z48h153k74dvy4j01s'
    3


### Helpers, EJS and HAML

    app.helpers
      site_name: -> 'Awesome.net'
    
    app.template 'hello', """
    Hello <%= name %>, welcome to <%= site_name() %>!
    """
    
    app.get '/hello', ->
      @ejs 'hello', locals: {name: @params.name}

You can use `@ejs` or `@haml` to render a template. `@render` just takes a
string and writes it to the response body. If your route handler returns a
string, that string will be the body. Otherwise, you must call a rendering
function.

    $ curl 'localhost:4567/hello?name=_why'
    Hello _why, welcome to Awesome.net!


### WebSockets!

    app.websocket '/ws/:name', (ws) ->
      ws.onmessage = (e)=>
        ws.send @params.name + ': ' + e.data


## License

(The MIT License)

Copyright (c) 2012 James Coglan

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the 'Software'), to deal in
the Software without restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
