class GetCommand
  def run(args = [] of String)
    arguments = ArgumentParser.parse(args_map, args)
    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")

    function_name = args[0]

    function = FunctionsWrapper.function_by(function_name)

    if function.nil?
      puts "no function by that name found"
      return
    end

    puts "downloading function data"

    function_url = function.code_link
    response = HTTP::Client.get(function_url).body

    filename = function_url.split("/")[-1]

    unless arguments.has_key?("--overwrite")
      if File.exists?("manifest.yml")
        puts "manifest file already exists"
        return
      end
      if File.exists?(filename)
        puts "function file by that name already exists"
        return
      end
    end

    File.write(filename, response)
    manifest = <<-HEREDOC
      packages:
        transformations:
          actions:
    #{function_name}:
              function: ./#{filename}
    HEREDOC
    File.write("manifest.yml", manifest)

    puts "Downloaded #{filename} and manifest.yml to local directory"
  end

  def help
    return <<-HEREDOC

    Download a function

    Usage:
      yt get (function_name)

    Examples:
      yt get median

    Flags:
      -h, --help   help for show command
    HEREDOC
  end

  def args_map
    { "--help" => 0, "-h" => 0, "--overwrite" => 0 }
  end
end
