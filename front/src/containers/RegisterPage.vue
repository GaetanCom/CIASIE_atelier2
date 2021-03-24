<template>
    <div id="inscriptions">
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
        <Input  placeholder="comfirmer mot de passe" id="coPassword" type="password" value="" ref="coPassword"> </Input>
        <br>
        <Button buttonName="s'inscrire" ></Button>
    </div>
</template>

<script>
import Input from "../components/Input"
import Button from "../components/Button"

export default {

    data(){
        return{

        }
    },
    components:{Input,Button}
    
}

</script>

<style>

</style>