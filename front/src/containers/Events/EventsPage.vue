<template>

    <div>
        <h1>Mes événements</h1>

        <div v-if="loading" class="events_loading">
            <div>
                <b-spinner style="width: 3rem; height: 3rem;" label="Large Spinner" variant="info" type="grow"></b-spinner>
            </div>
        </div>

        <div v-else-if="eventAll.length === 0">
            <h2>Aucun évènement trouvé</h2>
            <p>Vous pouvez toujours en créer un ci-dessous</p>
            <a :href="'/create'">Créer un Évènement</a>
        </div>

        <div v-else> 
            <a :href="'/create'">Créer un Évènement</a>

            <div >
                <h2>Événements crées</h2>
                <b-card
                    v-for="eventC in eventcreator" 
                    :key="eventC.idEvents"
                    :title="eventC.title"
                    tag="article"
                    style="max-width: 20rem;"
                    class="mb-2">
                    <b-card-text>
                        <p>Crée par {{eventC.pseudo}} </p>
                        <p>
                            <span class="accept_ok" v-if="eventC.accept === 1">Vous participez</span>
                            <span class="accept_no" v-if="eventC.accept === 2">Vous ne participez pas</span>
                            <span class="accept_wait" v-if="eventC.accept === 3">Réponse attendu</span>
                        </p>
                        <p>Le {{getDate(eventC.date)}}</p>
                        <p>À {{getHour(eventC.date)}}</p>
                    </b-card-text>

                    <b-button :href="'/events/'+eventC.url" variant="primary">En savoir plus</b-button>
                </b-card>

            </div>

            <hr>

            <div>
                <h2>Tous vos événements</h2>
                <b-card
                    v-for="event in eventAll" 
                    :key="event.idEvents"
                    :title="event.title"
                    tag="article"
                    style="max-width: 20rem;"
                    class="mb-2">
                    <b-card-text>
                        <p>Crée par {{event.pseudo}} </p>
                        <p>
                            <span class="accept_ok" v-if="event.accept === 1">Vous participez</span>
                            <span class="accept_no" v-if="event.accept === 2">Vous ne participez pas</span>
                            <span class="accept_wait" v-if="event.accept === 3">Réponse attendu</span>
                        </p>
                            
                        <p>Le {{getDate(event.date)}}</p>
                        <p>À {{getHour(event.date)}}</p>
                    </b-card-text>

                    <b-button :href="'/events/'+event.url" variant="primary">En savoir plus</b-button>
                </b-card>
            </div>

              
            

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
            eventAll: [],
            eventcreator: [],
            loading: true, 
        }
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

    created () {

        this.userId = this.$session.get('idUser');

        if(!this.userId) {
            console.log("NO USER");
        } else {

            axios.get(this.urlApi + this.userId + "/events")
                .then(res => {
                    res.data.forEach(event => {
                        if(event.id_creator === this.userId) {
                            console.log(event.title)
                            this.eventcreator.push(event);
                        } 
                        this.eventAll.push(event)
                    });
                }).finally(() => {
                    this.loading = false
                })

        }

    }
    
}
</script>

<style lang="scss">

.event {
    &_loading {
        div {
            text-align: center;
            margin: 30px 0;
        }
    }
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