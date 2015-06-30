class WordsController < ApplicationController
  def index
    @category = Category.find params[:category_id]
    @filter_status = params[:filter_status] || Settings.type_category.all
    @words = @category.words.send(@filter_status, current_user)

    @categories_list = Category.all.collect{|category| [category.name, category_words_path(category)]}
  end
end
