<template>
    <input 
        :id="id" 
        :placeholder="placeholder"
        :type="type" 
        :value="value"
        @keyup.enter="sendInfo"
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

    props: ['id','type','placeholder','sendInfo'],

    // methods: {
    //     change(){
    //         this.value = this.text;
    //     },
    //     emitValue(){
    //         this.$emit('getValue',)
    //     }

    // },

    created(){
        

    }
}

</script>

<style>

</style>