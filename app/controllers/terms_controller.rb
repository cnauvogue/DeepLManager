require 'net/http'

class TermsController < ApplicationController
  before_action :set_term, only: %i[ show edit update destroy ]

  # GET /terms or /terms.json
  def index
    @terms = Term.all.sort_by do |t|
      t.original.downcase
    end
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

  def submit
    @terms = Term.all
    @langs = Language.all
    result = []
    @langs.each do |lang|
      glossary = Glossary.new(@terms, lang)
      result.append glossary
    end

    logger.info result

    begin
      prev_glossaries = DeepLGlossary.all
      prev_glossaries.each do |prev_gloss|
        Api.default.delete prev_gloss
        prev_gloss.destroy
      end
      result.each do |new_gloss|
        res = Api.default.submit(new_gloss)
        dl_gloss = DeepLGlossary.new
        dl_gloss.glossary_id = res['glossary_id']
        dl_gloss.language_code = new_gloss.glossary_hash['language'].code
        dl_gloss.name = new_gloss.glossary_hash['name']
        dl_gloss.save
      end
    rescue ApiError => e
      redirect_to terms_path, notice: e.message
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
    maybe_translations = Language.all.map do |l|
      translation = Translation.where(term: term.id, language: l.id).take
      link = if translation.nil?
               new_translation_path
             else
               edit_translation_path(translation)
             end
      MaybeTranslation.new(l, translation, link)
    end
    maybe_translations.sort_by { |mt| mt.language.name }
  end

  class MaybeTranslation
    attr_reader :language, :translation, :link

    def initialize(language, translation, link)
      @language = language
      @translation = translation
      @link = link
    end

    def translated?
      @translation != nil
    end
  end
end
