class TranslationsController < ApplicationController
  def index
    @translations = Translation.all
  end

  def show
    @translation = Translation.find(params[:id])
  end

  def new
    @translation = Translation.new
  end

  def create
    @translation = Translation.new(translation_params)
    if @translation.save
      redirect_to @translation
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @translation = Translation.find(params[:id])
  end

  def update
    @translation = Translation.find(params[:id])
    if @translation.update(translation_params)
      redirect_to @translation
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @translation = Translation.find(params[:id])
    @translation.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def translation_params
    params.require(:translation).permit(:original)
  end
end
