class ListCommand
  def run(args = [] of String)
    if args.size > 0 && ["--help", "-h"].includes? args[0]
      puts help
      return
    end

    functions = FunctionsWrapper.functions

    length = functions.map do |f|
      f.name
    end.map do |name|
      name.size
    end.max

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
    Show available transformation functions

    Usage:
      yt list

    Examples:
      yt list

    Flags:
      -h, --help   help for list command
    HEREDOC
  end
end
