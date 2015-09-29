# Procs

The term 'Proc' is short for Procedure. A proc is simply a block assigned to a variable that can be reused. 

Let's look at an example:

```ruby
doubler = Proc.new do | num | 
	num * 2
end

puts doubler.call(4)
puts doubler.call(10)
```

Procs can be passed as parameters to methods like any old object:

```ruby 
def looper(callback, list)
	list.each { | item | puts callback.call(item) }
end

doubler = Proc.new do | num | 
	num * 2
end

tripler = Proc.new do | num | 
	num * 3
end

arr = [1,2,3]

looper(doubler, arr)
looper(tripler, arr)
```

You may refer to objects being called POROs. This is an acronym for Plain Old Ruby Object. This may have been adapted from POJOs in Java.

React.io has some advice on when to use blocks over Procs
* Block: Your method is breaking an object down into smaller pieces, and you want to let your users interact with these pieces.
* Block: You want to run multiple expressions atomically, like a database migration.
* Proc: You want to reuse a block of code multiple times.
* Proc: Your method will have one or more callbacks.


