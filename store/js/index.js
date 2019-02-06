var app = new Vue({
  el: '#app',
  data: {
    store_url: "https://raw.githubusercontent.com/TPei/yappl_transformation_functions/master/store.json",
    func: new Func({}),
    cart: [],
    search: '',
    functions: []
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
    showStoreUrl: function() {
      $("#store-url-modal").modal('show');
    },
    setStoreUrl: function() {
      const url = $("#store-url-input").val();
      $("#store-url-input").val("");
      this.store_url = url;
      this.fetchFunctions();
      $("#store-url-modal").modal('hide');
    },
    fetchFunctions: function() {
      //$.ajaxSetup({ cache: false });
      $.getJSON(this.store_url, function(data) {
        this.setFunctions(data.functions);
      }.bind(this));
    },
    setFunctions: function(functions) {
      this.functions = functions.map(f => new Func(f))
    },
  },

  mounted: function() {
    // TODO: should work...
    //Vue.nextTick()
      //.then(function () {
        //this.fetchFunctions();
    //}.bind(this))

    setTimeout(function(){
      this.fetchFunctions();
    }.bind(this), 100);
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
