import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import BootstrapVue from 'bootstrap-vue'
import VueSession from 'vue-session'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

import CreateEventPage from './containers/CreateEventPage.vue';
import EventsPage from './containers/Events/EventsPage.vue';
import EventPage from './containers/Events/EventPage.vue';
import HomePage from './containers/HomePage.vue';
import RegisterPage from './containers/RegisterPage.vue';
import LogoutPage from './containers/LogoutPage.vue';

Vue.use(VueRouter);
Vue.use(BootstrapVue);
Vue.use(VueSession);

const router = new VueRouter({
  mode:'history',
  routes:[
      { path: "/", component:HomePage },
      { path: "/create", component: CreateEventPage},
      { path: "/register", component: RegisterPage},
      { path: "/logout", component: LogoutPage},

      // Événements
      { path: "/events", component: EventsPage },
      { path: "/events/:urlEvent", component: EventPage},
    ]
  })

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
