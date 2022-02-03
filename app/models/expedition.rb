class Expedition < ApplicationRecord
  has_and_belongs_to_many :experiments

  default_scope { order(:name) }
end
