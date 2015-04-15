class Print
	def self.table(array_size_x, 
								 array_size_y, 
								 table)
	
		system "clear"
		print "\n"

		for x in 0..array_size_x - 1
			print "#{x}\t"
		end

		print "\n----------------------------------\n"

		for i in 0..array_size_x - 1
			print "\n"
			for j in 0..array_size_y - 1				
				print "#{table[i][j]}\t"
			end
		end		

		print "\n"
	end  
end