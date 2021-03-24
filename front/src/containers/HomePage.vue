<template>
    <div class="Saisie">
        <Input placeholder="login" id="nom" type="text" value="" ref="login"> </Input>
        <br>
        <Input placeholder="Mot de passe" id="mdp" type="password" ref="password"> </Input>
        <br>
        <Button buttonName="se connecter" :sendInfo="sendInfoHandler"></Button>
    </div>
</template>

<script>
import Input from '../components/Input.vue'
import Button from '../components/Button.vue'
import axios from 'axios'

export default {
    
    data(){
        return{
            adresseApi: "http://localhost:19080/users/connection/checkRegistered?login=",
            connecter: '',
        }
    },
    components: {Input,Button},

    methods:{
        sendInfoHandler(){
            let login = this.$refs.login._data.donnee;
            console.log(login);
            let pwd = this.$refs.password._data.donnee;
            console.log(pwd)
            console.log(this.adresseApi+login+"&pwd="+pwd)
            if((login != "") && (pwd != "")){
                axios
                .get(this.adresseApi+login+"&pwd="+pwd)
                .then(reponse => {
                console.log('Reponse OK');
                console.log(reponse);
                this.connecter = reponse.data.Search;
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
    }
}

</script>

<style>

</style>