<template>
    <div class="Saisie">
        <Input placeholder="Nom" id="nom" type="text" value="" ref="login"> </Input>
        <br>
        <Input placeholder="Mot de passe" id="mdp" type="text" ref="password"> </Input>
        <br>
        <Button button-name="se connecter" :sendInfo="sendInfoHandler"></Button>
    </div>
</template>

<script>
import Input from '../components/Input.vue'
import Button from '../components/Button.vue'

export default {
    
    data(){
        return{
    
        }
    },
    components: {Input,Button},

    methods:{
        sendInfoHandler(){
            let name = this.$refs.login._data.donnee;
            console.log(name);
            // let password = this.$refs.password._data.donnee;
            // console.log(name + " " + password);
            // console.log("button clicker")

        }
    }
}

</script>

<style>

</style>