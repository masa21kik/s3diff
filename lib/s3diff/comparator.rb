require "diffy"

module S3diff
  class Comparator
    def initialize(file1, file2, s3_options = {})
      @s3_options = s3_options
      @file1 = file_object(file1)
      @file2 = file_object(file2)
    end

    def same_etag?
      @file1.etag == @file2.etag
    end

    def same?
      same_etag? || diff.to_s.empty?
    end

    def diff
      @diff ||= Diffy::Diff.new(@file1.path, @file2.path, source: "files")
    end

    private

    def file_object(file)
      uri = URI.parse(file)
      case uri.scheme
      when "s3" then S3File.new(file, s3_client)
      else LocalFile.new(file)
      end
    end

    def s3_client
      @s3c ||= S3Client.new(@s3_options)
    end
  end
end
