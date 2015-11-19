class Album < ActiveRecord::Base
  RECORDING_TYPES = ["studio", "live"]
  validates :name, :recording_type, :band_id, presence: true
  validates :recording_type, inclusion: RECORDING_TYPES

  belongs_to :band
end
