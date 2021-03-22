<template>
    <input 
        :id="id" 
        :placeholder="placeholder"
        :type="type" 
        v-model="donnee" />
</template>

<script>

export default {
    data(){
        return{
            value: '',
            donnee: ''
        }
    },

    props: ['id','type','placeholder'],

    methods: {
        change(){
            this.value = this.text;
        }

    },

    created(){
        console.log("value de text dans props : " + this.text);
        this.value = this.text;
        console.log("valeur de value : " + this.value);

    }
}

</script>

<style>

</style>