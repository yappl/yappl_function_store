class SearchCommand
  def run(args = [] of String)
    url = URL
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end
    if args.size > 1 && ["--url", "-u"].includes? args[0]
      url = args[1]
    end

    puts "totally searching the store at #{url}"
  end

  def help
    return <<-HEREDOC

    Search for transformation functions

    Usage:
      yt search [function_name] [flags]

    Examples:
      yt search median
      yt search --name median
      yt search --author tpei
      yt search --compatibility string

    Flags:
      -h, --help            help for search command
      -n, --name            search function by name
      -a, --author          search function by author
      -c, --compatibility   search function by compatibiity
      -u, --url             search non-default function store
    HEREDOC
  end
end
