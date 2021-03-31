<template>
    <button class="button"
        v-on:click="sendInfo"> 
        {{ buttonName }} 
        </button>
</template>

<script>

export default {
    
    props:['buttonName','sendInfo'],

    created(){
        console.log("value du nom du boutton : " + this.buttonName);
    }
}


</script>

<style>

.button{
    background-color: #00bae1;
    color : white;

}

</style>