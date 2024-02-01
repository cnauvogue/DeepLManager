class Glossary
  attr_reader :glossary_hash

  def initialize(terms, language)
    result = { "name": "en to #{language.code}", "entries_format": "tsv" }
    result["source_lang"] = "en"
    result["target_lang"] = language.code
    tsv = ""
    terms.each do |term|
      # TODO: pass in these values rather than hitting db from helper class
      translation = term.translations.where(language: language).take
      tsv += "#{term.original}\t#{translation.translated_term}\n" unless translation.nil?
      result["entries"] = tsv
    end
    @glossary_hash = result
  end

  def as_json
    JSON.generate(@glossary_hash)
  end
end
