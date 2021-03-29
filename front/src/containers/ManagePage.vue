<template>
    <div>
        <div class="row">
            <div class="col-sm-4 mx-auto" v-if="modifPrenom == false">votre prenom est : {{ this.$session.get('prenom') }} 
                <Button buttonName="⚙️" :sendInfo="modifierPrenom">
                </Button>
            </div>
            <div v-else class="col-sm-4 mx-auto">
                <Input :placeholder="this.$session.get('prenom')" id="prenom" type="text" value="" ref="prenom"></Input>
                <Button buttonName="modifier" :sendInfo="envoiePrenom">
                </Button>
            </div>
        </div>
    </div>
</template>

<script>
import Button from "../components/Button.vue";
import Input from "../components/Input.vue";
import axios from 'axios';
export default {
    data(){
        return{
            adresseApi: "http://localhost:19080/users",
            modifPrenom: false,
        }
    },
    components:{Button,Input},

    methods:{
        modifierPrenom(){
            console.log("je rentre de le modifier prenom");
            this.modifPrenom = true;
        },
        envoiePrenom(){
            let prenom = this.$refs.prenom._data.donnee;
            console.log(prenom);
            console.log(this.$session.get('prenom'));
            if( (prenom != "") && (prenom != this.$session.get('prenom'))){
                let data = {
                    id : this.$session.get('idUser'),
                    firstname: prenom
                }
                axios
                .post(this.adresseApi+"/update/firstname", data)
                .then(reponse => {
                        console.log('Reponse OK');
                        console.log(reponse);
                        if(reponse.data.message){
                            console.log(reponse.data.message);
                            this.alert = reponse.data.message;
                        }else{
                            this.$session.set('prenom', prenom);
                            this.modifPrenom = false;
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
        }
    }
}

</script>

<style>

</style>