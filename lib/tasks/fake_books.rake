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

  desc "Import JSONified plist of iReal tunes"
  task :import_ireal => :environment do
    entries = JSON.parse(File.read(File.join(Rails.root, "db/etc", "UserSongs.plist")))

    entries.each do |entry|
      begin
        IRealFile.create_from_json!(entry)
        print "."
      rescue => e
        puts "Error adding tune '#{entry["title"]}': #{e}"
        puts e.backtrace.join("\n")
      end
    end
  end
end
