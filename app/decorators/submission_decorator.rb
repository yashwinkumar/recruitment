module SubmissionDecorator
  def interview_availabilities
    available = []
    self.available_times.each do|at|
      available << [at.id,(at.date && at.from && at.to) ? (at.date.strftime('%B %d, %Y').to_s + ' ' + at.from.to_s + ' - ' + at.to.to_s) : "N/A"]
    end
    available
  end
end