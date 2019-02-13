class DeployCommand
  def run(args = [] of String)
    arguments = ArgumentParser.parse(args_map, args)
    function_name = args[0]

    return puts help if arguments.has_key?("-h") || arguments.has_key?("--help")

    package, name = determine_deploy_name(function_name, arguments)

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
      if File.exists?(filename)
        puts "file by that name already exists"
        return
      end
      if File.exists?("manifest.yml")
        puts "manifest file already exists"
        return
      end
    end

    File.write(filename, response)
    manifest = <<-HEREDOC
    packages:
      #{package}:
        actions:
          #{name}:
            function: ./#{filename}
    HEREDOC
    File.write("manifest.yml", manifest)

    puts "deploying #{function_name} as #{package}/#{name}"

    # TODO: with deployer?
    `wskdeploy`

    puts "done"
  end

  def determine_deploy_name(function_name, arguments)
    f_name = function_name
    package = "_"

    if arguments.has_key?("-i")
      return arguments["-i"][0].split("/")
    elsif arguments.has_key?("--info")
      return arguments["--info"][0].split("/")
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

    return package, f_name
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
      --overwrite     overwrites locally saved data
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
      "--overwrite" => 0
    }
  end
end
