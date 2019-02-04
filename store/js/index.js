var app = new Vue({
  el: '#app',
  data: {
    func: new Func({}),
    cart: [],
    search: '',
    functions: [
      new Func({
        name: 'anonymizer',
        description: 'Replaces data with *',
        author: 'tpei',
        compatibility: ['string'],
        image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Anonymous_emblem.svg/1200px-Anonymous_emblem.svg.png',
        repo_link: 'https://github.com/TPei/thesis_code/tree/master/functions/transformation_orchestration/anonymizer',
        code_link: 'https://github.com/TPei/thesis_code/tree/master/functions/transformation_orchestration/anonymizer'
      }),

      new Func({
        name: 'only_provider',
        description: 'return provider.tld from email',
        author: 'tpei',
        compatibility: ['string'],
        image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/%28at%29.svg/220px-%28at%29.svg.png'
      }),

      new Func({
        name: 'none',
        description: 'returns passed data (echo)',
        author: 'tpei',
        compatibility: ['json'],
      }),

      new Func({
        name: 'hourly_average',
        description: 'Returns averages aggregated by hour',
        author: 'TU Berlin',
        compatibility: ['timeseries'],
        image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/BahnhofsuhrZuerich_RZ.jpg/220px-BahnhofsuhrZuerich_RZ.jpg'
      }),

      new Func({
        name: 'hourly_medians',
        description: 'Returns medians aggregated by hour',
        author: 'TU Berlin',
        compatibility: ['timeseries'],
        image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/BahnhofsuhrZuerich_RZ.jpg/220px-BahnhofsuhrZuerich_RZ.jpg'
      }),

      new Func({
        name: 'hourly_min_max',
        description: 'Returns mins and maxs aggregated by hour',
        author: '',
        compatibility: ['timeseries'],
        image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b7/BahnhofsuhrZuerich_RZ.jpg/220px-BahnhofsuhrZuerich_RZ.jpg'
      }),

      new Func({
        name: 'median',
        description: 'Returns median of an array',
        author: '',
        compatibility: ['array(number)', 'array(boolean)', 'array(string)'],
        image_url: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Comparison_mean_median_mode.svg/300px-Comparison_mean_median_mode.svg.png'
      })
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
    },
    cartNotEmpty: function() {
      return this.cart.length > 0;
    },
    downloadCart: function() {
      let text = "packages:\n  function_store:\n    actions:\n"
      this.cart.forEach(function(func) {
        text += "      " + func.name + ":\n"
        text += "        function: " + func.code_link + "\n"
      })
      let element = document.createElement('a');
      element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
      element.setAttribute('download', 'manifest.yml');

      element.style.display = 'none';
      document.body.appendChild(element);

      element.click();

      document.body.removeChild(element);
    },
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
