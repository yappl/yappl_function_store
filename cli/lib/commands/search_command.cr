class SearchCommand
  def run(args = [] of String)
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end

    puts "totally searching the store at #{URL}"
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
    HEREDOC
  end
end
