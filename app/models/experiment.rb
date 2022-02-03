class Experiment < ApplicationRecord
  belongs_to :category
  belongs_to :space_agency
  has_and_belongs_to_many :developers
  has_and_belongs_to_many :expeditions
  has_and_belongs_to_many :principal_investigators

  validates :short_name, presence: true, uniqueness: true

  default_scope { order(:short_name) }
  scope :complete, -> { includes(:category, :space_agency, :developers, :expeditions, :principal_investigators)}
  scope :by_initial, ->(initial) { where("short_name LIKE ?", initial.downcase + "%") }

  def self.initials
    Experiment.unscoped.all.select(:short_name).map {|e| e.short_name[0].upcase}.uniq.compact.sort
  end
end
