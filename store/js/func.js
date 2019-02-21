class Func {
  constructor(func) {
    this.name = func.name;
    this.short_description = func.short_description;
    this.description = func.description;
    this.author = func.author;
    if(this.author == undefined || this.author == "")
      this.author = 'unknown'

    this.compatibility = func.compatibility
    this.runtime = func.runtime

    this.image_url = func.image_url
    if(this.image_url == undefined || this.image_url == "") {
      if (Math.random() > 0.5) {
        this.image_url = './images/cloud_function.png'
      } else {
        this.image_url = './images/openwhisk.jpg'
      }
    }

    this.repo_link = func.repo_link
    this.code_link = func.code_link
  }
}
