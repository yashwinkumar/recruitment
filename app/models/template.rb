class Template < ActiveRecord::Base
  belongs_to :user
  has_many :sections, dependent: :destroy
  has_many :resumes
  accepts_nested_attributes_for :sections, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  validates_presence_of :user_id, :name
  validates_uniqueness_of :name, scope: :user_id
end
