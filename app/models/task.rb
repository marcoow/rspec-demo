class Task < ActiveRecord::Base

  validates_presence_of :title
  validates_length_of   :title, :in => 5..150, :unless => Proc.new { |task| task.title.blank? }

end
