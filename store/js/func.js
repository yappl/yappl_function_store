function _classCallCheck(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}

var Func = function Func(func) {
  _classCallCheck(this, Func);
  this.name = func.name;
  this.description = func.description;
  this.author = func.author;
  if(this.author == undefined || this.author == "")
    this.author = 'unknown'

  this.compatibility = func.compatibility

  this.image_url = func.image_url
  if(this.image_url == undefined || this.image_url == "")
    this.image_url = 'https://www.ibm.com/cloud-computing/bluemix/sites/default/files/assets/page/IBM%20Cloud%20Functions%20Logo%20Primary_0_0.png'

  this.repo_link = func.repo_link
  this.code_link = func.code_link
}
