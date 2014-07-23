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

  # validation
  validates_presence_of :name, message: '請輸入地點名稱'
  validates_presence_of :address, message: '請輸入詳細地址'

  # geocoder
  geocoded_by :address # can also be an IP address

  # validation callback
  after_validation :geocode # auto-fetch coordinates

  # named scope
  scope :sorted, lambda { order("name ASC")}

  def static_map_url(size, zoom)
    google_static_map_url(latitude, longitude, size, zoom)
  end

  def street_image_url(size)
    google_street_view_url(latitude, longitude, size)
  end

  private 
    def google_static_map_url(latitude, longitude, size, zoom)
      "http://maps.googleapis.com/maps/api/staticmap?center=#{latitude},#{longitude}&zoom=#{zoom || 13}&size=#{size || '400x400'}&sensor=false"
    end

    def google_street_view_url(latitude, longitude, size)
      "http://maps.googleapis.com/maps/api/streetview?size=#{size || '400x400'}&location=#{latitude},#{longitude}&heading=235&sensor=false"
    end
end
