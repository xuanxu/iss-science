class Experiment < ApplicationRecord
  belongs_to :category
  belongs_to :subcategory
  belongs_to :space_agency
  belongs_to :organization
  has_and_belongs_to_many :developers
  has_and_belongs_to_many :expeditions
  has_and_belongs_to_many :investigators
  has_and_belongs_to_many :keywords

  validates :name, presence: true, uniqueness: true
  validates :external_id, presence: true, uniqueness: true

  default_scope { order(:name) }
  scope :unrevised, -> { where(revised: false) }
  scope :revised, -> { where(revised: true) }
  scope :complete, -> { includes(:category, :subcategory, :space_agency, :organization, :developers, :expeditions, :investigators, :keywords)}
  scope :by_initial, ->(initial) { where("lower(name) LIKE ?", initial.downcase + "%") }

  def self.initials
    Experiment.unscoped.all.select(:name).map {|e| e.name[0].upcase}.uniq.compact.sort
  end

  def revised!
    update_attribute(:revised, true)
  end

  def docking_dates
    dock_on = dock_date.present? ? dock_date.strftime("%d/%m/%Y") : "unavailable"
    undock_on = undock_date.present? ? undock_date.strftime("%d/%m/%Y") : "-"

    if dock_on == "unavailable" && undock_on == "-"
      return "No docking info available"
    else
      return "Docked from #{dock_on} to #{undock_on}"
    end
  end
end
