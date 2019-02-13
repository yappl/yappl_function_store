class UrlCommand
  def run(args = [] of String)
    arguments = ArgumentParser.parse(args_map, args)
    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")
    if arguments.has_key?("--reset")
      File.write(".env", "URL=#{DEFAULT_URL}")
      puts "Store URL reset to default"
      return
    end

    return puts "please provide an url or --reset" if args.size < 1

    url = args[0]

    File.write(".env", "URL=#{url}")

    return puts "#{url} set as new store url"
  end

  def help
    return <<-HEREDOC

    Sets the cli to use a different function store

    Usage:
      yt url https://my_funciton_store.com/store.json

    Flags:
      -h, --help      help for url command
      --reset         reset url back to default
    HEREDOC
  end

  def args_map
    {
      "-h" => 0,
      "--help" => 0,
      "--reset" => 0,
    }
  end
end
