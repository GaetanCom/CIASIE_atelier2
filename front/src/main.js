import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'

import HomePage from './containers/HomePage.vue';
import EventsPage from './containers/EventsPage.vue';
import CreateEventPage from './containers/CreateEventPage.vue';
import RegisterPage from './containers/RegisterPage.vue';

Vue.use(VueRouter);

const router = new VueRouter({
  mode:'history',
  routes:[
      {
        path: "/", component:HomePage
      },
      {
        path: "/events", component: EventsPage
      },
      {
        path: "/create", component: CreateEventPage
      },
      {
        path: "/register", component: RegisterPage
      }
    ]
  })

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
