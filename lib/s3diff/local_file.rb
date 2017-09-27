require "digest/md5"

module S3diff
  class LocalFile
    def initialize(file_path)
      @file_path = file_path
    end

    def etag
      Digest::MD5.file(@file_path).to_s if exist?
    end

    def size
      File.size(@file_path) if exist?
    end

    def path
      if exist?
        original_path
      else
        cache_file.path
      end
    end

    def original_path
      @file_path
    end

    def exist?
      File.exist?(@file_path)
    end

    private

    def cache_file
      @cache_file ||= begin
        Tempfile.new("")
      end
    end
  end
end
