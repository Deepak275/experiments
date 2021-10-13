
def compose_note?(note, book)
  book_char_counts = Array.new(26, 0)
  note_count = {}
  
  for char in book.chars do
    abs_index = char.ord - 97
    next if char == ' '

    book_char_counts[abs_index] += 1
  end

  for char in note.chars do
    next if char == ' '

    if note_count[char.ord - 97].nil?
      note_count[char.ord - 97] = 1
    else
      note_count[char.ord - 97] += 1 
    end
  end

  p note_count, book_char_counts

  note_count.each do |key,value|
    next if book_char_counts[key] >= value

    p "Note can't be formed as book has count of char #{(key+97).chr} less than #{value}"
  end
end

compose_note?('meet at noon', 'this is some sample text about kangaroos')