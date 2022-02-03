class SpaceAgency < ApplicationRecord
  has_many :experiments

  default_scope { order(:name) }
end
