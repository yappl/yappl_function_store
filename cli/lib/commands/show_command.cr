class ShowCommand
  def run(args = [] of String)
    url = URL

    arguments = ArgumentParser.parse(args_map, args)
    function_name = args[0]

    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")

    if arguments.has_key?("-u")
      url = arguments["-u"][0]
    elsif arguments.has_key?("--url")
      url = arguments["--url"][0]
    end

    functions = FunctionsWrapper.functions(url)

    function = functions.find { |f| f.name == function_name }

    if function.nil?
      puts "no function by that name found"
      return
    end

    puts "Name:          #{function.name}"
    puts "Description:"
    puts function.description
    puts "Compatibility: #{function.compatibility}"
    puts "Runtime:       #{function.runtime}"
    puts "Author:        #{function.author}"
    puts "Code:          #{function.repo_link}"

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
  def args_map
    {
      "-h" => 0,
      "--help" => 0,
      "-u" => 1,
      "--url" => 1
    }
  end
end
