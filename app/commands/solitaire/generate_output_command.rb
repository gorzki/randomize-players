class Solitaire::GenerateOutputCommand
  extend ApplicationCommand

  def initialize(draw)
    @draw = draw
    @file_path = Rails.root.join('tmp', Time.current.strftime("rezultat-losowania-%Y%m%d-%H%M%S.txt"))
  end

  def call
    generate_file
    file
  end

  private

  attr_reader :draw, :file_path

  def generate_file
    File.open(file_path, "w+") { |f| output.each { |line| f.puts(line) } }
  end

  def output
    draw.map { |pair| pair.map(&:email).join(',') }
  end

  def file
    File.open(file_path)
  end
end