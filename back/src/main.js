import Vue from 'vue'
import App from './App.vue'
import VueRouter from 'vue-router'
import axios from 'axios'


import HomePage from './components/HomePage'
import Users from './components/Users.vue'
import Events from './components/Events.vue'
import LoginComponent from "./components/Login.vue"

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'

import Notfound from './components/Notfound.vue'

import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'

Vue.use(BootstrapVue)
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin)
Vue.use(VueRouter)

const router = new VueRouter ({
  mode : 'history',

  routes: [
    {
      path: '/',
      redirect: {
        name: "login"
      }
    },
    {
      path: "/login",
      name: "login",
      component: LoginComponent
    },
    {
      path: "/home",
      name: "home",
      component: HomePage
    },
    {
      path: "/users",
      name: "users",
      component: Users
    },
    {
      path: "/events",
      name: "events",
      component: Events
    }
  ]
})

new Vue({
  el: '#app',
  router,
  render: h => h(App)
})
