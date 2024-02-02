class Language < ApplicationRecord
  has_many :translations, dependent: :destroy
end
