module ResumeSectionDecorator

  def candidate_rating
    raw "<p><strong>Candidate Rating:</strong> #{self.rating} out of 5</p>"
  end

end