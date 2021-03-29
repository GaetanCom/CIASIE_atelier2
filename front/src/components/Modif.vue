<template>
    <div class="row">
            <div class="col-sm-4 mx-auto" v-if="modifEtat == false">votre {{ valeur }}  est : {{ this.$session.get(valeur) }} 
                <Button buttonName="⚙️" :sendInfo="modifierEtat">
                </Button>
            </div>
            <div v-else class="col-sm-4 mx-auto">
                <Input :placeholder="this.$session.get(valeur)" :id="valeur" type="text" value="" :ref="valeur"></Input>
                <Button buttonName="modifier" :sendInfo="envoieValeur">
                </Button>
            </div>
    </div>
</template>

<script>
import Button from "./Button.vue";
import Input from "./Input.vue";
import axios from 'axios';

export default {
    data(){
        return {
            adresseApi: "http://localhost:19080/users",
            modifEtat: false,
        }
    },

    props:['valeur','path'],

    components:{Button,Input},

    methods:{
        modifierEtat(){
            console.log("je rentre dans le modif Etat")
            this.modifEtat = true;
        },
        envoieValeur(){
            let value ="";
            let data;
            console.log("je suis avant la serie de if et la valeur du props est : "+this.valeur)
            if(this.valeur == "mail"){
                value = this.$refs.mail._data.donnee;
                data = {
                    id : this.$session.get('idUser'),
                    mail: value
                }
            }else if (this.valeur == "username"){
                value = this.$refs.username._data.donnee;
                data = {
                    id : this.$session.get('idUser'),
                    pseudo: value
                }
            }else if (this.valeur == "prenom"){
                value = this.$refs.prenoms._data.donnee;
                data = {
                    id : this.$session.get('idUser'),
                    firstname: value
                }
            }else if (this.valeur == "nom"){
                value = this.$refs.nom._data.donnee;
                data = {
                    id : this.$session.get('idUser'),
                    lastname: value
                }
            }
            // let value = this.$refs.(this.valeur)._data.donnee;
            console.log(value);
            console.log(this.$session.get(this.valeur));
            if( (value != "") && (value != this.$session.get(this.valeur))){
                axios
                .post(this.adresseApi+"/update/"+this.path, data)
                .then(reponse => {
                        console.log('Reponse OK');
                        console.log(reponse);
                        if(reponse.data.message){
                            console.log(reponse.data.message);
                            this.alert = reponse.data.message;
                        }else{
                            this.$session.set(this.valeur, value);
                            this.modifEtat = false;
                        }
                })
                .catch(error => {
                    console.log(error);
                    this.errored = true;
                })
                .finally( () => this.loading = false); 
            }else{
                console.log("quelques choses c'est mal passé !")
            }
        },
    },
}

</script>

<style>

</style>