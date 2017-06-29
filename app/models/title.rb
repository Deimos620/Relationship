class Title < ActiveRecord::Base
  has_many :relationships, class_name: "Relationship", foreign_key: "influence_id"
  has_many :relationships, class_name: "Relationship", foreign_key: "influenced_id"
end
