function main(params) {
  return {
    functions: [
      {
        name: "anonymizer",
        description: "Replaces data with *",
        author: "tpei"
      },
      {
        name: "only_provider",
        description: "return provider.tld from email",
        author: "tpei"
      },
      {
        name: "none",
        description: "returns passed data (echo)",
        author: "tpei"
      }
    ]
  }
}
