const express = require('express');
const router = express.Router();
const bodyParser = require("body-parser");
const NodeGeocoder = require('node-geocoder');

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
                "id": element.idEvents,
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
    
    try {
        // Vérification que l'URL qui sera attribuée n'existe pas 
        let existingUrl;
        do {
            const url = CreateURL();
            existingUrl = await bdd.all("SELECT * FROM Events WHERE url="+url);
        } while(existingUrl.length !== 0);

        const events = await bdd.query(
            "INSERT INTO Events (idEvents, title, description, date, url, id_address, id_creator) VALUES (null, '"
            + title + "', '"
            + description + "', '"
            + date + "', '"
            + url + "', "
            + idAddress + ","
            + idCreator + ");"
        );
    
        res.status(201).json({
            idEvents: events.insertId,
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

router.get('/:urlevent', async (req, res, next) => {

    let urlEvent = req.params.urlevent;

    try {
        let requeteSQLOneEvent = 
        "SELECT e.* , a.*, c.* "
        + "FROM Events e "
        + "JOIN Address a ON a.idAddress = e.id_address " 
        + "JOIN Members c ON c.idMembers = e.id_creator "
        + "WHERE e.url = '" + urlEvent + "'";

        console.log(requeteSQLOneEvent);

        let oneEvent = await bdd.all(requeteSQLOneEvent);

        let jsonRes = {
            "message": "No Event Found"
        }
        
        if(oneEvent.length === 1) {
            
            let idEvent = oneEvent[0].idEvents;
            
            let requeteSQLListMembers =
            "SELECT g.*, m.* "
            + "FROM Guests g "
            + "JOIN Members m ON m.idMembers = g.id_member "
            + "WHERE g.id_event = " + idEvent;

            let listMembers = await bdd.all(requeteSQLListMembers);

            if (listMembers.length >= 1) {

                let members = [];

                listMembers.forEach(el => {
                    let accept = el.accept === 1 ? "agreed" : el.accept === 2 ? "refused" : "waiting";

                    members.push({
                        "idMember": el.idMembers,
                        "firstname": el.firstname,
                        "lastname": el.lastname,
                        "accept": accept
                    })
                })

                jsonRes = {
                    "event" : {
                        "idEvent": oneEvent[0].idEvents,
                        "title": oneEvent[0].title,
                        "description": oneEvent[0].description,
                        "date": oneEvent[0].date,
                        "url": oneEvent[0].url
                    },
                    "creator": {
                        "idCreator": oneEvent[0].idMembers,
                        "firstname": oneEvent[0].firstname,
                        "lastname": oneEvent[0].lastname,
                        "pseudo": oneEvent[0].pseudo
                    },
                    "address" : {
                        "idAddress": oneEvent[0].idAddress,
                        "number": oneEvent[0].number,
                        "street": oneEvent[0].street,
                        "country": oneEvent[0].country,
                        "longitude": oneEvent[0].longitude,
                        "latitude": oneEvent[0].latitude,
                    },
                    "members": members,
                }
            }

        } 

        return res.status(201).json(jsonRes);

    } catch(error) {
        console.error(error);
        throw new Error(error);
    }

});
router.post('/:url/member', async (req, res, next) => {

    const urlEvent = req.params.url;
    const memberId = req.body.memberId;

    try {
        let events = await bdd.one("SELECT idEvents from Events WHERE url = '" + urlEvent + "';")

        let request = 
        "INSERT INTO Guests (idGuests, accept, id_event, id_member) VALUES (null, 3, "
        + events[0].idAddress + ", " 
        + memberId + ");"

        const addMember = await bdd.query(request);

        res.json({
            idMembers: addMember.insertId,
            accept: 3,
            event: eventId,
            member: memberId
        })


    } catch(err) {
        console.log(err);
        throw new Error(err);
    }
});

router.post('/:url/member/:id', async (req, res, next) => {

    let urlEvent = req.params.url;
    let idMember = req.params.id;
    let choice = req.body.choice;

    try {
        let event = await bdd.all("SELECT idEvents from Events WHERE url = '" + urlEvent + "';");


        let requestSql = 
            "UPDATE Guests"
            + " SET accept = " + choice 
            + " WHERE id_event = '" + event[0].idEvents 
            + "' AND id_member = " + idMember;

        console.log(requestSql);

        await bdd.query(requestSql);

        return res.json({
            "message": "Data Update"
        })
        

    } catch(err) {
        console.log(err);
        throw new Error(err);
    }

})


router.get('/:url/members', async (req, res, next) => {

    let eventUrl = req.params.url;

    try {
        let requestListMembers = await bdd.all(
            "SELECT g.*, m.*, e.* FROM Guests g "
            + "JOIN Events e ON e.idEvents = g.id_event "
            + "JOIN Members m ON m.idMembers = g.id_member "
            + "WHERE e.url = '" + eventUrl + "'"
        );

        console.log(requestListMembers);

        let jsonRes = {
            "message": "No Event Found"
        };

        if(requestListMembers.length >= 1) {
            let tabMembers = [];

            requestListMembers.forEach(el => {
                let accept = el.accept === 1 ? "agreed" : el.accept === 2 ? "refused" : "waiting";
                tabMembers.push({
                    "idGuests": el.idGuests,
                    "firstname": el.firstname,
                    "lastname": el.lastname,
                    "accept": accept
                })
            })

            jsonRes = {
                tabMembers
            }
        } else {

        }

        return res.status(201).json(jsonRes);

    } catch(err) {
        console.log(err);
        throw new Error(err);
    }

})

router.get("/createdBy/:id", async (req, res, next) => {
    let userId = req.params.id
    try {
        let sql = "SELECT * FROM Events WHERE id_creator=" + userId
        let listeEvents = await bdd.query(sql)
        console.log(listeEvents);
        let events=[]
        listeEvents.forEach(el => {
            events.push({
                "id": el.id,
                "title": el.title,
                "description": el.description,
                "date": el.date,
                "url": el.url,
                "id_adress": el.id_adress
            })
        })
        res.json({ "events": events })
    } catch (err) {
        console.log(err);
    }
})

router.get('/members', async (req, res, next) => {

    let pseudo = req.query.p;


    try {
        let request = "SELECT id, pseudo FROM Members WHERE pseudo LIKE '%" + pseudo + "%'";

        let listMembers = await bdd.query(request);

        console.log(listMembers);
        let members = [];

        listMembers.forEach(element => {
            let oneMember = {
                idMembers: element.idMembers,
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
            idAddress: request.insertId,
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

router.post("/delete/event", async (req, res, next)=> {
    let id = req.body.id;

    let requeteSQL = "DELETE FROM Events WHERE idEvents=" + id;

    try {
        let deleteUser = await bdd.query(requeteSQL);

        return res.json({
            "message": "SUCCESS"
        })
    } catch(err) {
        console.log(err);
        
        return res.json({
            "message": "ERROR"
        })
    }
})

module.exports = router;