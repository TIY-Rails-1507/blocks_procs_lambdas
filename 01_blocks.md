# Blocks

Blocks, procs, and Lambdas, are all different ways of creating closures. A closure is a block of code that has access to variables which were in scope when the block was created.

Blocks are deceptively simple. We start by defining an innocent block and then move onto more complex examples.

# Blocks

Blocks are defined as follows:

```ruby
{ puts "Hello from block" }
```
And 

```ruby
do 
	puts "Hello from block"
end
```

The convention is to use the `{` `}` when the block is only one line. Use the `do` `end` for multi-line blocks. In most cases these two blocks behave the same. See below for the exception. 

## Using blocks

A block can be passed to a method. The method can then call the block, before the method has completed: 


```ruby
def greet
	yield
	puts "Hello from the method"
end

greet { puts "Hello from the block" }

```

Output
```
Hello from the block
Hello from the method
```

When 'yield' is called, the block is executed. It is common to say that the method is performing a 'callback'. Yield can be used multiple times:

```ruby
def greet
	yield
	puts "Hello from the method"
	yield
end

greet { puts "Hello from the block" }
```

Output
```
Hello from the block
Hello from the method
Hello from the block
```

It is possible to pass the block a parameter:

```ruby
def doubler(num)
	doubled = num * 2
	yield(doubled)	
end

number = 5
doubler(number) { | d | puts "#{number} doubled is #{d}" }
```
Output
```
5 doubled is 10
```

Obviously this could have been done with a standard method that returns a value. 

```ruby
def doubler(num)
	num * 2
end

number = 5
puts "#{number} doubled is #{doubler(number)}" 
```

We need to increase the complexity of the examples to see the real benefit of doing this. 

Let's assume that we want to print a list of 5 numbers. We would like to specify the starting number. Each number displayed should be double the previous number. 

First we will do this with a conventional approach:

```ruby
starting_number = 5
current_number = starting_number
5.times do
	puts current_number
	current_number = current_number * 2 
end
```
Output
```
5
10
20
40
80
```
While we have yet to impliment our specific example, we are already using a block - we pass a the block to the `times` method. In this case, it calls the block 5 times.

We could implement the above example using a method:

```ruby
def doubler(num)
	num * 2
end

starting_number = 5
current_number = starting_number
5.times do
	puts current_number
	current_number = doubler(current_number)
end
```
Output
```
5
10
20
40
80
```

Now we will convert the method to use a block:

```ruby
def doubler(num)
	curr_number = num
	5.times do
		yield curr_number
		curr_number = curr_number * 2
	end
end

starting_number = 5
doubler(starting_number) { | d | puts d  }

```
Output
```
5
10
20
40
80
```

In this case we displayed all the numbers to the screen, we could change it to write to a file without needing to change the `doubler` method.

Let's assume we wanted to display all the words in a list which are palindromes: 

```ruby
def palindromes(words)
	words.each do |word|
		if word == word.reverse
			yield word
		end  
	end
end

list = %w[ hello mom bob monday tattarrattat ruby detartrated ]  # a shortcut for creating an array of strings

palindromes(list) { | w | puts w }
```
Output
```
mom
bob
tattarrattat
detartrated
```

We could flip things around and make a method that collects words according to logic placed in the block:

```ruby 
def find_words(words)
	results = []
	words.each do |word|
		if yield(word)
			results << word
		end  
	end
	results
end

list = %w[ hello mom bob monday tattarrattat ruby detartrated ]  # a shortcut for creating an array of strings
palindromes = find_words(list) { | w | w == w.reverse }
not_palindromes = find_words(list) { | w | w != w.reverse }

puts "Palindromes:"
puts palindromes
puts "\nNot Palindromes:"
puts not_palindromes
```

Output
```
Palindromes:
mom
bob
tattarrattat
detartrated

Not Palindromes:
hello
monday
ruby
```

This is very similar to how the built in `select` method of `Array` work:

