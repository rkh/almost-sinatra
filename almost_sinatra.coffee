[M,w,e]=[Math,((s)->s.split(/\s+/)),(d,s)->d[k]=v for k,v of s];[http,url,haml,ejs]=w('http url haml ejs').map require

class Session
  constructor:(id)->@__id__=id
  @s={}

Session.get=(r)->
  [h,c]=[{},(r.headers.cookie||'').split(/\s*;\s*/)];c.map (p)->q=p.split('=');h[q[0]]=q[1]
  i=h.sessid||M.floor(M.random()*M.pow(2,52)).toString 36;@s[i]||=new @(i)

class App
  [@b,@r,@h,@t]=[[],[],{},{}]
  constructor:(@req, @res)->@_url=url.parse(@req.url,true);@params=@_url.query;@session=Session.get(@req);e @,App.h
  render:(s)->h='Content-Type':'text/html','Set-Cookie':'sessid='+@session.__id__;@res.writeHead 200,h;@res.end s
  haml:(n)->@render haml(App.t[n])(@)
  ejs:(n,o)->@render ejs.render(App.t[n],o?.locals)
  puts:(s)->console.log s

w('get post put delete patch').map (v)->App[v]=(p,f)->App.r.push [v.toUpperCase(),p,f]

e App,before:((b)->@b.push b),helpers:((o)->e @h,o),template:((n,t)->@t[n]=t),run:->http.createServer(@handle).listen(4567)

App.handle=(req,res)->
  a=new App(req,res);p=url.parse(req.url).pathname;App.b.map (b)->b.call a
  b=App.r.filter((r)->r[0]==req.method&&r[1]==p)[0]
  if b then (b[2].call a) else (res.writeHead 400,{};res.end())

module.exports = App
