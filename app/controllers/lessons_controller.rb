class LessonsController < ApplicationController
  before_action :get_lesson, only: [:edit, :update]

  def create
    @category = Category.find params[:category_id]
    @lesson = Lesson.new
    @lesson.category = @category
    @lesson.user = current_user
    if @lesson.save
      flash[:success] = t "flash.success"
    else
      flash[:danger] = t "flash.fail"
    end
    redirect_to edit_category_lesson_path(@category, @lesson)
  end

  def edit
  end

  def update
    if @lesson.update_attributes lesson_params
      flash[:success] = t "flash.success"
      redirect_to lesson_lesson_words_path @lesson
    else
      flash[:danger] = t "flash.fail"
      redirect_to categories_path
    end
  end

  private
  def get_lesson
    @lesson = Lesson.find params[:id]
  end

  def lesson_params
    params.require(:lesson).permit lesson_words_attributes: [:id, :answer_id]
  end

end
