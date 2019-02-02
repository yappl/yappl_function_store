function main(params) {
  return {
    functions: [
      {
        name: "anonymizer",
        description: "Replaces data with *",
        author: "tpei",
        compatibility: ["string"],
        image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Anonymous_emblem.svg/1200px-Anonymous_emblem.svg.png",
        link: 'https://github.com/TPei/thesis_code/tree/master/functions/transformation_orchestration/anonymizer'
      },
      {
        name: "only_provider",
        description: "return provider.tld from email",
        author: "tpei"
        compatibility: ["string"],
        image_url: null,
        link: null
      },
      {
        name: "none",
        description: "returns passed data (echo)",
        author: "tpei"
        compatibility: ["json"],
        image_url: null,
        link: null
      }
    ]
  }
}
