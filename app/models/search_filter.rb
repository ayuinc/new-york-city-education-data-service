class SearchFilter

  def initialize(phrase)
    @phrase = phrase
  end

  def filter
    downcase_and_strip
    add_spaces
    add_zeros if missing_zeros?
    @phrase
  end

  private

  def downcase_and_strip
    @phrase = @phrase.downcase.gsub(/[^a-z0-9\s]/i, '')
  end

  def add_spaces
    if characters_without_spaces?(double_character_schools)
      @phrase = @phrase.insert(2, " ")
    elsif characters_without_spaces?(triple_character_schools)
      @phrase = @phrase.insert(3, " ")
    end
  end

  def characters_without_spaces?(schools)
    schools.keep_if { |school| @phrase.match(/#{school}\S/) }.any?
  end

  def double_character_schools
    ['ps', 'ms', 'is']
  end

  def triple_character_schools
    ['jhs']
  end

  def add_zeros
    phrase_array = @phrase.split(/(\W)/)
    (3 - digit_catcher.length).times { phrase_array.insert(2, '0') }
    @phrase = phrase_array.join
  end

  def zero_matcher(school)
    @phrase.match(/#{school} \d+/)
  end

  def has_digits?
    all_schools.keep_if { |school| zero_matcher(school) }.any?
  end

  def all_schools
    double_character_schools.concat(triple_character_schools)
  end

  def missing_zeros?
    digit_catcher.length <= 3 if has_digits? && digit_catcher.present? 
  end

  def digit_catcher
    school_matches = all_schools.keep_if { |school| zero_matcher(school) }
    digit_matcher = school_matches.map { |school| @phrase.match(/#{school} (\d+)/) }
    digit_matcher[0][1] if digit_matcher.present?
  end
end
