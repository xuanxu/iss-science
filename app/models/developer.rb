class Developer < ApplicationRecord
  has_and_belongs_to_many :experiments

  default_scope { order(:name) }
  scope :by_initial, ->(initial) { where("name LIKE ?", initial.downcase + "%") }

  def self.initials
    Developer.unscoped.all.select(:name).map {|e| e.name[0].upcase}.uniq.compact.sort
  end
end
