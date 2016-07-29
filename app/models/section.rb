class Section < ActiveRecord::Base
  belongs_to :template
  has_many :resume_sections

  validates :name, presence: true, length: {minimum: 5}

  def to_s
    name.titleize
  end
end
