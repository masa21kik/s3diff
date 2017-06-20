require "optparse"

module S3diff
  class Cli
    def run(args)
      parse_args(args)
      comp = Comparator.new(@files[0], @files[1])
      $stdout.puts comp.diff.to_s(@options[:format]) unless comp.same?
    end

    private

    def parse_args(args)
      @options = { format: $stdout.tty? ? :color : :text }
      opt = OptionParser.new
      opt.banner = "Usage: #{$PROGRAM_NAME} [options] file1 file2"
      opt.on("-f", "--format FORMAT", "Diffy format [default=color]") { |v| @options[:format] = v.to_sym }
      opt.on("-p", "--aws-profile PROFILE") { |v| ENV["AWS_PROFILE"] = v }
      @files = opt.parse(args)
      abort(opt.help) if @files.size != 2
    end
  end
end
