require "digest/md5"

module S3diff
  class LocalFile
    def initialize(file_path)
      @file_path = file_path
    end

    def etag
      Digest::MD5.file(@file_path).to_s
    end

    def size
      File.size(@file_path)
    end

    def path
      @file_path
    end
  end
end
