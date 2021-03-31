<template>
    <div class="container">
        <b-alert variant="danger" v-if="this.alert !== ''" show dismissible>
                    {{ this.alert }} 
        </b-alert>
        <Modif valeur="prenom" path="firstname"></Modif>
        <Modif valeur="nom" path="lastname"></Modif>
        <Modif valeur="mail" path="mail"></Modif>
        <Modif valeur="username" path="pseudo"></Modif>
        <div class="row">
            <div class="col-sm-6 mx-auto" v-if="modifPwd == false"> Modifier votre mot de passe 
                <Button buttonName="⚙️" :sendInfo="modifierPwd">
                </Button>
            </div>
            <div v-else class="col-sm-6 mx-auto">
                <Input placeholder="rentrer votre ancien mot de passe" id="lastpwd" type="password" value="" ref="lastpwd"></Input>
                <Input placeholder="taper votre nouveau mot de passe" id="pwd" type="password" value="" ref="pwd"></Input>
                <Input placeholder="retaper votre nouveau mot de passe" id="Checkpwd" type="password" value="" ref="checkpwd"></Input>
                <Button buttonName="modifier" :sendInfo="envoiePwd">
                </Button>
            </div>
        </div>

    </div>
</template>

<script>
import Button from "../components/Button.vue";
import Input from "../components/Input.vue";
import Modif from "../components/Modif";
import axios from 'axios';
export default {
    data(){
        return{
            // adresseApi: "http://localhost:19080/users",
            adresseApi: "http://docketu.iutnc.univ-lorraine.fr:13003",
            modifPwd: false,
            alert:"",
        }
    },
    components:{Button,Input,Modif},

    methods:{
        modifierPwd(){
            console.log("je rentre de le modifier prenom");
            this.modifPwd = true;
        },
        envoiePwd(){
            let lastPwd = this.$refs.lastpwd._data.donnee;
            let pwd = this.$refs.pwd._data.donnee;
            let checkpwd = this.$refs.pwd._data.donnee;

            console.log("ancien mot de passe d'abord taper puis la valeur enregistrer :");
            console.log(lastPwd);
            console.log(this.$session.get('pwd'));

            console.log("valeur du nouveau mot de passe rentrer d'abord le mot de passe puis le check");
            console.log(pwd);
            console.log(checkpwd);

            if( lastPwd == this.$session.get('pwd')){
                if( pwd == checkpwd){

                    let data = {
                        id : this.$session.get('idUser'),
                        newpassword: pwd,
                        oldpassword: lastPwd,
                    }

                    axios
                    .post(this.adresseApi+"/update/password", data)
                    .then(reponse => {
                            console.log('Reponse OK');
                            console.log(reponse);
                            if(reponse.data.message){
                                console.log(reponse.data.message);
                                this.alert = reponse.data.message;
                            }else{
                                this.$session.set('pwd', pwd);
                                this.modifPwd = false;
                            }
                    })
                    .catch(error => {
                        console.log(error);
                        this.errored = true;
                    })
                    .finally( () => this.loading = false); 
                }else{
                    console.log("les deux mot de passe ne sont pas identique !");
                }
            }else{
                console.log("votre mot de passe n'est pas bon !");
            }
        },
    }
}

</script>

<style>

</style>