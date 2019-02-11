class ListCommand
  def run(args = [] of String)
    url = URL
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end
    if args.size > 1 && ["--url", "-u"].includes? args[0]
      url = args[1]
    end

    functions = FunctionsWrapper.functions(url)

    length = functions.map do |f|
      f.name
    end.map do |name|
      name.size
    end.max

    functions.each do |function|
      printf "%-*s" % [length + 4, function.name]
      if function.description.size >= 80
        puts function.description[0..80] + "..."
      else
        puts function.description
      end
    end
  end

  def help
    return <<-HEREDOC
    Show available transformation functions

    Usage:
      yt list

    Examples:
      yt list --url https://some_url.com/store.json

    Flags:
      -u, --url     search non-default function store
    HEREDOC
  end
end
