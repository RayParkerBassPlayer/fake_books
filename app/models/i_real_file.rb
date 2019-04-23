# Using hstore field to store song JSON.  Some information here: https://nandovieira.com/using-postgresql-and-hstore-with-rails
class IRealFile < ApplicationRecord
  REQUIRED_COLUMNS = %i[chord_progression key_signature title]
  ALL_COLUMNS = %I[composer style] + REQUIRED_COLUMNS

  belongs_to :tune

  validates :tune_id, :presence => true
  validates :song_hash, :presence => true
  validate :song_hash_valid?


  def song_hash_valid?
    # This is the database default, but make sure for validation.
    self.song_hash ||= {}

    # Must have all keys.  This just to curb developer behavior.
    self.song_hash.keys && REQUIRED_COLUMNS == REQUIRED_COLUMNS

    REQUIRED_COLUMNS.each do |key|
      self.song_hash[key].present?
    end
  end

  def self.create_from_json!(song_json)
    tune = Tune.add_tune!(title: song_json["title"])

    i_real_file = IRealFile.new

    IRealFile::ALL_COLUMNS.each do |column|
      i_real_file.song_hash[column] = song_json[column.to_s.camelize(:lower)]
    end

    tune.i_real_files << i_real_file
  end
end
