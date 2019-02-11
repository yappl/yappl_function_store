class FunctionsWrapper
  def self.functions(url)
    functions = [] of Function

    cache = Cache.new(url)
    if cache.active?
      functions = cache.functions
    else
      response = HTTP::Client.get url
      obj = JSON.parse(response.body)
      response_body = obj["functions"].to_json

      functions = Array(Function).from_json(response_body)
    end
    cache.set(functions)
    return functions
  end

  def self.function_by(name, url)
    self.functions(url).find { |f| f.name == name }
  end
end
