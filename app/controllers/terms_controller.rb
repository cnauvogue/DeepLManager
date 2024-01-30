class TermsController < ApplicationController
  before_action :set_term, only: %i[ show edit update destroy ]

  # GET /terms or /terms.json
  def index
    @terms = Term.all
    @maybe = {}
    @terms.each do |term| 
      @maybe[term] = maybe_translations_for(term)
    end

  end

  # GET /terms/1 or /terms/1.json
  def show
    @term = Term.find(params[:id])
    @maybe_translations = maybe_translations_for(@term)
  end

  # GET /terms/new
  def new
    @term = Term.new
  end

  # GET /terms/1/edit
  def edit
  end

  # POST /terms or /terms.json
  def create
    @term = Term.new(term_params)

    respond_to do |format|
      if @term.save
        format.html { redirect_to term_url(@term), notice: "Term was successfully created." }
        format.json { render :show, status: :created, location: @term }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /terms/1 or /terms/1.json
  def update
    respond_to do |format|
      if @term.update(term_params)
        format.html { redirect_to term_url(@term), notice: "Term was successfully updated." }
        format.json { render :show, status: :ok, location: @term }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @term.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /terms/1 or /terms/1.json
  def destroy
    @term.destroy!

    respond_to do |format|
      format.html { redirect_to terms_url, notice: "Term was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
  def set_term
    @term = Term.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def term_params
    params.require(:term).permit(:original)
  end

  def maybe_translations_for(term)
    maybe_translations = Language.all.map { |l| 
      translation = Translation.where(term: term.id, language: l.id).take
      if translation != nil
        link = edit_translation_path(translation)
      else
        link = new_translation_path
      end
      MaybeTranslation.new(l, translation, link)
    }
    maybe_translations.sort_by { |mt| mt.language.name }
    maybe_translations
  end

  class MaybeTranslation 
    def initialize(language, translation, link)
      @language = language
      @translation = translation
      @link = link
    end

    def language 
      @language
    end

    def translation 
      @translation
    end

    def translated?
      @translation != nil
    end

    def link
      @link
    end

  end
end
