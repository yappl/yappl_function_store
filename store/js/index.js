function _classCallCheck(instance, Constructor) {
  if (!(instance instanceof Constructor)) {
    throw new TypeError("Cannot call a class as a function");
  }
}
var Func = function Func(name, description, author, compatibility, image_url, link) {
  _classCallCheck(this, Func);
  this.name = name;
  this.description = description;
  this.author = author;
  if(this.author == undefined || this.author == "")
    this.author = 'unknown'

  this.compatibility = compatibility

  this.image_url = image_url
  if(this.image_url == undefined || this.image_url == "")
    this.image_url = 'https://www.ibm.com/cloud-computing/bluemix/sites/default/files/assets/page/IBM%20Cloud%20Functions%20Logo%20Primary_0_0.png'

  this.link = link
};

var app = new Vue({
  el: '#app',
  data: {
    func: new Func(),
    cart: [],
    search: '',
    functions: [
      new Func(
        'anonymizer',
        'Replaces data with *',
        'tpei',
        ['string'],
        'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Anonymous_emblem.svg/1200px-Anonymous_emblem.svg.png',
        'https://github.com/TPei/thesis_code/tree/master/functions/transformation_orchestration/anonymizer'
      ),

      new Func(
        'only_provider',
        'return provider.tld from email',
        'tpei',
        ['string'],
        'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/%28at%29.svg/220px-%28at%29.svg.png'
      ),

      new Func(
        'none',
        'returns passed data (echo)',
        'tpei',
        ['json'],
      ),

      new Func(
        'hourly_average',
        'Returns averages aggregated by hour',
        'TU Berlin',
        ['timeseries'],
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/BahnhofsuhrZuerich_RZ.jpg/220px-BahnhofsuhrZuerich_RZ.jpg'
      ),

      new Func(
        'hourly_medians',
        'Returns medians aggregated by hour',
        'TU Berlin',
        ['timeseries'],
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/BahnhofsuhrZuerich_RZ.jpg/220px-BahnhofsuhrZuerich_RZ.jpg'
      ),

      new Func(
        'hourly_min_max',
        'Returns mins and maxs aggregated by hour',
        '',
        ['timeseries'],
        'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/BahnhofsuhrZuerich_RZ.jpg/220px-BahnhofsuhrZuerich_RZ.jpg'
      ),
      new Func(
        'median',
        'Returns median of an array',
        '',
        ['array(number)', 'array(boolean)', 'array(string)'],
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Comparison_mean_median_mode.svg/300px-Comparison_mean_median_mode.svg.png'
      )
    ]
  },

  methods: {
    itemClicked: function(func) {
      this.func = func;
      $("#my-modal").modal('show');
    },
    showCart: function() {
      $("#cart-modal").modal('show');
    },
    addToCart: function(func) {
      // only add if not in there yet
      if(this.cart.findIndex(el => el === func) == -1)
        this.cart.push(func);
    },
    removeFromCart: function(func) {
      const index = this.cart.findIndex(el => el === func)
      if(index > -1)
        this.cart.splice(index, 1);
    },
    isInCart: function(func) {
      if(this.cart.findIndex(el => el === func) == -1)
        return false;
      return true;
    }
  },

  computed: {
    filteredList: function filteredList() {
      var _this = this;
      return this.functions.filter(function(func) {
        included = false;
        if(func.name.toLowerCase().includes(_this.search.toLowerCase()))
          included = true;

        let match = func.compatibility.map(function(compat) {
          return compat.toLowerCase().includes(_this.search.toLowerCase())
        }).some(ele => ele == true)

        if(match == true)
          included = true;

        if(func.author.toLowerCase().includes(_this.search.toLowerCase()))
          included = true;

        return included;
      });
    }
  }
});
