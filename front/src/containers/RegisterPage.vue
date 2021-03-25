<template>
    <div id="inscriptions">
        <div class="alert" v-if="this.alert !== '' ">
            <span class="closebtn" v-on:click="supprimerAlert">&times;</span>
                {{ this.alert }}
        </div>
        <Input  placeholder="prénom" id="prenom" type="text" value="" ref="firstname"> </Input>
        <br>
        <Input  placeholder="Nom" id="nom" type="text" value="" ref="name"> </Input>
        <br>
        <Input  placeholder="Mail" id="mail" type="email" value="" ref="mail"> </Input>
        <br>
        <Input  placeholder="Pseudo" id="login" type="text" value="" ref="login"> </Input>
        <br>
        <Input  placeholder="mot de passe" id="password" type="password" value="" ref="password"> </Input>
        <br>
        <Input  placeholder="comfirmer mot de passe" id="coPassword" type="password" value="" :sendInfo="sendInfoInscription" ref="coPassword"> </Input>
        <br>
        <Button buttonName="s'inscrire" :sendInfo="sendInfoInscription" ></Button>
    </div>
</template>

<script>
import Input from "../components/Input"
import Button from "../components/Button"
import axios from "axios"

export default {

    data(){
        return{
            // adresseApi: "http://docketu.iutnc.univ-lorraine.fr:13003/users/connection/signup",
            adresseApi: "http://localhost:19080/users/connection/signup",
            alert: "",
        }
    },
    components:{Input,Button},

    methods:{
        sendInfoInscription(){
            let prenom = this.$refs.firstname._data.donnee;
            let nom = this.$refs.name._data.donnee;
            let mail = this.$refs.mail._data.donnee;
            let login = this.$refs.login._data.donnee;
            let pwd = this.$refs.password._data.donnee;
            let verif = this.$refs.coPassword._data.donnee;
            console.log(prenom + " " + nom + " " + mail + " " + login + " " + pwd + " " + verif + " " );

            if((login != "") && (pwd != "") && (prenom != "") && (nom != "") && (mail != "") && (verif != "") ){
                if( pwd == verif){
                    let data = {
                        firstname: prenom,
                        lastname: nom,
                        mail: mail,
                        pseudo: login,
                        password: pwd
                    }
                    axios
                    .post(this.adresseApi, data)
                    .then(reponse => {
                        console.log('Reponse OK');
                        console.log(reponse);
                        if(reponse.data.message){
                            console.log(reponse.data.message);
                            this.alert = reponse.data.message;
                        }else{
                            this.connection = true;
                        }
                    })
                    .catch(error => {
                        console.log(error);
                        this.errored = true;
                    })
                    .finally( () => this.loading = false); 
                }else{
                    this.alert = "mot de passe non identique !";
                }
            }else{
                this.alert = "erreur au moins une des chaines est vide";
            }
        },
        supprimerAlert(){
            this.alert = '';
        }
    }
    
}

</script>

<style>

.alert {
  padding: 20px;
  background-color: #f44336; /* Red */
  color: white;
  margin-bottom: 15px;
}

/* The close button */
.closebtn {
  margin-left: 15px;
  color: white;
  font-weight: bold;
  float: right;
  font-size: 22px;
  line-height: 20px;
  cursor: pointer;
  transition: 0.3s;
}

/* When moving the mouse over the close button */
.closebtn:hover {
  color: black;
}

</style>