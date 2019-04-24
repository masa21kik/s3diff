require "aws-sdk-s3"
require "uri"

module S3diff
  class S3Client
    def initialize(options = {})
      @client = Aws::S3::Client.new(options)
    end

    def head_object(s3_uri, options = {})
      @client.head_object(options.merge(parse_s3_uri(s3_uri)))
    end

    def get_object(s3_uri, file_io, options = {})
      @client.get_object(options.merge(parse_s3_uri(s3_uri))) do |chunk|
        file_io.write(chunk)
      end
    end

    def parse_s3_uri(s3_uri)
      uri = URI.parse(s3_uri)
      { bucket: uri.host, key: uri.path.sub(%r{^/}, "") }
    end
  end
end
