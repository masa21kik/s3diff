require "tempfile"

module S3diff
  class S3File
    def initialize(s3_uri, s3_client)
      @s3c = s3_client
      @uri = s3_uri
    end

    def etag
      head.etag.delete(%("))
    end

    def size
      head.content_length
    end

    def path
      cache_file.path
    end

    private

    def head
      @head ||= @s3c.head_object(@uri)
    end

    def cache_file
      @cache_file ||= begin
        f = Tempfile.new("")
        @s3c.get_object(@uri, f)
        f.flush
        f
      end
    end
  end
end
