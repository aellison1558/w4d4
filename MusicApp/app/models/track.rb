class Track < ActiveRecord::Base
  TRACK_TYPES = ["regular", "bonus"]
  validates :name, :track_type, :album_id, presence: true
  validates :track_type, inclusion: TRACK_TYPES

  belongs_to :album

  has_one :band, through: :album
end
