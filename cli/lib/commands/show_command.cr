class ShowCommand
  def run(args = [] of String)
    arguments = ArgumentParser.parse(args_map, args)
    function_name = args[0]

    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")

    function = FunctionsWrapper.function_by(function_name)

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

    puts "showing functions from #{URL}"
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
    HEREDOC
  end
  def args_map
    {
      "-h" => 0,
      "--help" => 0,
    }
  end
end
