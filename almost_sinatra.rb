%w.rack tilt backports INT TERM..map{|l|trap(l){$r.stop}rescue require l}
$n=Sinatra=Module.new{extend Rack;a,D,S,$p,q,Application=Builder.new,Object.method(:define_method),/@@ *([^\n]+)\n((?:(?:(?!@@))[^\n]*\n)*)/m,4567,a
%w[get post put delete].map{|m|D.(m){|u,&b|a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[a.instance_eval(&b)]]}}}}
Tilt.mappings.map{|k,v|D.(k){|n,*o|$t||=Hash[File.read(caller[0][/^[^:]+/]).scan(S)];v.new(*o){n.to_s==n ?n:$t[n.to_s]}.render(a,o[0].try(:[],:locals)||{})}}
%w[set enable disable configure helpers use register].map{|m|D.(m){|*_,&b|b.try :[]}};END{Handler.get("webrick").run(a,Port:$p){|s|$r=s}}
%w[params session].map{|m|D.(m){q.send m}};a.use Session::Cookie;a.use Lock
D.(:before){|&b|a.use Rack::Config,&b};before{|e|q=Request.new e;params.update(Hash[q.params.dup])}}
puts "== almost #$n/No Version has taken the stage on #$p for development with backup from Webrick"
