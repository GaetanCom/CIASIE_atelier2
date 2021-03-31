<template>

    <div>
        <h1>Création d'un Évènement</h1>

        <div v-if="error">
            {{messageError}}
        </div>

        <div v-if="loading">
            CHARGEMENT ...
        </div>

        <div v-else>
            <Input 
                id="title"
                placeholder="Titre de l'événement"
                type="text"
                ref="titleEvent"
                :sendInfo="sendEventsHandler" />
            <Input 
                id="description"
                placeholder="Description de l'événement"
                type="text"
                ref="descriptionEvent"
                :sendInfo="sendEventsHandler" />
            <Input 
                id="hour"
                placeholder="Titre de l'événement"
                type="time"
                ref="HourEvent"
                :sendInfo="sendEventsHandler" />
            <Input 
                id="title"
                placeholder="Titre de l'événement"
                type="date"
                ref="dateEvent"
                :sendInfo="sendEventsHandler" />
            <br>
            <Input 
                id="addressNumber"
                placeholder="Numero"
                type="text"
                ref="numAddressEvent"
                :sendInfo="sendEventsHandler" />
            <Input 
                id="addressStreet"
                placeholder="Rue"
                type="text"
                ref="streetAddressEvent"
                :sendInfo="sendEventsHandler" />
            <Input 
                id="addressCountry"
                placeholder="Pays"
                type="text"
                ref="countryAddressEvent"
                :sendInfo="sendEventsHandler" />
            <Input 
                id="addressZipcode"
                placeholder="Code Postal"
                type="text"
                ref="zipcodeAddressEvent"
                :sendInfo="sendEventsHandler" />
            <br>
            <Button
                buttonName="Créer Événement" 
                :sendInfo="sendEventsHandler" />
        </div>

    </div>
    
</template>

<script>
import axios from 'axios';

import Button from '../components/Button';
import Input from '../components/Input';

export default {
    data(){
        return {
            urlApi: "http://docketu.iutnc.univ-lorraine.fr:13003/",
            error: false,
            messageError: "",
            loading: false,
            idAddr: null,
            url: null,
        }
    },
    components: {Button, Input},

    methods: {
        sendEventsHandler()  {
            let title = this.$refs.titleEvent.donnee;
            let description = this.$refs.descriptionEvent.donnee;
            let hour = this.$refs.HourEvent.donnee;
            let date = this.$refs.dateEvent.donnee;
            let numAddr = this.$refs.numAddressEvent.donnee;
            let streetAddr = this.$refs.streetAddressEvent.donnee;
            let countryAddr = this.$refs.countryAddressEvent.donnee;
            let zipcodeAddr = this.$refs.zipcodeAddressEvent.donnee;

            if(title === "" 
                || description === "" 
                || hour === "" 
                || date === ""
                || numAddr === ""
                || streetAddr === ""
                || countryAddr === ""
                || zipcodeAddr === "" ) {
                this.error = true;
                this.messageError = "Un champ est manquant";
            } else {
                let letterNumberR = /^[0-9a-zA-Z]$/;
                let hourR = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;
                let dateR = /^[0-9]{4}-[0-9]{2}-[0-9]{2}$/;


                if( true
                    // title.match(letterNumberR) 
                    // && description.match(letterNumberR) 
                    // && hour.match(hourR)
                    // && date.match(dateR)
                    // && numAddr.match(letterNumberR)
                    // && streetAddr.match(letterNumberR)
                    // && countryAddr.match(letterNumberR)
                    // && zipcodeAddr.match(letterNumberR) 
                ) {
                    this.loading = true
                    let tabDate = date.split("-");
                    let newDateHour = tabDate[2] + "/" + tabDate[1] + "/" + tabDate[0] + "/" + hour;
                    
                    axios.post(this.apiUrl+"/events", {
                        number: numAddr,
                        street: streetAddr,
                        country: countryAddr,
                        zipcode: zipcodeAddr,
                        title: title,
                        description: description,
                        date: newDateHour,
                        idCreator: this.$session.get('idUser'),
                        idAddress: this.idAddr
                    }).then(res => {
                        this.idAddr = res.data.address.idAddress;
                        this.url = res.data.url
                        console.log(res);
                        this.loading = false;
                        this.$router.push('/events/'+this.url);
                    }).catch(err => {
                        console.log(err)
                    }).finally(() => {
                        console.log("ADDR = " + this.idAddr)
                        this.$router.push('/events/' + this.url + '/addmembers')
                    })
                    
                } else {
                    console.log("NO");
                }
                
            } 

        }
    }
    
}
</script>

<style>

</style>