strings = File.read("2ndRun.txt").split("\n")

strings.each do |string|
  begin
    end_of_title = string.index("  ")
    title = string[0, end_of_title].strip
    book_info = string[end_of_title, string.length].strip
    book_info = book_info.split("  ").collect(&:strip)
    puts [title, book_info].flatten.join(";")
  rescue => e
    puts string
    puts e
  end
end
