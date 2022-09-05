class Experiment < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :space_agency
  belongs_to :organization
  has_and_belongs_to_many :developers
  has_and_belongs_to_many :expeditions
  has_and_belongs_to_many :investigators

  validates :name, presence: true, uniqueness: true
  validates :external_id, presence: true, uniqueness: true

  default_scope { order(:name) }
  scope :complete, -> { includes(:category, :subcategory, :space_agency, :organization, :developers, :expeditions, :investigators)}
  scope :by_initial, ->(initial) { where("lower(name) LIKE ?", initial.downcase + "%") }

  def self.initials
    Experiment.unscoped.all.select(:name).map {|e| e.name[0].upcase}.uniq.compact.sort
  end
end
