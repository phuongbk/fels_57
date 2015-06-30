class Word < ActiveRecord::Base
  belongs_to :category

  has_many :answers, dependent: :destroy
  has_many :lesson_words
  has_many :lessons, through: :lesson_words

  accepts_nested_attributes_for :answers, allow_destroy: true,
   reject_if: lambda {|attributes| attributes["content"].blank?}

  validates :content, presence: true  

  scope :random, ->(user_id){Word.not_learned(user_id).limit(Settings.words_per_lesson).order("RANDOM()")}
  scope :not_learned, ->(user_id){includes(:lessons)
    .where("lessons.user_id != ? OR lessons.user_id IS NULL OR lesson_words.answer_id IS NULL", user_id)
    .references(:lessons)}
  scope :learned, ->user_id{joins(:lessons)
    .where "lessons.user_id == ? AND lesson_words.answer_id NOT NULL", user_id}
  scope :all_words, ->user_id{}

  def correct_answer
    answers.find_by is_correct: true
  end

end
