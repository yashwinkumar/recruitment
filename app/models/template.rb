class Template < ActiveRecord::Base
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_many :resumes
  accepts_nested_attributes_for :sections, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  validates :name, presence: true, length: { minimum: 5 }
  validates :user_id, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates_uniqueness_of :name, scope: :user_id
end
