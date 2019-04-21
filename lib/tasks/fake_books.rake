namespace :fake_books do
  desc 'Import csv in the format "title;book;page"'
  task :import_csv => :environment do
    file = File.read(File.join(Rails.root, "db/etc/master_index.csv"))
    lines = file.split("\n")

    lines.each_with_index do |line, index|
      data = line.split(";")

      begin
        Tune.add_tune!(title: data[0], page: data[2], book: data[1])
      rescue => e
        puts "Error at line #{index + 1}: #{e}"
      end
    end
  end
end
