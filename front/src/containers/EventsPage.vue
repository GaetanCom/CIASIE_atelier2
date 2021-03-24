<template>

    <div>
        <h1>Events Page</h1>

        <div>
            <a :href="'/create'">Créer un Évènement</a>
        </div>
    </div>
    
</template>

<script>
export default {

    created(){
        console.log("je cree la page Events")
    }
    
}
</script>

<style>

</style>