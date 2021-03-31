<template>
    <div id="login">

        <section class="error" v-if="errored">
            <b-alert show variant="danger"><i>Nous sommes désolés, {{ alertError }}. Veuillez réessayer.</i></b-alert>
        </section>

        <h1>Veuillez vous connecter</h1>
        <input type="text" name="username" v-model="input.username" placeholder="Login" />
        <input type="password" name="password" v-model="input.password" placeholder="Password" />

        <b-button class="btn" variant="light" v-on:click="login()">Connexion</b-button>

    </div>

</template>

<script>
    export default {
        name: 'Login',
        data() {
            return {
                input: {
                    username: "",
                    password: ""
                },
                urlApi: "http://docketu.iutnc.univ-lorraine.fr:13003/",
                // urlApi: "http://localhost:19080/",
                loading:false,
                errored:false,
                alertError:"",
            }
        },
        methods: {
            login() {
                if(this.input.username != "" && this.input.password != "" && this.input.username.includes("Admin")) {
                    const url = this.urlApi+"/users/connection/checkRegistered?login="+this.input.username+"&pwd="+this.input.password;
                    axios
                        .get(url)
                        .then(response => {
                            if(response.data == -1){
                                console.log(response);
                                this.errored = true;
                                this.alertError="Votre Mot de Passe est incorrect"
                            }else{
                                this.$emit("authenticated", true);
                                this.$router.replace({ name: "home" });
                            }
                        })
                        .catch(error => {
                            console.log(error)
                            this.errored = true
                        })
                        .finally(() => this.loading = false)

                }else{
                    this.errored=true;
                    this.alertError = "Votre Login ou Mot de Passe est incorrect";
                    console.log("error");
                }
            }
            }
    }
</script>

<style scoped>
    #login {
        width: 500px;
        background-color: #FFFFFF;
        margin: auto;
        padding: 20px;
    }

    .btn{
        margin-top: 20px;
        color: deepskyblue;

    }



</style>