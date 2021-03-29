<template>

    <div>

        <div v-if="loading">
            <div>
                <b-spinner style="width: 3rem; height: 3rem;" label="Large Spinner" variant="info" type="grow"></b-spinner>
            </div>
        </div>

        <div v-else>
            <h2>Ajouter des membres </h2>

        </div>

    </div>
    

</template>

<script>
import axios from 'axios';

export default {

    data() {
        return {
            // urlApi: "http://docketu.iutnc.univ-lorraine.fr:13003/events/",
            urlApi: "http://localhost:19080/events/",
            userId: null,
            eventUrl: null,
            loading: true,
            OwnerEvent: false
        }
    },

    created() {
        this.eventUrl = this.$route.params.urlEvent;
        this.userId = this.$session.get("idUser");

        axios.get(this.urlApi+'/createdBy/'+this.userId)
            .then(res => {
                console.log(res.data.events);
                res.data.events.forEach(element => {
                    if(element.url === this.eventUrl) {
                        this.OwnerEvent = true;
                        return
                    }
                    console.log("NO");
                });
            })
    }
    
}
</script>

<style lang="scss">


</style>