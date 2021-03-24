<template>
  <div id="app">
    <img src="src/assets/logo_reunionou.png">

    <div class="nav">
      <ul class="menu">
        <router-link class="link" v-if="authenticated" to="/login" v-on:click.native="logout()" replace  title="Déconnexion"><span class="icon-cancel-circle" title="Déconnexion"></span></router-link>
        <router-link class="link" v-if="authenticated" to="/home" title="Accueil"><span class="icon-home" title="Accueil"></span></router-link>
        <router-link class="link" v-if="authenticated" to="/users"  title="Utilisateurs"><span class="icon-users" title="Utilisateurs"></span></router-link>
        <router-link class="link" v-if="authenticated" to="/events" title="Évènements"><span class="icon-calendar" title="Évènements"></span></router-link>
      </ul>

    </div>
    <router-view @authenticated="setAuthenticated" />
  </div>
</template>

<script>
  export default {
    name: 'App',
    data() {
      return {
        authenticated: false,

      }
    },
    mounted() {
      if(!this.authenticated) {
        this.$router.replace({ name: "login" });
      }
    },
    methods: {
      setAuthenticated(status) {
        this.authenticated = status;
      },
      logout() {
        this.authenticated = false;
      }
    }
  }
</script>

<style>
  body {
    background-color: white;
  }

  h1, h2, h3{
    color: deepskyblue;
  }

  .nav ul {
    margin: 20px auto;
    padding: 0px;
    background-color: rgb(241,241,241);
    list-style:none;
    font-size: 22px;
  }

  .nav a {
    padding: 1em;
    display: block;
    text-align:center;
    text-decoration: none;
    color:black;
    font-family: sans-serif;
  }
  .nav a:hover {
    background-color: deepskyblue;

  }
  .nav .menu {
    display: flex; /*1*/
    flex-direction : row; /*2*/
    justify-content: center; /*3*/
  }

  @media(max-width: 750px) {
    .nav .menu{
      flex-flow: column wrap; /*4*/
    }
    .nav ul {
      margin: 20px auto;

    }

  }

  #app {
    margin: 50px auto 50px auto;
    text-align: center;
  }

  .icon-home:before {
     content: "\e900";
   }

  .icon-users:before {
    content: "\e972";
  }

  .icon-calendar:before {
    content: "\e953";
  }

  .icon-cancel-circle:before {
    content: "\ea0d";
  }
</style>