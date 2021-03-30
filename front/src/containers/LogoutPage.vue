<template>
    
</template>

<script>

export default {

    created(){
        this.$session.destroy();
        this.$router.push('/');
        document.location.reload();
    }
    
}

</script>

<style>

</style>