class Relationship < ActiveRecord::Base
  belongs_to :influence, class_name: "Title"
  belongs_to :influenced, class_name: "Title"
end
