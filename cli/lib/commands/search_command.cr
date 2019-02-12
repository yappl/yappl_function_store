class SearchCommand
  def run(args = [] of String)
    arguments = ArgumentParser.parse(args_map, args)

    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")

    return puts "no arguments provided" if args.size == 0

    name = args[0].downcase unless args[0].starts_with?("-")
    if arguments.has_key?("-n")
      name = arguments["-n"][0].downcase
    elsif arguments.has_key?("--name")
      name = arguments["--name"][0].downcase
    end

    author = nil
    if arguments.has_key?("-a")
      author = arguments["-a"][0].downcase
    elsif arguments.has_key?("--author")
      author = arguments["--author"][0].downcase
    end

    compatibility = nil
    if arguments.has_key?("-c")
      compatibility = arguments["-c"][0].downcase
    elsif arguments.has_key?("--compatibility")
      compatibility = arguments["--compatibility"][0].downcase
    end

    description = nil
    if arguments.has_key?("-d")
      description = arguments["-d"][0].downcase
    elsif arguments.has_key?("--description")
      description = arguments["--description"][0].downcase
    end

    functions = FunctionsWrapper.functions.compact_map do |function|
      function if name.nil? || function.name.downcase.includes?(name)
    end.compact_map do |function|
      function if author.nil? || function.author.downcase.includes?(author)
    end.compact_map do |function|
      function if compatibility.nil? || function.compatibility.any? do |c|
        c.downcase.includes? compatibility
      end
    end.compact_map do |function|
      function if description.nil? || function.description.downcase.includes? description
    end

    if functions.empty?
      return puts "no functions found"
    end

    length = functions.map do |f|
      f.name
    end.map do |name|
      name.size
    end.max
    length = [length, "FUNCTION".size].max

    printf "%-*s" % [length + 4, "FUNCTION"]
    puts "DESCRIPTION"
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
      -c, --compatibility   search function by compatibility
    HEREDOC
  end

  def args_map
    {
      "-h" => 0,
      "--help" => 0,
      "-n" => 1,
      "--name" => 1,
      "-a" => 1,
      "--author" => 1,
      "-c" => 1,
      "--compatibility" => 1,
      "-d" => 1,
      "--description" => 1
    }
  end
end
