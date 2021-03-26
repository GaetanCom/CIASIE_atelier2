<template>

    <div class="pageEvent">

        <div v-if="loading" class="pageEventLoading">
            ... LOADING
        </div>

        <div else class="pageEventInformations"> 

            <div class="pageEvent-title">

                <div class="pageEventInformations_calendarIcon">
                    <div class="pageEventInformations_calendarIcon_red"></div>
                    <div class="pageEventInformations_calendarIcon_white">
                        <p>{{dateEvent[0]}}</p>
                        <p>{{dateEvent[1]}}</p>
                    </div>
                </div>

                <h1>{{titleEvent}}</h1>
            </div>

            <div>
                Évènement crée par <strong>{{ pseudoCreatorEvent }}</strong> 
            </div>

            <div>
                <p> {{descriptionEvent}} </p>
            </div>


            <ul v-for="member in listMembersEvents" :key="member.idMember">
                <li> {{member.firstname}} - {{member.accept}} </li>
            </ul>

            <div  class="mapbox">

                    <l-map
                        :center="markers"
                        :zoom="zoom"
                        class="map"
                        ref="map"
                        @update:zoom="zoomUpdated"
                        @update:center="centerUpdated">

                        <l-tile-layer :url="osmUrl"></l-tile-layer>

                        <l-marker :lat-lng="markers" ></l-marker>

                    </l-map>

            </div>

        </div>

    </div>

</template>

<script>
import axios from 'axios';
import { latLng } from "leaflet";
import { LMap, LTileLayer, LMarker, } from 'vue2-leaflet';
import 'leaflet/dist/leaflet.css';

export default {
    components: {
        LMap,
        LTileLayer,
        LMarker,
    },

    data() {
        return {
            // urlApi: "http://docketu.iutnc.univ-lorraine.fr:13003/events/",
            urlApi: "http://localhost:19080/events/",
            urlEvent: null,
            loading: true,
            pseudoCreatorEvent: '',
            titleEvent: '',
            descriptionEvent: '',
            dateEventString: '',
            dateEvent: null,
            listMembersEvents: null,

            osmUrl: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            zoom: 13,
            markers: latLng(0,0),
        }
    },

    methods: {
      zoomUpdated (zoom) {
        this.zoom = zoom;
      },
      centerUpdated (center) {
        this.center = center;
      },

      changeDate(date) {
          let tabDate = date.split("/");
          console.log(tabDate);

          let month;
          switch(tabDate[1]) {
              case '01': month = "JAN"; break;
              case '02': month = "FEB"; break;
              case '03': month = "MAR"; break;
              case '04': month = "APR"; break;
              case '05': month = "MAY"; break;
          } 
          this.dateEvent = [tabDate[0], month]
          console.log(this.dateEvent);
      }
    },

    created() {
        this.urlEvent = this.$route.params.urlEvent
        console.log("[EventPage.vue] created");

        axios.get(this.urlApi + this.urlEvent)
            .then(res => {
                let data = res.data;
                console.log(data);
                
                this.listMembersEvents = data.members
                this.pseudoCreatorEvent = data.creator.pseudo;
                this.titleEvent = data.event.title;
                this.descriptionEvent = data.event.description;
                this.dateEventString = data.event.date;

                this.markers = latLng(data.address.longitude,data.address.latitude);

            }).finally(() => {
                this.loading = false;
                this.changeDate(this.dateEventString);
            })
    }
    
}
</script>

<style>

.pageEvent-title {
    display: flex;
    justify-content: space-around;
}

.pageEventInformations_calendarIcon {
    display: flex;
    flex-direction: column;
    width: 100px;
    height: 100px;
}

.pageEventInformations_calendarIcon_red {
    border-radius: 10px 10px 0 0;
    height: 25%;
    background-color: #fd3a62;
}
.pageEventInformations_calendarIcon_white {
    border-radius: 0 0 10px 10px ;
    height: 75%;
    background-color: #fff;
    display: flex;
    flex-direction: column;
    justify-content: space-around;
    justify-items: center;
}

.pageEvent {
    width: 100%;
    margin: auto;
}

.pageEventInformations_calendarIcon_white p {
    font-size: 1.7em;
    margin: 0;
    font-weight: bold;
}


.pageEventInformations {
    margin-top: 30px;
    display: flex;
    flex-direction: column;
    justify-content: flex-start;
}

  .mapbox {
    position: relative;
    margin: auto;
    width:100%;
    height: 100vw;
  }

  .map {
    position: absolute;
  }

</style>