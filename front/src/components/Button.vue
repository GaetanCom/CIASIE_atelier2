<template>
    <button v-on:click="sendInfo"> {{ button-name }} </button>
</template>

<script>

export default {
    
    props:['button-name','sendInfo']
}

</script>