<template>

    <div>

        <div v-if="loading">
            <div>
                <b-spinner style="width: 3rem; height: 3rem;" label="Large Spinner" variant="info" type="grow"></b-spinner>
            </div>
        </div>

        <div v-else-if="OwnerEvent">
            <h2>Ajouter des membres </h2>

            <div>
                <b-form-input 
                    v-model="text" 
                    placeholder="Chercher un utilisateur"
                    v-on:input="searchMembers">
                </b-form-input>

                <div>
                    <table v-if="propositionmember.length >= 1">
                        <thead>
                            <tr>
                                <th>Pseudo</th>
                                <th>Prénom</th>
                                <th>Nom</th>
                                <th>Ajouter</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="member in propositionmember" :key="member.idGuests">
                                <td>{{member.pseudo}}</td>
                                <td>{{member.firstname}}</td>
                                <td>{{member.lastname}}</td>
                                <td>
                                    <b-button variant="success" v-on:click=(addMember(member.idMembers))>
                                        Ajouter
                                    </b-button>
                                    
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div>
                <table >
                    <thead>
                        <tr>
                            <th>Pseudo</th>
                            <th>Prénom</th>
                            <th>Nom</th>
                            <th>Choix</th>
                            <th>Supprimer</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr  v-for="member in userMember" :key="member.idGuests">
                            <td>{{member.pseudo}}</td>
                            <td>{{member.firstname}}</td>
                            <td>{{member.lastname}}</td>
                            <td>{{member.pseudo}}</td>
                            <td>
                                <b-button variant="danger" v-on:click=(deleteMember(member.idGuests))>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash-fill" viewBox="0 0 16 16">
                                        <path d="M2.5 1a1 1 0 0 0-1 1v1a1 1 0 0 0 1 1H3v9a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V4h.5a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H10a1 1 0 0 0-1-1H7a1 1 0 0 0-1 1H2.5zm3 4a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 .5-.5zM8 5a.5.5 0 0 1 .5.5v7a.5.5 0 0 1-1 0v-7A.5.5 0 0 1 8 5zm3 .5v7a.5.5 0 0 1-1 0v-7a.5.5 0 0 1 1 0z"/>
                                    </svg>
                                    Supprimer
                                </b-button>
                                
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

        </div>

        <div v-else>
            Vous n'êtes pas authorisé sur cette page, retournez sur la page Event
        </div>

    </div>
    

</template>

<script>
import axios from 'axios';

export default {

    data() {
        return {
            urlApi: "http://docketu.iutnc.univ-lorraine.fr:13003/events/",
            // urlApi: "http://localhost:19080/events/",
            userId: null,
            eventUrl: null,
            loading: true,
            OwnerEvent: false,
            userMember: [],
            propositionmember: [],
            textPseudoMember: '',
            text: ''
        }
    },

    methods: {
        deleteMember (memberId) {
            console.log("Suppression de l'invité avec l'id Guest : ", memberId);

            axios.delete(this.urlApi+this.eventUrl+'/member/'+memberId)
                .then(res => {
                    console.log(res)
                    document.location.reload();
                }).catch(err => {
                    console.log(err)
                })
        },

        addMember (memberId) {
            console.log("Ajout de l'invité avec l'id Guest : ", memberId);
            axios.post(this.urlApi+this.eventUrl+'/member/', {
                memberId: memberId
                
            }).then(res => {
                if(res.data.message) {
                    console.log("NOP")
                } else {
                    document.location.reload();
                }
            })
        },

        searchMembers () {
            console.log(this.text)
            if(this.text.length >= 3) {
                axios.get(this.urlApi+'members?p='+this.text)
                    .then(res => {
                        this.propositionmember = [];
                        res.data.members.forEach(el => {
                            this.propositionmember.push(el)
                        })
                    })

            }

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
                        
                    } 
                });

                if(!this.OwnerEvent) {
                    this.$router.push('/events/'+this.eventUrl);
                }

                axios.get(this.urlApi+this.eventUrl+'/members')
                    .then(res => {
                        res.data.tabMembers.forEach(member => {
                            this.userMember.push(member);
                        })
                    })


                

            }).finally(() => {
                this.loading = false;
            })
    }
    
}
</script>

<style lang="scss">


</style>