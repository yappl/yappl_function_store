class DeployCommand
  def run(args = [] of String)
    url = URL
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end
    if args.size > 1 && ["--url", "-u"].includes? args[0]
      url = args[1]
    end

    puts "deploying a function from #{url}"
  end

  def help
    return <<-HEREDOC

    Deploy a function

    Usage:
      yt deploy (function_name) [flags]

    Examples:
      yt deploy median
      yt deploy median -n my_median
      yt deploy median -p my_package
      yt deploy median -n my_median -p my_package
      yt deploy median -i my_package/my_median

    Flags:
      -h, --help      help for deploy command
      -i, --info      set function package and name
      -n, --name      set function name
      -p, --package   set function package
      -u, --url    show from non-default function store
    HEREDOC
  end
end
