
# LineAnalyzer.
class LineAnalyzer
  attr_reader :highest_wf_count, :highest_wf_words, :content, :line_number

  # initialize
  def initialize(content, line_number)
    @content = content.chomp.strip
    @line_number = line_number
    calculate_word_frequency
  end

  # calculate_word_frequency
  def calculate_word_frequency
    word_frequency = Hash.new(0)
    @content.split.each { |word| word_frequency[word.downcase] += 1 }
    @highest_wf_count = word_frequency.values.max
    @highest_wf_words = word_frequency.select { |_k, v| v == @highest_wf_count }.keys
  end
end

#  Solution.
class Solution
  attr_reader :analyzers, :highest_count_across_lines, :highest_count_words_across_lines

  def initialize
    @analyzers = []
    @file_name = "test.txt"
  end

  # # * analyze_file() - processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
  def analyze_file
    return "file does not exist" unless File.exist?(@file_name)

    line_number = 0
    @analyzers.clear

    File.foreach(@file_name) do |line|
      @analyzers << LineAnalyzer.new(line.chomp, line_number)
      line_number += 1
    end
  end

  # * calculate_line_with_highest_frequency() - determines the highest_count_across_lines and
  #   highest_count_words_across_lines attribute values
  def calculate_line_with_highest_frequency
    @highest_count_across_lines = @analyzers.map(&:highest_wf_count).max

    @highest_count_words_across_lines = @analyzers.select do |analyzer|
      analyzer.highest_wf_count == @highest_count_across_lines
    end
  end

  # * print_highest_word_frequency_across_lines() - prints the values of LineAnalyzer objects in
  #   highest_count_words_across_lines in the specified format
  def print_highest_word_frequency_across_lines
    puts "The following words have the highest word frequency per line:"
    @highest_count_words_across_lines.each do |analyzer|
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
  end
end
