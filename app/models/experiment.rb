class Experiment < ApplicationRecord
  belongs_to :category
  belongs_to :space_agency
  has_and_belongs_to_many :developers
  has_and_belongs_to_many :expeditions
  has_and_belongs_to_many :principal_investigators
end
