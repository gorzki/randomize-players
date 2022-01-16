class SolitaireService
  attr_reader :output_file

  def initialize(file)
    @file = File.read(file)
  end

  def call
    draw
    send_emails
    generate_output_file

    self
  end

  private

  attr_reader :file, :result

  def players
    JSON.parse(file).map { |row| SolitairePlayerObject.new(row.with_indifferent_access) }
  end

  def draw
    @result = Solitaire::DrawPairsCommand.call(players)
  end

  def send_emails
    result.each do |pair|
      next if pair.one?

      Solitaire::SendEmailCommand.call(player: pair.first, opponent: pair.last)
    end
  end

  def generate_output_file
    @output_file = Solitaire::GenerateOutputCommand.call(result)
  end
end