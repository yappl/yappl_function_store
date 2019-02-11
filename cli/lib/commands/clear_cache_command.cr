class ClearCacheCommand
  def run(args = [] of String)
    Cache.new(URL).clear
    puts "Cache Cleared"
  end
end
