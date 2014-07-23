# == Schema Information
#
# Table name: locations
#
#  id          :integer          not null, primary key
#  latitude    :float
#  longitude   :float
#  name        :string(255)
#  description :text
#  address     :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Location < ActiveRecord::Base
  belongs_to :user
end
