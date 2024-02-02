class Term < ApplicationRecord
  has_many :translations, dependent: :destroy
end
