[u,p,M,J,e,w]=[/\bapplication\/x-www-form-urlencoded\b/,4567,Math,JSON,((d,s)->d[k]=(if d[k]instanceof Array then d[k].concat v else v)for k,v of s;d),(s,c)->s.split(/\s+/).map c]
[http,url,qs,async,WS,E,haml,ejs]=w 'http url querystring async faye-websocket vault/node/aes haml ejs',require

class A
  [@b,@r,@h,@t]=[[],[],{},{}]
  constructor:(@request,@response,@_m)->
    [h,c]=[{},(@request.headers.cookie||'').split /\s*;\s*/];c.map((p)->q=p.split '=';h[q[0]]=q[1]);@cookies=h;new E(A.session_secret).decrypt h.session||'',(x,j)=>
      @session=(if x then{}else J.parse(j));@_u=url.parse(@request.url,true);@_h='Set-Cookie':[];e @,A.h;@_b=A.r.filter((r)=>r[0]==@_m&&r[2].test @_u.pathname)[0]
      if @_b then[@params,@_a,d]=[{splat:[]},[],@_u.pathname.match @_b[2]];(v=decodeURIComponent d[i+1];@_a.push v;if k=='*' then @params.splat.push v else @params[k]=v)for k,i in @_b[1];e @params,(if u.test @request.headers['content-type']then qs.parse @request.body else @_u.query);@_c()
  _x:(c)->@_c= =>async.series A.b.map((f)=> =>f.apply @,arguments).concat =>if @_b then c.call @,(=>@_b[3].apply @,@_a)else @response.writeHead 404,{};@response.end()
  render:(s)->h=new E(A.session_secret).encrypt J.stringify(@session),(x,j)=>h='Set-Cookie':['session=' + j + '; Path=/; HttpOnly'],'Content-Type':'text/html','Content-Length':new Buffer(s,'utf8').length;e h,@_h;@response.writeHead @_s||200,h;@response.end s

e A.prototype,headers:((o)->e @_h,o),status:((n)->@_s=parseInt n,10),haml:((n)->@render haml(A.t[n]) @),ejs:((n,o)->@render ejs.render A.t[n],e o?.locals||{},A.h),puts:(s)->console.log s

w 'get post put delete patch head options websocket eventsource',(v)->A[v]=(p,f)->
  o=(p.match(/[\/\.](\*|:[a-z\_\$][a-z0-9\_\$]*)/g)||[]).map((s)->s.replace /^[^a-z0-9\_\$\*]*/, '');m=new RegExp('^'+p.replace(/([\/\.])/g,'\\$1').replace(/\*|:[a-z\_\$][a-z0-9\_\$]*/ig,'(.+?)')+'$');@r.push [v.toUpperCase(),o,m,f]

e A,before:((b)->@b.push b),helpers:((o)->e @h,o),template:((n,t)->@t[n]=t),run:(q)->http.createServer(@call).on('upgrade',@ws).listen q||p

A.call=(req,res)->
  req.setEncoding 'utf8';b='';req.on('data',(s)->b+=s);req.on 'end',->
    req.body=b;ES=WS.EventSource;k=ES.isEventSource req;a=new A(req,res,if k then 'EVENTSOURCE' else req.method)
    if k then(a._x (h)->s=a.socket=new ES req,res;h();s.addEventListener 'close',->s=null)else(a._x (h)->r=h();if typeof r=='string'then @render r)

A.ws=(r,s,h)->a=new A(r,s,'WEBSOCKET');a._x (H)->w=a.socket=new WS r,s,h;H();w.addEventListener 'close',->w=null

module.exports=A

