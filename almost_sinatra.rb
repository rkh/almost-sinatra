%w.rack tilt backports INT TERM..map{|l|trap(l){$r.stop}rescue require(l)}
R=Rack;$n=Sinatra=Module.new{A,D,S,$p=R::Builder.new,Object.method(:define_method),/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m,4567;Application=A}
%w[get post put delete].map{|m|D.(m){|u,&b|A.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[A.instance_eval(&b)]]}}}}
Tilt.mappings.map{|k,v|D.(k){|n,*o|$t||=(h={};File.read(caller[0][/^[^:]+/]).scan(S){|a,b|h[a]=b};h);v.new(*o){(n.to_s==n)?(n):($t[n.to_s])}.render(A,o[0].try(:[],:locals)||{})}}
%w[set enable disable configure helpers use register].map{|m|D.(m){|*_,&b|b.try(:[])}};END{R::Handler.get("webrick").run(A,Port:$p){|s|$r=s}}
%w[params session].map{|m|D.(m){$q.send(m)}};A.use(R::Session::Cookie);A.use(R::Lock)
D.(:before){|&b|A.use(R::Config,&b)};before{|e|$q=R::Request.new(e);$q.params.dup.map{|k,v|params[k.to_sym]=v}}
puts "== Almost #$n/No Version has taken the stage on #$p for development with backup from Webrick"
=======
%w[rack tilt backports].map{|l|require l};[:INT,:TERM].map{|l|trap(l){$r.stop}}
$n=Sinatra=Module.new{$a,$o,$d,$s,$p=Rack::Builder.new,Object,:define_method,/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m,4567;Application=$a}
%w[get post put delete].map{|m|$o.send($d,m){|u,&b|$a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[$a.instance_eval(&b)]]}}}}
Tilt.mappings.map{|k,v|$o.send($d,k){|n,*o|$t||=File.read(caller[0][/^[^:]+/]).scan($s).inject({}){|h,(a,b,c)|h[a]=b;h};v.new(*o){(z=n.to_s)==n ?n:$t[z]}.render $a,o[0].try(:[],:locals)||{}}}
%w[set enable disable configure helpers use].map{|m|$o.send($d,m){|*_,&b|b.try :[]}};END{Rack::Handler.get("webrick").run($a,:Port=>$p){|s|$r=s}}
['params','session',Rack::Session::Cookie,Rack::Lock].map{|m|(m==m.to_s)?$o.send($d,m){$q.send m}:$a.use(m)}
$o.send($d,:before){|&b|$a.use Rack::Config,&b};before{|e|$q=Rack::Request.new e;$q.params.dup.map{|k,v|params[k.to_sym]=v}}
puts"== Almost #$n/No Version has taken the stage on #$p for development with backup from Webrick"
>>>>>>> d1fb6d8... yeah! beneath 2**10
