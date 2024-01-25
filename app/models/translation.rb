class Translation < ApplicationRecord
  belongs_to :language
  belongs_to :term

  validates :translated_term, presence: true
end
