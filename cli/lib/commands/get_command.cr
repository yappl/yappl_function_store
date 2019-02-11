class GetCommand
  def run(args = [] of String)
    url = URL
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end
    if args.size > 1 && ["--url", "-u"].includes? args[0]
      url = args[1]
    end

    puts "getting functions from #{url}"
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
      -u, --url    show from non-default function store
    HEREDOC
  end
end
