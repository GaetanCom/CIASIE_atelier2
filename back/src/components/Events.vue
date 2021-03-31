<template>
  <div class="pannel">
    <h1>Evenements</h1>
    <p>
      Retrouvez ici tous les évènements
    </p>

    <section class="error" v-if="errored">
      <b-alert show variant="danger"><i>Nous sommes désolés, {{ alertError }}</i></b-alert>
    </section>

     <b-list-group class="liste">
      <b-list-group-item class="d-flex justify-content-between align-items-center" v-for="event in events">
        <b-badge variant="dark" pill>{{event.id}}</b-badge>
        <div><i>Nom: </i>
          {{event.title}}
        
        </div>
        <div><i>Date: </i> {{event.date}}</div>

        <b-button v-on:click="checkForm(event.id, event.date)" variant="outline-danger">Supprimer</b-button>
      </b-list-group-item>

    </b-list-group>
  </div>
</template>

<script>
  export default {
    name: 'events',
    data() {
      return {
        urlApi: "http://docketu.iutnc.univ-lorraine.fr:13003/events/",
        events:[],
        date:null,
        errored:false,
        alertError:""
      };
    },
    methods: {
      checkForm(id, date) {
        let day = date.substr(0, 2);
        let mm = date.substr(3,2);
        let yy= date.substr(6,4);

        var d = new Date();
        d.setDate(d.getDate()-14);
        var dC = new Date(yy+"-"+mm+"-"+day);

        if(dC < d){
          var r = confirm("Êtes-vous sur ?");
          if (r == true) {
            axios.delete(this.urlApi+"/event", {
              id:id
            }).then(res => {
              this.errored = false;
              axios
                      .get(this.urlApi +"/events")
                      .then (response => {
                        console.log(response.data)
                        this.events = response.data
                      })
            }).catch(err => {
              console.log(err)
              this.errored = true;
              this.alertError = "Erreur"
            })
          } else {

          }

        }else{
          this.errored=true;
          this.alertError = "L'évènement est actif"

        }


      },


    },

    mounted() {
      axios
              .get("http://docketu.iutnc.univ-lorraine.fr:13003/events")
              .then (response => {
                console.log(response.data)
                this.events = response.data
              })
    }
  }
</script>

<style>

</style>