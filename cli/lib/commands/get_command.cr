class GetCommand
  def run(args = [] of String)
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end

    puts "getting functions from #{URL}"
  end

  def help
    return <<-HEREDOC

    Download a function

    Usage:
      yt get (function_name)

    Examples:
      yt get median

    Flags:
      -h, --help   help for show command
    HEREDOC
  end
end
