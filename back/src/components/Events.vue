<template>
  <div class="pannel">
    <h1>Evenements</h1>
    <p>
      Retrouvez ici tous les évènements
    </p>
  </div>
</template>

<script>
  export default {
    name: 'events',
    data() {
      return {
        events:[],
      };
    },

    mounted() {
      axios
              .get("http://localhost:19080/events")
              .then (response => {
                console.log(response.data)
                this.users = response.data
              })
    }
  }
</script>

<style>

</style>