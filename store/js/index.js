var app = new Vue({
  el: '#app',
  data: {
    store_url: "https://raw.githubusercontent.com/TPei/yappl_transformation_functions/master/store.json",
    deployerUrl: "", // read from env file
    func: new Func({}),
    cart: [],
    search: '',
    functions: [],
    showSpinner: true,
    deployOutput: [],
    preparedFunctionData: [],
    deployPrepareDone: false,
  },

  methods: {
    itemClicked: function(func) {
      this.func = func;
      $("#function-modal").modal('show');
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
    openDeployModal: function() {
      $('#cart-modal').modal('hide');
      $('#deploy-modal').modal('show');
      this.prepareFunctions();
    },
    prepareFunctions: function() {
      let self = this;

      this.deployOutput.push("Preparing Functions...");
      this.cart.forEach(function(func) {
        let name = func.name;
        let runtime = func.runtime;
        let url = func.code_link;

        self.deployOutput.push("Preparing " + name + "...");
        // do ajax call to get code...
        $.get(url, function(data) {
          let code = data;
          self.deployOutput.push("Done preparing " + name + "...")
          self.preparedFunctionData.push({ name: name, code: code, runtime: runtime });

          if(self.preparedFunctionData.length == self.cart.length) {
            self.deployOutput.push("Done preparing functions");
            self.deployPrepareDone = true;
            self.showSpinner = false;
            self.deployOutput.push("$divider");
          }
        });
      });
    },
    deployFunctions: function() {
      this.showSpinner = true;

      let self = this;
      let deployData = [];
      let errors = false;
      let package = $('#package-name').val();

      this.preparedFunctionData.forEach(function(func) {
        let name = func.name;
        let runtime = func.runtime;
        let code = func.code;

        self.deployerUrl = env.url
        self.deployOutput.push("Deploying " + name + "...");

        let deployRequestBody = JSON.stringify(
          { name: name, package: package, code: code, runtime: runtime }
        )

        $.ajax({
          type: "POST",
          url: self.deployerUrl,
          data: deployRequestBody,
          contentType: "application/json; charset=utf-8",
          dataType: "json"
        })
          .done(function(data) {
            if(data.hasOwnProperty('error')) {
              self.deployOutput.push("Error deploying " + name + ": " + data.error.error);
              errors = true;
            } else if (data.hasOwnProperty('name')) {
              self.deployOutput.push("Deployed " + data.name + " successfully...");
            } else {
              self.deployOutput.push("Issues deploying " + name + ". Might not have worked...");
            }
            // TODO: check if error and display accordingly
          }).fail(function(data) {
            self.deployOutput.push("Deploying " + name + " failed! :(");
            errors = true;
          }).always(function(data) {
            deployData.push(name);
            if(deployData.length == self.cart.length) {
              self.deployOutput.push("$divider");
              self.deployOutput.push("Done deploying functions!");
              if(errors == true)
                self.deployOutput.push("There were some errors :(");

              self.showSpinner = false;
              self.preparedFunctionData = [];
              self.deployPrepareDone = false;
            }
          })
      });
    },
    closeDeployDialog: function() {
      this.deployOutput = [];
      this.showSpinner = true;
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
      $.ajaxSetup({ cache: false });
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
