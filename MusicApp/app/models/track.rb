# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  album_id   :integer          not null
#  track_type :string           not null
#  lyrics     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  TRACK_TYPES = ["regular", "bonus"]
  validates :name, :track_type, :album_id, presence: true
  validates :track_type, inclusion: TRACK_TYPES

  belongs_to :album
  has_one :band, through: :album

  has_many :notes
end
