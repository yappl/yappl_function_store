class HelpCommand
  def run(*args)
    return <<-HEREDOC

    Enables discovery and deployment of yappl transformation functions on
    OpenWhisk

    Usage:
      yt [command]

    Available Commands:
      list     Show available transformation functions
      search   Search for functions in store
      show     Show more in-depth info on a function
      get      Download a function and manifest file
      deploy   Deploy a function to your OpenWhisk installation

    Flags:
      -h, --help   show help for current command
      -u, --url    Alternative Store URL (default "https://raw.githubusercontent.com/TPei/yappl_transformation_functions/master/store.json")
    HEREDOC
  end
end
