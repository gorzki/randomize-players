class SolitaireForm
  include ActiveModel::Model

  attr_accessor :file
  attr_reader :response_file

  validate :valid_file

  private

  def valid_file
    return errors.add(:file, :empty) if file.blank?

    errors.add(:file, :invalid) unless file.content_type.match?('application/json')
  end
end