<template>

    <!-- <div class="navigation">
        <nav class="navigation_header">
            <a :href="'/'">
                
            </a>
            <MenuItems />
        </nav>

    </div> -->

    <div class="navigation">
        <b-navbar toggleable="lg" type="dark" class="navbar_style">
            <b-navbar-brand href="/">
                    <img 
                        src="../../assets/logo_reunionou_white.png" 
                        alt="Logo Reunionou" 
                        class="navigation_header_logo" />
            </b-navbar-brand>

            <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

            <b-collapse id="nav-collapse" is-nav>


            <!-- Right aligned nav items -->
            <b-navbar-nav class="ml-auto hamburger">
                <b-navbar-nav>
                    <!-- <b-nav-item :href="'/events'">Mes événements</b-nav-item> -->
                    <b-nav-item v-if="connected" :href="'/events'" >Mes évènements</b-nav-item>
                    <b-nav-item v-if="!connected" :href="'/'" >Se connecter</b-nav-item>
                    <b-nav-item v-if="!connected" :href="'/register'" >S'inscrire</b-nav-item>
                </b-navbar-nav>


                <b-nav-item-dropdown right v-if="connected">
                    
                <!-- Using 'button-content' slot -->
                <template #button-content>
                    <em>{{username}}</em>
                </template>
                <div class="userItem">
                    <b-dropdown-item :href="'/user/'+this.$session.get('username')">Profil</b-dropdown-item>
                    <b-dropdown-item :href="'/logout'">Se déconnecter</b-dropdown-item>

                </div>
                </b-nav-item-dropdown>
            </b-navbar-nav>
            </b-collapse>
        </b-navbar>
    </div>
    
</template>

<script>

export default {

    data() {
        return{
            connected: false,
            username: null,
        }
        
    },

    created() {
        console.log(this.$session.get('username'));

        if(this.$session.exists()) {
            this.connected = true;
            this.username = this.$session.get('username');

        }  
    }
}
</script>

<style lang="scss">

.navigation {
    margin-bottom: 10px;
}

.userItem {
    display: flex;
    justify-content: space-around;
}

.navigation_header_logo {
    width: 200px;
}

.navbar_style {
    background-color: #00bae1;
    font-weight: bold;
}

@media (min-width: 992px) {

    .userItem {
        flex-direction: column;
    }

    .navigation_header_logo {
        width: 300px;
    }
    
}



</style>