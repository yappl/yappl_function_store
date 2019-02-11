class ShowCommand
  def run(args = [] of String)
    url = URL
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end
    if args.size > 1 && ["--url", "-u"].includes? args[0]
      url = args[1]
    end

    puts "showing functions from #{url}"
  end

  def help
    return <<-HEREDOC

    Show more in-depth info on a function

    Usage:
      yt show (function_name)

    Examples:
      yt show median

    Flags:
      -h, --help   help for show command
      -u, --url    show from non-default function store
    HEREDOC
  end
end
