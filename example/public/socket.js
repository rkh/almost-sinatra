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

