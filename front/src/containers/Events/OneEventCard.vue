<template>

    <b-card
        :title="title"
        tag="article"
        style="max-width: 20rem;"
        class="mb-2 test">
        <b-card-text>
            <p>Crée par {{pseudo}} </p>
            <p>
                <span class="accept_ok" v-if="accept === 1">Vous participez</span>
                <span class="accept_no" v-if="accept === 2">Vous ne participez pas</span>
                <span class="accept_wait" v-if="accept === 3">Réponse attendu</span>
            </p>
                
            <p>Le {{getDate(date)}}</p>
            <p>À {{getHour(date)}}</p>
        </b-card-text>
        <b-button :href="'/events/'+url" variant="primary">En savoir plus</b-button>
    </b-card>
    
</template>

<script>
export default {
    props:['title', 'pseudo', 'accept', 'date', 'url'],

    created(){
        console.log("Création de OneEventCard");
    },

    methods: {
        getDate(datas) {
            let dateEvent = datas.split('/');
            let date = dateEvent[0] + "/" + dateEvent[1] + "/" + dateEvent[2] 
            return date;
        },

        getHour(datas) {
            return datas.split('/')[3];
        }
    },
    
}
</script>

<style lang="scss">

.test {
    width: 400px;
    margin: 20px auto !important;
    border: solid 2px ;
    box-shadow: 2px 2px 2px #000;
    border-radius: 10px;
}

h4 {
    color: #00bbdd;
    font-weight: bold;
    font-size: 2.2em;
}


.accept {
    &_ok {
        color: green;
        font-weight: bold;
    }

    &_no {
        color: red;
        font-weight: bold;
    }

    &_wait {
        color: orange;
        font-weight: bold;
    }
}

</style>