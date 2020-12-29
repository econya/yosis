# SPDX-FileCopyrightText: 2020 Felix Wolfsteller
#
# SPDX-License-Identifier: AGPL-3.0-or-later

namespace :yosis do
  desc 'Check that all Active Storage blobs exist on disk service'
  task check_blobs: :environment do
    missing_file_count = 0
    ActiveStorage::Blob.find_each do |blob|
      file_path = ActiveStorage::Blob.service.send(:path_for, blob.key)
      if File.exist? file_path
        # nop
      else
        missing_file_count+= 1
        STDERR.puts "Blob #{blob.id} refers to missing file: #{file_path}"
      end
    end

    if missing_file_count == 0
      puts "All blobs refer to existing files."
      exit 0
    else
      puts "#{missing_file_count} blob(s) refer to non-existing files!"
      exit 1
    end
  end
end
