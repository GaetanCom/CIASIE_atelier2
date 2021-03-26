<template>
    <button 
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

</style>