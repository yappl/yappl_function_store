function main(params) {
  return {
    functions: [
      { name: "anonymizer", description: "Replaces data with *" },
      { name: "only_provider", description: "return provider.tld from email" },
      { name: "none", description: "returns passed data (echo)" }
    ]
  }
}
