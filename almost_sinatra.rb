%w.rack tilt backports INT TERM..map{|l|trap(l){R.stop}rescue require l}
$n=Sinatra=Module.new{extend Rack;a=Application=Builder.new;D,P,q=Object.method(:define_method),4567
%w[get post put delete].map{|m|D.(m){|u,&b|a.map(u){run->(e){[200,{"Content-Type"=>"text/html"},[a.instance_eval(&b)]]}}}}
Tilt.mappings.map{|k,v|D.(k){|n,*o|$t||=(h={};File.read(caller[0][/^[^:]+/]).scan(/@@ *([^
]+)
(((?!@@)[^
]*
)*)/m){h[$1]=$2};h);v.new(*o){n==(z=n.to_s)?n:$t[z]}.render(a,o[0].try(:[],:locals)||{})}}
%w[set enable disable configure helpers use register].map{|m|D.(m){|*,&b|b.try :[]}};END{Handler.get(W).run(a,Port:P){|s|R=s}}
%w[params session].map{|m|D.(m){q.send m}};a.use Session::Cookie;a.use Lock
D.(:before){|&b|a.use Rack::Config,&b};before{|e|q=Request.new e;q.params.dup.map{|k,v|params[k.to_sym]=v}}
}
puts"== almost #$n/No Version has taken the stage on #{P} for development with backup from "+W="WEBrick"
