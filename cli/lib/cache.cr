#CACHE_FILE = "~/.yt/cache.json" # fails for some reason
CACHE_FILE = ".cache.json"

class Cache
  def initialize(@url : String)
    if File.exists?(CACHE_FILE)
      data = JSON.parse(File.read(CACHE_FILE))
      url = data["url"].to_s
      expiration = data["expiration"].to_s

      le_functions = data["functions"].to_json
      @functions = Array(Function).from_json(le_functions)

      expiration_time = Time.parse(expiration, "%c", Time::Location.load("Europe/Berlin"))
      if(expiration_time > Time.now)
        @active = true
      else
        @active = false
      end
    else
      @active = false
      @functions = [] of Function
    end
  end

  def active?
    @active
  end

  def clear
    if File.exists?(CACHE_FILE)
      File.delete(CACHE_FILE)
    end
  end

  # TODO: multiple entries, one per url
  def set(functions : Array(Function))
    str = <<-HEREDOC
    {
      "url": "#{@url}",
      "expiration": "#{(Time.now + 10.minutes).to_s("%c")}",
      "functions": [
        #{functions.map { |f| f.to_json }.join(",\n")}
      ]
    }
    HEREDOC
    File.write(CACHE_FILE, str)
    true
  end

  def functions
    @functions
  end
end
