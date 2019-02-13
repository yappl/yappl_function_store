class ClearCacheCommand
  def run(args = [] of String)
    arguments = ArgumentParser.parse(args_map, args)
    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")

    Cache.new(URL).clear
    puts "Cache Cleared"
  end

  def help
    return <<-HEREDOC

    Clears Function Cache. Deletes all cached data for the currently used function store.

    Usage:
      yt clear

    Flags:
      -h, --help      help for clear command
    HEREDOC
  end

  def args_map
    {
      "-h" => 0,
      "--help" => 0,
    }
  end
end
