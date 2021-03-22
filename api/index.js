const express = require('express');
const app = express();
const NodeGeocoder = require('node-geocoder');

const options = {
    provider: 'mapquest',
    apiKey: 'SIrr3b2xAP9dzPkiOh6vFNr6PptSoCdk',
    formatter: null
}

const geocoder = NodeGeocoder(options);

app.get('/', async (req, res, next) => {
    const dataLoc = await geocoder.geocode({
        address: '9 rue de mon desert',
        country: 'France',
        zipcode: '54000'
    });

    console.log(dataLoc);

    res.send("I'm under water");
});


app.listen(3000, () => {
    console.log(`Example app listening on port 3000!`)
});