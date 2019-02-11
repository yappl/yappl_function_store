class ArgumentParser
  def self.parse(allowed = {} of String => Integer, args = [] of Array(String))
    # receives map like
    # to show how many parameters an argument has
    # input = {
    #   "-h" => 0,
    #   "--help" => 0,
    #   "-i" => 1,
    #   "--info" => 1,
    #   "-n" => 1,
    #   "--name" => 1,
    #   "-p" => 1,
    #   "--package" => 1,
    #   "-u" => 1,
    #  "--url" => 1
    # }
    # and returns map like
    # to show which flags where used with what arguments
    # result = {
    #   "--help" => [] of String,
    #   "-i" => ["some_name"],
    #   "--name" => ["some_name"],
    #   "--url" => ["some url"]
    # }

    result = {} of String => Array(String)

    allowed.each do |key, value|
      index = args.index(key)

      if !index.nil?
        relevant = args[index..(index+value)]
        result[relevant[0]] = relevant[1..-1]
      end
    end

    return result
  end
end

#puts ArgumentParser.parse(
  #{
    #"-h" => 0,
    #"--help" => 0,
    #"-i" => 1,
    #"--info" => 1,
    #"-n" => 1,
    #"--name" => 1,
    #"-p" => 1,
    #"--package" => 1,
    #"-u" => 1,
    #"--url" => 1
  #},
  #["-h", "--url", "https://fake.com"]
#)
