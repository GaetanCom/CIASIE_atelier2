<template>
    <div class="row">
            <div class="col-sm-4 mx-auto" v-if="modifPrenom == false">votre prenom est : {{ this.$session.get('prenom') }} 
                <Button buttonName="⚙️" :sendInfo="modifierPrenom">
                </Button>
            </div>
            <div v-else class="col-sm-4 mx-auto">
                <Input :placeholder="this.$session.get('prenom')" id="prenom" type="text" value="" ref="prenom"></Input>
                <Button buttonName="modifier" :sendInfo="envoiePrenom">
                </Button>
            </div>
    </div>
</template>