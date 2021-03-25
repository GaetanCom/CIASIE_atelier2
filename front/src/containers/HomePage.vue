<template>
    <div class="Saisie">
        <div class="alert" v-if="this.alert !== '' ">
            <span class="closebtn" onclick="this.parentElement.style.display='none';">&times;</span>
                {{ this.alert }}
        </div>
        <div>
            <Input placeholder="login" id="nom" type="text" value="" ref="login"> </Input>
            <br>
            <Input placeholder="Mot de passe" id="mdp" type="password" :sendInfo="sendInfoHandler" ref="password"> </Input>
            <br>
            <Button buttonName="se connecter" :sendInfo="sendInfoHandler"></Button>
        </div>
    </div>
</template>

<script>
import Input from '../components/Input.vue'
import Button from '../components/Button.vue'
import axios from 'axios'
// import hash from 'password-hash'

export default {
    
    data(){
        return{
            adresseApi: "http://docketu.iutnc.univ-lorraine.fr:13003/users/connection/checkRegistered?login=",
            connecter: '',
            alert: '',
            connection: false,
        }
    },
    components: {Input,Button},

    methods:{
        sendInfoHandler(){
            let login = this.$refs.login._data.donnee;
            console.log(login);
            let pwd = this.$refs.password._data.donnee;
            console.log(pwd);
            // console.log(hash.generate(pwd));
            console.log(this.adresseApi+login+"&pwd="+pwd);
            // axios.defaults.headers.common['header'] = 'Access-Control-Allow-Origin: localhost:8081';
            if((login != "") && (pwd != "")){
                axios
                .get(this.adresseApi+login+"&pwd="+pwd)
                .then(reponse => {
                console.log('Reponse OK');
                console.log(reponse);
                if(reponse.data.message){
                    console.log(reponse.data.message)
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
                console.log("erreur l'une des chaines est vide");
                // this.$refs.login._data.value = mail;
            }

        }
    },
    created(){
        console.log("je creer la homepage")
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