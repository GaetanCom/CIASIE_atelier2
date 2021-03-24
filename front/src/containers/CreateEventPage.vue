<template>

    <div>
        <h1>Création d'un Évènement</h1>


        <form action="">
            <Input 
                id="title"
                placeholder="Titre de l'événement"
                type="text"
                ref="titleEvent" />
            <Input 
                id="description"
                placeholder="Description de l'événement"
                type="text"
                ref="descriptionEvent" />
            <Input 
                id="hour"
                placeholder="Titre de l'événement"
                type="time"
                ref="titleEvent" />
            <Input 
                id="title"
                placeholder="Titre de l'événement"
                type="date"
                ref="dateEvent" />
            <Button
                buttonName="se connecter" 
                :sendInfo="sendEventsHandler" />
        </form>

    </div>
    
</template>

<script>
import axios from 'axios';

import Button from '../components/Button';
import Input from '../components/Input';

export default {
    components: {Button, Input},

    methods: {
        sendEventsHandler() {
            
        }
    }
    
}
</script>

<style>

</style>