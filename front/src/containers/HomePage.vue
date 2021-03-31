<template>
    <div>
        <div class="Saisie">     
            <div>
                <b-alert variant="danger" v-if="this.alert !== ''" show dismissible>
                    {{ this.alert }} 
                </b-alert>
            </div>
            <div class="container test">
                <Input placeholder="Pseudo" id="nom" type="text" value="" ref="login"> </Input>
                <br>
                <Input placeholder="Mot de passe" id="mdp" type="password" :sendInfo="sendInfoHandler" ref="password"> </Input>
                <br>
                <Button buttonName="Se connecter" :sendInfo="sendInfoHandler"></Button>
            </div>
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
            this.alert= '';
            console.log(this.alert);
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
                    console.log("voici l'alert : " + this.alert);
                }else{
                    this.$session.start();
                    this.$session.set('idUser', reponse.data.idMembers);
                    this.$session.set('username', reponse.data.pseudo);
                    this.$session.set('prenom', reponse.data.firstname);
                    this.$session.set('nom', reponse.data.lastname);
                    this.$session.set('mail', reponse.data.mail);
                    this.$session.set('pwd', pwd);
                    this.connection = true;
                    this.$router.push('/events');
                    document.location.reload();
                }
            })
            .catch(error => {
                console.log(error);
                this.errored = true;
            })
            .finally( () => {
                this.loading = false;
            }); 
            }else{
                console.log("erreur l'une des chaines est vide");
                
                this.alert = "erreur l'une des chaines est vide";
                console.log(this.alert);
                // this.$refs.login._data.value = mail;
            }

        },
    },
    
    created(){
        if(this.$session.exists()) {
            this.$router.push('/events');
        }  
    }
}

</script>

<style>
    .test{
        text-align: center;

    }


</style>