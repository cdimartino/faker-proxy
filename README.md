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

##Try me!

Yes - we are live folks:

[http://faker-proxy.herokuapp.com]
