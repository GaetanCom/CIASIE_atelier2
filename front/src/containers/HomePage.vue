<template>
    <div class="Saisie">
        <Input placeholder="Nom" id="nom" type="text"> </Input>
        <br>
        <Input placeholder="Mot de passe" id="mdp" type="text"> </Input>
    </div>
</template>

<script>
import Input from '../components/Input.vue'

export default {
    
    data(){
        return{

        }
    },
    components: {Input}
}

</script>

<style>

</style>