<template>
  <div class="pannel">
    <h1>Utilisateurs</h1>
    <p>
      Retrouvez ici tous les utilisateurs qui utilisent Reunionou
    </p>

    <section class="error" v-if="errored">
      <b-alert show variant="danger"><i>Nous sommes désolés, {{ alertError }}. Veuillez réessayer.</i></b-alert>
    </section>

      <b-list-group class="liste">
         <b-list-group-item v-if="!error" class="d-flex justify-content-between align-items-center" v-for="user in users">
        <b-badge variant="dark" pill>{{user.idMembers}}</b-badge>
        <div><i>Nom: </i>
          {{user.firstname}}
            {{user.lastname}}
        
        </div>
        <div><i>Mail: </i> {{user.mail}}</div>
           <div><i>Dernière connexion: </i> {{user.last_connexion}}</div>

        <b-button v-on:click="checkForm(user.idMembers)" variant="outline-danger">Supprimer</b-button>
      </b-list-group-item>

    </b-list-group>



  </div>
</template>

<script>
  import moment from 'moment'

  export default {
 
    name: 'users',
    data() {
      return {
        users:[],
        id:null,
        errored : false,
        alertError:"",
        dateConnexion:null,
        error:"",
        urlApi: "http://docketu.iutnc.univ-lorraine.fr:13003/",
        // urlApi: "http://localhost:19080/",

      };
    },
    methods: {
      checkForm(id) {
        this.dateConnexion=null;
          console.log(id)
          axios
                  .get(this.urlApi+"/users/"+id)
                  .then (response => {
                    this.dateConnexion= response.data[0].last_connexion;
                    let day = this.dateConnexion.substr(0, 2);
                    let mm = this.dateConnexion.substr(3,2);
                    let yy= this.dateConnexion.substr(6,4);

                    var d = new Date();
                    d.setDate(d.getDate()-60);
                    var dC = new Date(yy+"-"+mm+"-"+day);

                    if(dC < d){
                      var r = confirm("Êtes-vous sur ?");
                      if (r == true) {
                        axios.post(this.urlApi+"/users/delete/member", {
                          id:id
                        }).then(res => {
                          this.errored = false;
                          axios
                                  .get(this.urlApi+"/users")
                                  .then (response => {
                                    console.log(response.data)
                                    this.users = response.data
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
                      this.alertError = "L'utilisateur est actif"

                    }
                  })

      },

     
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
    width: 70%;
    margin: auto;
  }

  .error{
    width: 30%;
    margin: auto;
  }

</style>