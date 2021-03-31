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

        <div v-else class="myEventsPage"> 
            <a :href="'/create'">Créer un Évènement</a>

            <div>
                <h2>Vos événements crées</h2>

                <div class="myEventsPage_allEvents">
                    <OneEventCard 
                        v-for="eventC in eventcreator"
                        :key="eventC.idEvents"
                        :title="eventC.title"
                        :pseudo="eventC.pseudo"
                        :accept="eventC.accept"
                        :date="eventC.date"
                        :url="eventC.url"
                    />
                </div>
            </div>

            <hr>

            <div >
                <h2>Tous vos événements</h2>

                <div class="myEventsPage_allEvents">
                    <OneEventCard 
                        v-for="event in eventAll"
                        :key="event.idEvents"
                        :title="event.title"
                        :pseudo="event.pseudo"
                        :accept="event.accept"
                        :date="event.date"
                        :url="event.url"
                    />
                </div>
            </div>

        </div>
    </div>
    
</template>

<script>
import axios from 'axios';

import OneEventCard from './OneEventCard';

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

    components: {OneEventCard},

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

.myEventsPage {
    padding: 2%;
    width: 100%;
    margin: auto;
    max-width: 2000px;

    h2 {
        text-align: left;
    }
}

.myEventsPage_allEvents {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    justify-items: center;
}

.event {
    &_loading {
        div {
            margin: 30px 0;
        }
    }
}

</style>