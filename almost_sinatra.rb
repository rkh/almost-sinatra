['rack', 'tilt', 'backports', :INT, :TERM].map{|l|(l==l.to_s)?(require(l)):(trap(l){$r.stop})}
R=Rack;$n=Sinatra=Module.new{$a,$o,$d,$h,$s,$f,$p=R::Builder.new,Object,:define_method,Hash,/@@ *([^\n]+)\n(((?!@@)[^\n]*\n)*)/m,File,4567;Application=$a}
%w[get post put delete].map{|m|$o.send($d,m){|u,&b|$a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[$a.instance_eval(&b)]]}}}}
Tilt.mappings.map{|k,v|$o.send($d,k){|n,*o|$t||=$f.read(caller.first[/^[^:]+/]).scan($s).inject({}){|h,(a,b,c)|h[a]=b;h};v.new(*o){(n.to_s==n)?(n):($t[n.to_s])}.render($a,o[0].try(:[],:locals)||{})}}
%w[set enable disable configure helpers use register].map{|m|$o.send($d,m){|*_,&b|b.try(:[])}};at_exit{R::Handler.get("webrick").run($a,:Port=>$p){|s|$r=s}}
['params', 'session', R::Session::Cookie, R::Lock].map{|m|(m==m.to_s)?($o.send($d,m){$q.send(m)}):($a.use(m))}
$o.send($d,:before){|&b|$a.use(R::Config,&b)};before{|e|$q=R::Request.new(e);$q.params.dup.map{|k,v|params[k.to_sym]=v}}
puts "== Almost #$n/No Version has taken the stage on #$p for development with backup from Webrick"
