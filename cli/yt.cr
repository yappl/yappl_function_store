require "dotenv"
require "http/client"
require "json"
require "./lib/function.cr"
require "./lib/functions_wrapper.cr"
require "./lib/cache.cr"
require "./lib/argument_parser.cr"
require "./lib/commands/clear_cache_command.cr"
require "./lib/commands/deploy_command.cr"
require "./lib/commands/get_command.cr"
require "./lib/commands/help_command.cr"
require "./lib/commands/list_command.cr"
require "./lib/commands/search_command.cr"
require "./lib/commands/show_command.cr"
require "./lib/commands/url_command.cr"

Dotenv.verbose = false
Dotenv.load

DEFAULT_URL = "https://raw.githubusercontent.com/TPei/yappl_transformation_functions/master/store.json"

URL = ENV["URL"]? || DEFAULT_URL
class MainCommand
  def map
    {
      "help" => HelpCommand.new,
      "--help" => HelpCommand.new,
      "-h" => HelpCommand.new,
      "list" => ListCommand.new,
      "search" => SearchCommand.new,
      "show" => ShowCommand.new,
      "get" => GetCommand.new,
      "deploy" => DeployCommand.new,
      "clear" => ClearCacheCommand.new,
      "url" => UrlCommand.new
    }
  end

  def run(args = [] of String)
    return HelpCommand.new.run if args.size == 0
    command = args[0]
    return puts "not a valid command" unless map.has_key?(command)
    map[command].run(args[1..-1])
  end
end

MainCommand.new.run ARGV
