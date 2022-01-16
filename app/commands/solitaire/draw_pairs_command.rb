class Solitaire::DrawPairsCommand
  extend ApplicationCommand

  def initialize(players)
    @players = players
  end

  def call
    players.shuffle.in_groups_of(2, false)
  end

  private

  attr_reader :players
end