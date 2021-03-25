<template>
    <div id="alert">
        <div> {{ this.message }} </div>
        <div id="close">❌</div> 
    </div>
    
</template>

<script>

export default {

    data(){
        return
    },

    props:['message'],
}

</script>

<style>

</style>