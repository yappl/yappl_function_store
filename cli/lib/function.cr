class Function
  JSON.mapping(
    name: String,
    description: String,
    compatibility: Array(String),
    author: String,
    runtime: String,
    image_url: String?,
    repo_link: String,
    code_link: String,
  )
end
