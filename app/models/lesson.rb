class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  has_many :lesson_words, dependent: :destroy
  has_many :words, through: :lesson_words, dependent: :destroy

  accepts_nested_attributes_for :lesson_words, reject_if:
    lambda {|attributes| attributes["answer_id"].blank?}

  before_create :add_word
  before_save :update_correct_number

  scope :unfinish_lessons, ->{joins(:lesson_words).where lesson_words: {answer_id: nil}}

  private
  def add_word
    self.words = category.words.random(user)
  end

  def update_correct_number
    self.correct_number = lesson_words.select{|lesson_word| lesson_word.is_correct?}.count
  end

end
