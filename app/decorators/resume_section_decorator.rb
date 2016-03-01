module ResumeSectionDecorator

  def candidate_rating
    raw "<p><strong>Rating:</strong> #{self.rating} out of 5</p>"
  end

end