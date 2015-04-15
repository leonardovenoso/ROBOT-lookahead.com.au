class Print
  def table(array_size_x, array_size_y, matrix)
    system 'clear'
    print_header(array_size_x)
    print_table(array_size_x, array_size_y, matrix)
  end

  private

  def print_header(array_size_x)
    print "\n"

    (0..array_size_x - 1).each do |x|
      print "#{x}\t"
    end

    print "\n----------------------------------\n"
  end

  def print_table(array_size_x, array_size_y, matrix)
    (0..array_size_x - 1).each do |i|
      print "\n"
      (0..array_size_y - 1).each do |j|
        print "#{matrix[i][j]}\t"
      end
    end

    print "\n"
  end
end
