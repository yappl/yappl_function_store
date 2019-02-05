# YaPPL Transformation Store CLI (yt)

Usages:
- yt list -> shows available functions
- yt search -> searches for functions
  - yt search [-n name | -a author | -c compatibilities]
- yt show function_name -> shows info about a function
- yt get function_name -> donwloads function
- yt deploy function_name [-p package_name | -f function_name | -i info] deploys a function

--

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

--

Show available transformation functions

Usage:
  yt list

--

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
  -c, --compatibility   search function by compatibiity

--

Show more in-depth info on a function

Usage:
  yt show (function_name)

Examples:
  yt show median

Flags:
  -h, --help   help for show command

--

Download a function

Usage:
  yt get (function_name)

Examples:
  yt get median

Flags:
  -h, --help   help for get command

--

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

