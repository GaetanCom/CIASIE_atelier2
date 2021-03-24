<template>
  <div class="pannel">
    <h1>Utilisateurs</h1>
    <p>
      Retrouvez ici tous les utilisateurs qui utilisent Reunionou
    </p>

    <b-list-group class="liste">
      <b-list-group-item class="d-flex justify-content-between align-items-center" v-for="user in users">
        <b-badge variant="dark" pill>{{user.id}}</b-badge>
        <div><i>Nom: </i>
          {{user.firstname}}
        {{user.lastname}}
        </div>
        <div><i>Mail: </i> {{user.mail}}</div>

        <b-button variant="outline-danger">Supprimer</b-button>
      </b-list-group-item>

    </b-list-group>
  </div>
</template>

<script>
  export default {
    name: 'users',
    data() {
      return {
        users:[]
      };
    },
    mounted() {
      axios
              .get("http://localhost:19080/users")
              .then (response => {
                console.log(response.data)
                this.users = response.data
      })
    }
  }
</script>

<style>

  .liste{
    width: 50%;
    margin: auto;
  }

</style>