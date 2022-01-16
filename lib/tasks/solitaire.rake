# frozen_string_literal: true

namespace :solitaire do
  desc 'create solitaire game pairs'
  task :generate_game, [:file] => :environment do |_t, args|
    file = Rails.root.join(args[:file])
    if File.exist?(file)
      service = SolitaireService.new(file).call
      puts "Output: #{service.output_file.path}"
    else
      puts "Invalid file path -> #{file}"
    end
  end
end