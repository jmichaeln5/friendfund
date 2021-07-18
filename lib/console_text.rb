module ConsoleText

  def text_white(text)
    puts "\e[1m#{text}\e[1m"
  end

  def text_darker(text)
    puts "\e[2m#{text}\e[1m"
  end

  def text_italic(text)
    puts "\e[3m#{text}\e[1m"
  end

  def text_underline(text)
    puts "\e[4m#{text}\e[1m"
  end

end
