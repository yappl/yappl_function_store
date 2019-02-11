class FunctionsWrapper
  def self.functions
    functions = [] of Function

    cache = Cache.new URL
    if cache.active?
      functions = cache.functions
    else
      response = HTTP::Client.get URL
      obj = JSON.parse(response.body)
      response_body = obj["functions"].to_json

      functions = Array(Function).from_json(response_body)
    end
    cache.set(functions)
    return functions
  end

  def self.function_by(name)
    self.functions.find { |f| f.name == name }
  end
end
