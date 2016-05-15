Faker-Proxy
==========

I love the [Faker](stympy/faker) Gem.  It makes the awesomest data!  How to
embetter it?  What if you could harness the power of curl to get all your
Faker (tm) based needs?

Now you can!

This simple sinatra app will mirror the installed version of Faker, allowing
proxied calls to be passed to the module and returned in a nice JSON wrapper.

##Usage

GET routes are supported, with the following syntax:

```
/<module name>/<method name>[/any/optional/arguments/needed]
```

Any additional arguments past the method name are split on the `/' and curried
to the desired method.

##API

I can do what Faker can do! Explore an [automatically generated](https://faker-proxy.herokuapp.com/methods)
view of the Faker API see what data it can fake for you today.  All methods are clickable refs and
will excercise the API.

##Try me!

[Yes - we are live folks!](http://faker-proxy.herokuapp.com)

```sh
curl http://faker-proxy.herokuapp.com/team/name
"Arkansas sorcerors"

curl http://faker-proxy.herokuapp.com/hipster/words
["retro","chicharrones","cronut"]

curl http://faker-proxy.herokuapp.com/hipster/words/42
["chicharrones","plaid","forage","pop-up","distillery","slow-carb","forage","selfies","portland","aesthetic","sustainable","lumbersexual","ramps","microdosing","Godard","semiotics","heirloom","gentrify","post-ironic","hammock","squid","fap","scenester","williamsburg","vinegar","locavore","artisan","90's","health","actually","freegan","paleo","cold-pressed","cliche","stumptown","cleanse","wolf","austin","8-bit","bespoke","gastropub","authentic"]%
```
