class TranslationsController < ApplicationController
  def index
    @translations = Translation.all
  end

  def show
    @translation = Translation.find(params[:id])
  end

  def new
    @translation = Translation.new
    if params[:term] != nil
      @term = Term.find(params[:term])
    end
  end

  def create
    @term = Term.find(translation_params[:term_id])
    @language = Language.find(translation_params[:language_id])

    @translation = Translation.new(
      translated_term: translation_params[:translated_term],
      language: @language,
      term: @term
    )

    if @translation.save
      redirect_to @translation
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @translation = Translation.find(params[:id])
    @term = @translation.term
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
    params.require(:translation).permit(:translated_term, :term_id, :language_id)
  end
end
