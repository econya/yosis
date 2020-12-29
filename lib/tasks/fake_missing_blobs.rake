# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

namespace :yosis do
  desc 'Create missing files that are referenced by Active Storage blobs on disk service'
  task fake_missing_blobs: :environment do
    CHOICES = %w{y n q a}
    missing_count = 0
    input = nil

    ActiveStorage::Blob.find_each do |blob|
      file_path = ActiveStorage::Blob.service.send(:path_for, blob.key)

      if File.exist? file_path
        # nop
      else
        missing_count+= 1
        if input != 'a'
          STDERR.puts "Blob #{blob.id} refers to missing file: #{file_path}"
          STDOUT.puts "Do you want to create the missing file? (y/n/a/q)"
          STDOUT.puts "(y)es (n)o (a)ll (q)uit"
          while !CHOICES.include?(input = STDIN.gets.strip.downcase)
            ;
          end

          case input
          when 'q'
            puts 'Aborting ...'
            exit 0
          when 'y'
          when 'a'
          when 'n'
            next
          end
        end

        if input == 'a' || input == 'y'
          puts "Creating"

          path = Pathname(file_path)
          path.dirname.mkpath

          touch file_path
          input = nil if input == 'y'
        end
      end
    end
  puts "#{missing_count == 0 ? 'No' : missing_count} missing files where found"
  end
end

