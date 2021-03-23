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

const CreateURL = () => {
    return 'xxxxxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
      return v.toString(16);
    });
}

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

    const url = CreateURL();
    
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
            url: url,
            idCreator: idCreator,
            idAddress: idAddress
        });

    } catch(err) {
        console.log(err);
        throw new Error(err);
    };


});

router.post('/member', async (req, res, next) => {

    const eventId = req.body.eventId;
    const memberId = req.body.memberId;

    try {
        let request = "INSERT INTO Guests (id, accept, id_event, id_member) VALUES (null, 3, "
        + eventId + ", " 
        + memberId + ");"

        const addMember = await bdd.query(request);

        res.json({
            id: addMember.insertId,
            accept: 3,
            event: eventId,
            member: memberId
        })


    } catch(err) {
        console.log(err);
        throw new Error(err);
    }
});

router.get('/members', async (req, res, next) => {

    let pseudo = req.query.p;


    try {
        let request = "SELECT id, pseudo FROM Members WHERE pseudo LIKE '%" + pseudo + "%'";

        let listMembers = await bdd.query(request);

        console.log(listMembers);
        let members = [];

        listMembers.forEach(element => {
            let oneMember = {
                id: element.id,
                pseudo: element.pseudo,
            }
            members.push(oneMember);
        })

        res.json({
            members: members,
        })

    } catch(err) {
        console.log(err);
        throw new Error(err);
    }
})


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