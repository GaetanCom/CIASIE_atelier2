<template>

    <nav class="navigation">
        <a :href="'/'">
            <img 
                src="../../assets/logo_reunionou.png" 
                alt="Logo Reunionou" 
                class="navigation_logo" />
        </a>
        <li>
            <ul> <a :href="'/events'">Événements</a> </ul>
            <ul> <a :href="'/register'">inscrptions</a> </ul>
        </li>
    </nav>
    
</template>

<script>
export default {
}
</script>

<style>

.navigation {
    display: flex;
    justify-content: space-between;
    align-items: center;
    background-color: #efefef;
}

.navigation_logo {
    width: 300px;
    height: 50px;
}

</style>