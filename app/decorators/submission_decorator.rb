module SubmissionDecorator

  def interview_availabilities
    [[availability_1, availability_1_str] ,[availability_2, availability_2_str], [availability_3, availability_3_str]]
  end

  [*1..3].each do |i|
    define_method("availability_#{i}_str") do
      send("availability_#{i}") ? send("availability_#{i}").strftime('%B %d, %Y %I:%M %P') : 'NA'
    end
  end

end