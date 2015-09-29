
# def doubler(num)
# 	curr_number = num
# 	5.times do
# 		yield curr_number
# 		curr_number = curr_number * 2
# 	end
# end

# starting_number = 5
# doubler(starting_number) { | d | puts d  }

# def find_words(words)
# 	results = []
# 	words.each do |word|
# 		if yield(word)
# 			results << word
# 		end  
# 	end
# 	results
# end

# list = %w[ hello mom bob monday tattarrattat ruby detartrated ]  # a shortcut for creating an array of strings
# palindromes = list.select { | w | w == w.reverse }
# not_palindromes = list.select { | w | w != w.reverse }

# puts "Palindromes:"
# puts palindromes
# puts "\nNot Palindromes:"
# puts not_palindromes


# def doubler(num)
# 	curr_number = num
# 	5.times do
# 		yield curr_number
# 		curr_number = curr_number * 2
# 	end
# end

# starting_number = 5
# doubler(starting_number) { | d | puts d  }



# def map(list)
# 	result = []
# 	list.each do | item |
# 		result << yield(item)
# 	end
# 	result
# end

# str_list = %w[ hello from ruby] # a shortcut for creating an array of strings
# str_result = str_list.map() { | curr | curr.upcase  }
# puts str_result

# num_list = [1,2,3]
# num_result = num_list.map { | curr | curr * curr  }
# puts num_result

# def palindromes(words, &block)
# 	result = []
# 	words.each do |word|
# 		if word == word.reverse
# 			block.call(word) if block
# 			result << word
# 		end  
# 	end
# end

# list = %w[ hello mom bob monday tattarrattat ruby detartrated ]  
# palindromes = palindromes(list)
# puts palindromes

# def doubler(num, &callback)
# 	doubled = num * 2
# 	callback.call(doubled)	
# end

# number = 5
# doubler(number) { | d | puts "#{number} doubled is #{d}" }

# def display(&block)
# 	puts block.class
# end

# display {}

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





