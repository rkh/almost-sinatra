[u,p,M,e,w]=[/\bapplication\/x-www-form-urlencoded\b/,4567,Math,((d,s)->d[k]=(if d[k]instanceof Array then d[k].concat v else v)for k,v of s),(s,c)->s.split(/\s+/).map c]
[http,url,qs,haml,ejs]=w 'http url querystring haml ejs',require

class Session
  constructor:(id)->@__id__=id
  @s={}

Session.get=(r)->
  [h,c]=[{},(r.headers.cookie||'').split(/\s*;\s*/)];c.map (p)->q=p.split('=');h[q[0]]=q[1]
  i=h.sessid||[1..4].map(->M.floor(M.random()*M.pow(2,40)).toString 36).join '';@s[i]||=new @(i)

class App
  [@b,@r,@h,@t]=[[],[],{},{}]
  constructor:(@req,@res,@_h={})->@_u=url.parse(@req.url,true);@session=Session.get(@req);e @_h,'Set-Cookie':['sessid='+@session.__id__+'; Path=/; HttpOnly'];e @,App.h
  parse:(p,c)->
    @req.setEncoding('utf8');b='';@req.on('data',(s)->b+=s);@req.on 'end',=>
      [@params,d]=[{},@_u.pathname.match p[2]];@params[k]=decodeURIComponent d[i+1]for k,i in p[1];@body=b
      e @params,(if u.test @req.headers['content-type']then qs.parse b else @_u.query);c()
  headers:(o)->e @_h,o
  status:(n)->@_s=parseInt(n,10)
  render:(s)->h='Content-Type':'text/html','Content-Length':new Buffer(s,'utf8').length;e h,@_h;@res.writeHead @_s||200,h;@res.end s
  haml:(n)->@render haml(App.t[n]) @
  ejs:(n,o)->@render ejs.render App.t[n],o?.locals
  puts:(s)->console.log s

w 'get post put delete patch head options',(v)->App[v]=(p,f)->
  o=(p.match(/[\/\.]:[a-z\_\$][a-z0-9\_\$]*/g)||[]).map (s)->s.substr 2
  x=new RegExp('^'+p.replace(/([\/\.])/g,'\\$1').replace(/:[a-z\_\$][a-z0-9\_\$]*/ig,'([^\\/]+?)')+'$')
  @r.push [v.toUpperCase(),o,x,f]

e App,before:((b)->@b.push b),helpers:((o)->e @h,o),template:((n,t)->@t[n]=t),run:->http.createServer(@handle).listen p

App.handle=(req,res)->
  a=new App(req,res);App.b.map((b)->b.call a);b=App.r.filter((r)->r[0]==req.method&&r[2].test a._u.pathname)[0]
  if b then(a.parse b,->r=b[3].call a;if typeof r=='string'then a.render r)else(res.writeHead 404,{};res.end())

module.exports=App

