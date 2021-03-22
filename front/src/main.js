import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'

import HomePage from './containers/HomePage.vue';

Vue.use(VueRouter);

const router = new VueRouter({
  mode:'history',
  routes:[
    {
      path: "/", component:HomePage
    }
  ]
})

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
