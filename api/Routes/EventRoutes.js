const express = require('express');
const router = express.Router();
const bodyParser = require("body-parser");
const NodeGeocoder = require('node-geocoder');
const mysql = require('mysql2');

const bdd = require("../utils/DBclients");
const { json } = require('body-parser');

const options = {
    provider: 'mapquest',
    apiKey: 'SIrr3b2xAP9dzPkiOh6vFNr6PptSoCdk',
    formatter: null 
};

router.get('/', async(req, res, next) => {
    let sqlreq = 'SELECT * FROM Events';
    
    try {
        const eventsData = await bdd.query(sqlreq);
        const events = eventsData;
        
        
        let jsonData = [];
        let dataEvent;
        
        events.forEach(async element => {
            
            dataEvent = {
                "id": element.id,
                "title": element.title,
                "description": element.description,
                "date": element.date,
                "url": element.url,
                "creatorId": element.id_creator,
            }

            jsonData.push(dataEvent);
        });

        res.send(jsonData);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }

})

router.post('/', async(req, res, next) => {

    const {title, description, date, idCreator, idAddress} = req.body;
    const members = req.body.members;

    const url = 2;
    
    try {
        const events = await bdd.query(
            "INSERT INTO Events (id, title, description, date, url, id_address, id_creator) VALUES (null, '"
            + title + "', '"
            + description + "', '"
            + date + "', '"
            + url + "', "
            + idAddress + ","
            + idCreator + ");"
        );
    
        res.status(201).json({
            id: events.insertId,
            title: title,
            description: description,
            date: date,
            idCreator: idCreator,
            idAddress: idAddress
        });

    } catch(err) {
        console.log(err);
        throw new Error(err);
    };


});

router.post('/address', async(req, res, next) => {

    const {number, street, country, zipcode} = req.body;
    const geocoder = NodeGeocoder(options);
    const address = number + " " + street;


    try {
        const dataLocalization = await geocoder.geocode({
            address: address,
            country: country,
            zipcode: zipcode
        });

        const longitude = dataLocalization[0].longitude;
        const latitude = dataLocalization[0].latitude;

        let reqAddress = "INSERT INTO Address VALUES (null, " 
        + number + ", '"
        + street + "', "
        + zipcode + ", '"
        + country + "', "
        + longitude + ", "
        + latitude + ");"

        const request = await bdd.query(reqAddress);

        return res.status(201).json({
            id: request.insertId,
            number: number,
            street: street,
            zipcode: zipcode,
            country: country,
            longitude: longitude,
            latitude: latitude,
        })

    } catch(err) {
        console.log(err);
        throw new Error(err);
    }

})

module.exports = router;