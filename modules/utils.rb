module Utils
	def abbreviate(orientation_symbol)
		orientation_symbol.to_s.split("_").map {|orientation| orientation[0].chr }.join.upcase
	end

	def string_to_symbol(str)
		str.strip.gsub(/\s+/, "_").downcase.to_sym
	end

	def is_integer?(number)
  	!!(number =~ /\A[+]?[0-9]+\z/)
  end	 	
end