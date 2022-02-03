class Developer < ApplicationRecord
  has_and_belongs_to_many :experiments
end
