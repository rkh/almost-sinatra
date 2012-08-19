[u,M,e,w,z]=[/\bapplication\/x-www-form-urlencoded\b/,Math,((d,s)->d[k]=v for k,v of s),((s,c)->s.split(/\s+/).map c),(d,s)->(d[k]=if d[k]instanceof Array then d[k].concat v else v) for k,v of s]
[http,url,qs,haml,ejs]=w 'http url querystring haml ejs',require

class Session
  constructor:(id)->@__id__=id
  @s={}

Session.get=(r)->
  [h,c]=[{},(r.headers.cookie||'').split(/\s*;\s*/)];c.map (p)->q=p.split('=');h[q[0]]=q[1]
  i=h.sessid||[1..4].map(->M.floor(M.random()*M.pow(2,40)).toString 36).join '';@s[i]||=new @(i)

class App
  [@b,@r,@h,@t]=[[],[],{},{}]
  constructor:(@req,@res,@_h={})->@_u=url.parse(@req.url,true);@session=Session.get(@req);z @_h,'Set-Cookie':['sessid='+@session.__id__+'; Path=/; HttpOnly'];e @,App.h
  parse:(c)->
    @req.setEncoding('utf8');b='';@req.on('data',(s)->b+=s);@req.on 'end',=>
      @body=b;@params=(if u.test @req.headers['content-type']then qs.parse b else @_u.query);c()
  headers:(o)->z @_h,o
  status:(n)->@_s=parseInt(n,10)
  render:(s)->h='Content-Type':'text/html','Content-Length':new Buffer(s,'utf8').length;z h,@_h;@res.writeHead @_s||200,h;@res.end s
  haml:(n)->@render haml(App.t[n])(@)
  ejs:(n,o)->@render ejs.render(App.t[n],o?.locals)
  puts:(s)->console.log s

w 'get post put delete patch head options',(v)->App[v]=(p,f)->@r.push [v.toUpperCase(),p,f]

e App,before:((b)->@b.push b),helpers:((o)->e @h,o),template:((n,t)->@t[n]=t),run:->http.createServer(@handle).listen(4567)

App.handle=(req,res)->
  a=new App(req,res);p=url.parse(req.url).pathname;App.b.map (b)->b.call a
  b=App.r.filter((r)->r[0]==req.method&&r[1]==p)[0]
  if b then(a.parse ()->r=b[2].call a;if typeof r=='string'then a.render r)else(res.writeHead 404,{};res.end())

module.exports=App
