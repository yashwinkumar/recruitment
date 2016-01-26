class Template < ActiveRecord::Base
  belongs_to :user
  has_many :sections, dependent: :destroy
  accepts_nested_attributes_for :sections, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

  validates :user_id, presence: true
end