```ruby
list = %w[ hello mom bob monday tattarrattat ruby detartrated ]  # a shortcut for creating an array of strings
palindromes = list.select() { | w | w == w.reverse }
not_palindromes = list.select() { | w | w != w.reverse }

puts "Palindromes:"
puts palindromes
puts "\nNot Palindromes:"
puts not_palindromes
```
Output
```
Palindromes:
mom
bob
tattarrattat
detartrated

Not Palindromes:
hello
monday
ruby
```
We can now start to see the benefit of blocks. 


Here is another example where we reuse a method, passing in blocks to deal with different object types"

Moving from this:

```ruby
def map(list)
	result = []
	list.each do | item |
		result << yield(item)
	end
	result
end

str_list = %w[ hello from ruby] # a shortcut for creating an array of strings
str_result = map(str_list) { | curr | curr.upcase  }
puts str_result

num_list = [1,2,3]
num_result = map(num_list) { | curr | curr * curr  }
puts num_result
```

This map function is very similar to the built in one on Array:

```ruby
str_list = %w[ hello from ruby] # a shortcut for creating an array of strings
str_result = str_list.map() { | curr | curr.upcase  }
puts str_result

num_list = [1,2,3]
num_result = num_list.map { | curr | curr * curr  }
puts num_result
```

## Optional blocks

Some methods are written to with or without blocks

```
def palindromes(words)
	result = []
	words.each do |word|
		if word == word.reverse
			yield word if block_given?
			result << word
		end  
	end
end

list = %w[ hello mom bob monday tattarrattat ruby detartrated ]  
palindromes = palindromes(list)
puts palindromes
```

The method `block_given?` returns `true` if a block was provided.

## Passing a block as a named parameter

Until now we have used an 'implicit' block, and simply called `yield` when needed. It is possible to name the block and accept it in a similar way to regular parameters. 

Here is an 'implicit' block call:

```ruby
def doubler(num)
	doubled = num * 2
	yield(doubled)	
end

number = 5
doubler(number) { | d | puts "#{number} doubled is #{d}" }
```

Compared to an named clock:

```ruby
def doubler(num, &callback)
	doubled = num * 2
	callback.call(doubled)	
end

number = 5
doubler(number) { | d | puts "#{number} doubled is #{d}" }
```

The `callback` variable is the one to pay attention to. It starts with an `&`. Ruby will assign the `block` to this variable. We can then call the block with the `call` function. Note this is done without the `&`.

In this case we used a parameter name of `callback` however any valid variable name would work. It is common to use `block` as the variable name.

Here is an example of only calling the block if it was supplied:

```ruby
def palindromes(words, &block)
	result = []
	words.each do |word|
		if word == word.reverse
			block.call(word) if block
			result << word
		end  
	end
end

list = %w[ hello mom bob monday tattarrattat ruby detartrated ]  
palindromes = palindromes(list)
puts palindromes
```

The following code let's us observe the class of a block:

```ruby
def display(&block)
	puts block.class
end

display {}
```
Output
```
Proc
```

The class of a block is of type `Proc`. That is the topic of the next section.

#### A bit more on blocks

Creating a block with `{` `}` and `do` `end` is usually equivalent. However there is a difference when using method chaining. As explained by newrelic "if two methods are chained and a block is passed as an argument, the argument will apply to either the first or the second method, depending on the syntax".

```ruby
def first(arg = nil)
  yield('first') if block_given?
end

def second(arg = nil)
  yield('second') if block_given?
end

# This block will be passed to first
first second do |method_name|
  puts method_name
end
# => first

# This block will be passed to second
first second { |method_name| puts method_name }
# => second
```

The lesson to learn from the above example is: don't write code like this


#### References

What is a closure - http://programmers.stackexchange.com/a/40708
New relic - https://blog.newrelic.com/2015/04/30/weird-ruby-part-4-code-pods/
rubylearning - http://rubylearning.com/satishtalim/ruby_blocks.html
Reactive.io - http://www.reactive.io/tips/2008/12/21/understanding-ruby-blocks-procs-and-lambdas/





