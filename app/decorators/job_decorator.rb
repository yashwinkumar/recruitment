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

  def user_submitted?
    submissions.find_by_user_id current_user.id
  end

  def submissions_count
    if hm == current_user
      @submission_count ||= submissions.where("submissions.status != 'submitted'").count
    else
      @submission_count ||= submissions.count
    end
  end

end