module JobDecorator

  def new_submission_display?
    (consultant == current_user && new_submissions.any?) || (hm == current_user && processing_submissions.any? )
  end

  def new_submission_size
    if consultant == current_user
      new_submissions.size
    elsif hm == current_user
      processing_submissions.size
    end
  end

end