class Keyword < ApplicationRecord
  has_and_belongs_to_many :experiments

  default_scope { order(:name) }

  validates_presence_of :variations, message: "At least one variation should be added"

  def variations_list
    self.variations.split(",").map(&:strip)
  end
end
