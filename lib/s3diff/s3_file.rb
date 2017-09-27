require "tempfile"
require "ostruct"

module S3diff
  class S3File
    def initialize(s3_uri, s3_client)
      @s3c = s3_client
      @uri = s3_uri
    end

    def etag
      head.etag.delete(%(")) if exist?
    end

    def size
      head.content_length if exist?
    end

    def path
      cache_file.path
    end

    def original_path
      @uri
    end

    def exist?
      !head.nil?
    end

    private

    def head
      @head ||= begin
        @s3c.head_object(@uri)
      rescue Aws::S3::Errors::NotFound
        nil
      end
    end

    def cache_file
      @cache_file ||= begin
        f = Tempfile.new("")
        @s3c.get_object(@uri, f) if exist?
        f.flush
        f
      end
    end
  end
end
