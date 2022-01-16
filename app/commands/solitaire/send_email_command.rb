class Solitaire::SendEmailCommand
  extend ApplicationCommand

  def initialize(player:, opponent:)
    @player = player
    @opponent = opponent
  end

  def call
    ApplicationMailer.solitaire_game(to: player.email, opponent_full_name: opponent.full_name).deliver_now
    ApplicationMailer.solitaire_game(to: opponent.email, opponent_full_name: player.full_name).deliver_now
  end

  private

  attr_reader :player, :opponent
end