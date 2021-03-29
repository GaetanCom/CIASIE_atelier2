<template>

    <div class="pageEvent">

        <div v-if="loading" class="pageEvent_loading">
            <div>
                <b-spinner style="width: 3rem; height: 3rem;" label="Large Spinner" variant="info" type="grow"></b-spinner>
            </div>
        </div>

        <div else class="pageEvent_informations"> 

            <div class="pageEvent_informations_title">
                <div class="pageEvent_informations_title_calendarIcon">
                    <div class="pageEvent_informations_title_calendarIcon_red"></div>
                    <div class="pageEvent_informations_title_calendarIcon_white">
                        <p id="day">{{dateEvent[0]}}</p>
                        <p id="month">{{dateEvent[1]}}</p>
                    </div>
                </div>
                <p></p>
            </div>

            <div class="pageEvent_informations_creator">
                Par {{ pseudoCreatorEvent }}
            </div>

            <div class="pageEvent_informations_titleEvent">
                <h2>{{titleEvent}}</h2>
                <p>Le {{dateEvent[0]}} {{dateEvent[4]}} {{dateEvent[2]}} à {{dateEvent[3]}}</p>
            </div>



            <div class="pageEvent_informations_description">
                <h3>Description</h3>
                <p> {{descriptionEvent}} </p>
            </div>

            <div class="pageEvent_informations_members">
                <div class="pageEvent_informations_members_headers">
                    <h3>Participants</h3>
                    <b-link :href="'/events/'+ urlEvent +'/addmembers'" class="pageEvent_informations_members_headers_link">Ajouter Des participants</b-link>
                </div>
                <div class="pageEvent_informations_members_body">
                    <div v-for="member in listMembersEvents" :key="member.idMember" class="oneMember">
                        <div class="oneMember_row">
                            <div id="pseudo">{{member.firstname}} {{member.lastname}}</div>
                            <div id="choice"> 
                                <span v-if="member.accept == 'agreed'" id="choice_agreed"> {{member.accept}}</span>
                                <span v-else-if="member.accept== 'waiting'" id="choice_waiting"> {{member.accept}}</span>
                                <span v-else id="choice_refused"> {{member.accept}}</span>
                            </div>
                        </div>
                    </div>


                </div>

            </div>



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

          let month, monthfr;

          switch(tabDate[1]) {
              case '01': month = "JAN"; monthfr = "Janvier"; break;
              case '02': month = "FEB"; monthfr = "Février"; break;
              case '03': month = "MAR"; monthfr = "Mars"; break;
              case '04': month = "APR"; monthfr = "Avril"; break;
              case '05': month = "MAY"; monthfr = "Mai"; break;
              case '06': month = "JUN"; monthfr = "Juin"; break;
              case '07': month = "JUL"; monthfr = "Juillet"; break;
              case '08': month = "AUG"; monthfr = "Août"; break;
              case '09': month = "SEP"; monthfr = "Septembre"; break;
              case '10': month = "OCT"; monthfr = "Octobre"; break;
              case '11': month = "NOV"; monthfr = "Novembre"; break;
              case '12': month = "DEC"; monthfr = "Décembre"; break;
          } 
          this.dateEvent = [tabDate[0], month, tabDate[2], tabDate[3], monthfr]
          console.log(this.dateEvent);
      }
    },

    created() {
        this.urlEvent = this.$route.params.urlEvent
        console.log("[EventPage.vue] created");
        console.log("[EventPage.vue] ", this.urlEvent);

        axios.get(this.urlApi + this.urlEvent)
            .then(res => {
                let data = res.data;
                console.log(data);
                
                this.listMembersEvents = data.members
                this.pseudoCreatorEvent = data.creator.pseudo;
                this.titleEvent = data.event.title;
                this.descriptionEvent = data.event.description;
                this.dateEventString = data.event.date;

                this.markers = latLng(data.address.latitude, data.address.longitude);

            }).finally(() => {
                this.loading = false;
                this.changeDate(this.dateEventString);
            })
    }
    
}
</script>

<style lang="scss">

.pageEvent {
    width: 100%;
    margin: auto;
    text-align: left;

    &_loading {
        margin-top: 30px;
    }

    &_informations {
        margin-top: 30px;
        display: flex;
        flex-direction: column;
        justify-content: flex-start;

        &_title {
            display: flex;
            justify-content: center;
            justify-items: center;
            text-align: center;

            &_calendarIcon {
                display: flex;
                flex-direction: column;
                width: 100px;
                height: 100px;
                min-width: 100px;
                min-height: 100px;
                border-radius: 10px ;
                box-shadow: 2px 2px 5px #000;

                &_red {
                    border-radius: 10px 10px 0 0;
                    height: 25%;
                    background-color: #fd3a62;
                }

                &_white {
                    border-radius: 0 0 10px 10px ;
                    height: 75%;
                    background-color: #fff;
                    display: flex;
                    flex-direction: column;
                    justify-content: space-around;
                    justify-items: center;

                    p {
                        margin: 0;
                        font-weight: bold;

                    }

                    #day {
                        font-size: 2em;
                    }

                    #month {
                        font-size: 1.2em;
                    }
                }
            }

        }

        &_creator {
            margin-top: 20px;
            padding: 0 2%;
            color: #65676b;
        }

        &_titleEvent {
            padding: 0 2%;
            h2 {
                font-size: 2.5em;
                margin: 0;
            }

            p {
                color: hsl(350deg 87% 55%);
                font-weight: bold;
                font-size: 1.2em;
            }
        }

        &_description {
            width: 95%;
            margin: 20px auto;
            box-shadow: 2px 2px 5px #000;
            border-radius: 10px;
            padding: 2%;
            
            h2 {
                font-weight: 600;
            }
        }

        &_members {
            width: 95%;
            margin: 20px auto;
            box-shadow: 2px 2px 5px #000;
            border-radius: 10px;
            padding: 2%;

            &_headers {
                display: flex;
                flex-direction: row;
                justify-content: space-between;
                justify-items: center;

                h3 {
                    width: 50%;
                }

                &_link {
                    width: 30%;
                    text-align: right;
                }
            }

            &_body {
                display: flex;
                flex-direction: column;
                width: 100%;
                margin-bottom: 3px;

                .oneMember {
                    padding: 0 10%;
                    margin: 5px;
                    &_row {
                        display: flex;
                        flex-direction: row;
                        justify-content: space-between;
                        font-size: 1.2em;
                        
                    }

                    #choice {
                        text-align: right;

                        &_agreed {
                            color: green
                        }

                        &_waiting {
                            color: orange
                        }

                        &_refused {
                            color: red
                        }
                    }

                }
            }
            
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

    }

}



</style>