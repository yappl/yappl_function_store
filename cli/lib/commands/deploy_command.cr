class DeployCommand
  def run(args = [] of String)
    arguments = ArgumentParser.parse(args_map, args)
    url = URL
    function_name = args[0]

    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")

    if arguments.has_key?("-u")
      url = arguments["-u"][0]
    elsif arguments.has_key?("--url")
      url = arguments["--url"][0]
    end

    deploy_name = determine_deploy_name(function_name, arguments)

    puts "deploying #{function_name} from #{url} as #{deploy_name}"
  end

  def determine_deploy_name(function_name, arguments)
    f_name = function_name
    package = ""

    if arguments.has_key?("-i")
      return arguments["-i"][0]
    elsif arguments.has_key?("--info")
      return arguments["--info"][0]
    end

    if arguments.has_key?("-p")
      package = arguments["-p"][0]
    elsif arguments.has_key?("--package")
      package = arguments["--package"][0]
    end

    if arguments.has_key?("-n")
      f_name = arguments["-n"][0]
    elsif arguments.has_key?("--name")
      f_name = arguments["--name"][0]
    end

    if package != ""
      return package + "/" + f_name
    else
      return f_name
    end
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

  def args_map
    {
      "-h" => 0,
      "--help" => 0,
      "-i" => 1,
      "--info" => 1,
      "-n" => 1,
      "--name" => 1,
      "-p" => 1,
      "--package" => 1,
      "-u" => 1,
      "--url" => 1
    }
  end
end
