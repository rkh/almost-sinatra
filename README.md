# Almost Sinatra

    “until programmers stop acting like obfuscation is morally hazardous,
    they’re not artists, just kids who don’t want their food to touch.” - _why

I ported @rkh's `almost-sinatra` to CoffeeScript, for the lolz, and then I got
carried away. Berlin is a strange and wonderful place.

So, what can this version do?

* Route requests based on method and pathname
* Respond to `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, `HEAD`, `OPTIONS`
* Handle WebSocket and EventSource connections
* Path-based pattern matching with `:named` and `*` matchers
* Construct params from path data, query strings and entity bodies
* Read and create cookies
* Self-contained encrypted session cookies
* Set status code and headers
* Render EJS, HAML and raw text
* Serve static files
* Define helper functions for request handlers and templates


## Run the example

```bash
git clone git://github.com/jcoglan/almost-sinatra.git
cd almost-sinatra
git checkout coffee
npm install
./node_modules/.bin/coffee example.coffee
```


### Hello world

```coffee
app = require './almost_sinatra'

app.get '/', -> 'Hello, world!'

app.run 4567
```


### Settings

    app.public = __dirname + '/public' # where to find static files
    app.views  = __dirname + '/views'  # where to find view templates
    app.session_secret = 'abcde12345'  # key for encrypting sessions


### Handling HTTP methods, statuses, headers, etc.

```coffee
app.get '/confs/:name', ->
  JSON.stringify @params

app.put '/confs/:name', (name) ->
  name

app.get '/download/*.*', ->
  @params.splat.join ', '

app.post '/confs', ->
  @status 201
  @headers 'Content-Type': 'application/json'
  JSON.stringify @params

app.options '/', ->
  @headers
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, PUT, DELETE'
  @render ''
```

This app responds like so:

```bash
$ curl 'localhost:4567/confs/eurucamp?bears=awesome'
{"name":"eurucamp","bears":"awesome"}

$ curl -X PUT localhost:4567/confs/jsconf
jsconf

$ curl localhost:4567/download/foo.js
foo, js

$ curl -iX POST localhost:4567/confs -d 'horses=fake'
HTTP/1.1 201 Created
Content-Type: application/json
Content-Length: 17
Set-Cookie: session=XABfKjq2xvCavSitaxu0BC9XSl...; Path=/; HttpOnly
Date: Sun, 19 Aug 2012 09:13:00 GMT
Connection: keep-alive

{"horses":"fake"}

$ curl -iX OPTIONS localhost:4567/
HTTP/1.1 200 OK
Content-Type: text/html
Content-Length: 0
Set-Cookie: session=h7HwIkvXA0xcZk7JhmoVK25qNH...; Path=/; HttpOnly
Access-Control-Allow-Origin: *
Access-Control-Allow-Methods: GET, PUT, DELETE
Date: Sun, 19 Aug 2012 09:13:42 GMT
Connection: keep-alive
```


### Wait, are those session cookies?

```coffee
app.get '/counter', ->
  @session.counter ||= 0
  @session.counter += 1
  @render @session.counter.toString()
```


### Reading and setting cookies

```coffee
app.get '/', ->
  @cookie my_cookie: 'hello'
  @cookie another_cookie: {value: 'something', path: '/welcome', expires: new Date(2012,11,25), http: true}

app.get '/welcome', ->
  @render @cookies.my_cookie
```


### Helpers, EJS and HAML

```coffee
app.views = __dirname + '/views'

app.helpers
  site_name: -> 'Awesome.net'

app.get '/hello', ->
  @ejs 'hello', locals: {name: @params.name}
```

```erb
# views/hello.ejs
Hello <%= name %>, welcome to <%= site_name() %>!
```

You can use `@ejs` or `@haml` to render a template. `@render` just takes a
string and writes it to the response body. If your route handler returns a
string, that string will be the body. Otherwise, you must call a rendering
function.

```bash
$ curl 'localhost:4567/hello?name=_why'
Hello _why, welcome to Awesome.net!
```

You can also register templates in the app code itself:

```coffee
app.template 'hello.ejs', """
Hello <%= name %>, welcome to <%= site_name() %>!
"""
```


### Context groups

You can set up a set of routes with a common prefix and add before-filters that
only apply to that context.

```coffee
app.get '/', -> 'Hello!'

app.context '/auth', (auth) ->
  auth.before (next) ->
    if @request.headers.authorization
      next()
    else
      @status 401
      @render 'Authorization required'
  
  auth.get '/', -> 'Secret'
```

```bash
$ curl localhost:4567/
Hello!
$ curl localhost:4567/auth
Authorization required
$ curl localhost:4567/auth -H 'Authorization: foo'
Secret
```

### Sockets!

```coffee
app.websocket '/ws/:name', ->
  @socket.onmessage = (e)=>
    @socket.send @params.name + ': ' + e.data

app.eventsource '/ws/:name', ->
  setInterval (=> @socket.send @params.name + ': PUSH!'), 5000
```


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
