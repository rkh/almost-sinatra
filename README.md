# Almost Sinatra

    "until programmers stop acting like obfuscation is morally hazardous,
    they’re not artists, just kids who don’t want their food to touch." - _why

A Sinatra implementation in less than 10 lines.
Dependencies: Tilt and Rack (like Sinatra).
Only works on Ruby 1.9.

Features:

* all template engines Sinatra supports
* get/post/put/delete
* before filters
* configure/set/enable/disable/...
* session/params
* support for helpers
* stand alone usage
* inline templates
* thread safe
* works with Padrino

It is considered fully compatible with Sinatra. If your app does not run with
Almost Sinatra, please open a [Sinatra issue](https://github.com/sinatra/sinatra/issues).

## Installation

Copy the contents of `almost_sinatra.rb` into your app file (at the top), that
way you also avoid running the wrong version by accident.

## Try it

    $ ruby example.rb
    What Sinatra implementation should I use?
    [R]eal Sinatra
    [A]lmost Sinatra
    >> a

## Modular style

When pasting the Almost Sinatra code into your file, replace `Application=$a`
with `Base=$a` (second line atm, but don't expect me to update the readme if
I move stuff around).

## Performance

It's just amazing. No code is faster than no code.

    $ sloccount alomst_sinatra.rb
    Total Physical Source Lines of Code (SLOC)                = 8
    Development Effort Estimate, Person-Years (Person-Months) = 0.00 (0.02)
     (Basic COCOMO model, Person-Months = 2.4 * (KSLOC**1.05))
    Schedule Estimate, Years (Months)                         = 0.04 (0.51)
     (Basic COCOMO model, Months = 2.5 * (person-months**0.38))
    Estimated Average Number of Developers (Effort/Schedule)  = 0.03
    Total Estimated Cost to Develop                           = $ 170
     (average salary = $56,286/year, overhead = 2.40).

    $ sloccount ../sinatra
    Total Physical Source Lines of Code (SLOC)                = 5,771
    Development Effort Estimate, Person-Years (Person-Months) = 1.26 (15.12)
     (Basic COCOMO model, Person-Months = 2.4 * (KSLOC**1.05))
    Schedule Estimate, Years (Months)                         = 0.58 (7.02)
     (Basic COCOMO model, Months = 2.5 * (person-months**0.38))
    Estimated Average Number of Developers (Effort/Schedule)  = 2.15
    Total Estimated Cost to Develop                           = $ 170,198
     (average salary = $56,286/year, overhead = 2.40).

As you can see Sinatra is 1000000% more expensive than Almost Sinatra!

Generated using David A. Wheeler's 'SLOCCount'.

## Coding guidelines

* keep code under ten lines, this includes require and whatnot

* avoid spaces and newlines if possible

* wrap at 200 characters to make it readable on a terminal

* newlines may be used instead of `;` to improve readability

* use `map` instead of `each`, it's shorter

* store constants in global variables to dry up your code (like `$f = File`)

* if you have one loop, reuse it. instead of this:

        ['a','b'].map{|e|...}
        [Rack::Something].map{|e|...}

  do this:

        ['a','b',Rack::Something].map{|e|(e==e.to_s)?(...):(...)}

  Saves a line!

* `e=="#{e}"` is shorter than `e.is_a? String` or `String===e`

* use `->{}` instead of `proc` or `lambda` (this is why it depends on 1.9)

* add methods for class scope to `$o` and for instance scope to `$a` (or `$o`),
  see [Scopes And Binding](http://www.sinatrarb.com/intro#Scopes%20and%20Binding)

* don't include tests. tests just bloat the code base. just commit, the users
  will complain if you break anything.

## About Versioning

Versions are to Software what Subversion is to Git.
