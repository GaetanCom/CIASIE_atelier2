const express = require('express');
const router = express.Router();
const bodyParser = require("body-parser");
const NodeGeocoder = require('node-geocoder');

const bdd = require("../utils/DBclients");
const { json } = require('body-parser');

router.post('/', async (req, res, next) => {

    let message = req.body.message;
    let idEvents = req.body.idEvents;
    let idMembers = req.body.idMembers;

    try {

        let checkuserEvent = await bdd.all(
            "SELECT * FROM Guests"
            + " WHERE id_event = " + idEvents 
            + " AND id_member = " + idMembers + ";"
        );

        console.log(checkuserEvent);

        if(checkuserEvent.length >= 0) {
            let date = "31/03/2021/18:00"
            let sqlAddMessage = 
            "INSERT INTO Messages (idMessages, text, date, id_member, id_event) VALUES (null, '"
            + message + "', '"
            + date + "', "
            + idMembers + ", "
            + idEvents + ");"
    
            let dataSql = await bdd.query(sqlAddMessage);
    
            console.log(dataSql);

            return res.json({
                "idMembers": idMembers,
                "idEvents": idEvents,
                "message": message
            })
        }

        return res.json({
            "message": "No user found in this event"
        })

    } catch(err) {
        console.log(err);
    }

});

router.get('/:idMessages', async (req, res, next) => {

    let idMessages = req.params.idMessages;

    try {

        let requeteOneMessage = 
            "SELECT ms.*, mb.*, ev.* FROM Messages ms"
            + " INNER JOIN Events ev ON ev.idEvents = ms.id_event"
            + " INNER JOIN Members mb ON mb.idMembers = ms.id_member"
            + " WHERE ms.idMessages = " + idMessages;

        let bddOneMessage = await bdd.one(requeteOneMessage);

        console.log(bddOneMessage);

        res.json({
            "event" : {
                "idEvents": bddOneMessage.idEvents,
                "title": bddOneMessage.title,
            },
            "member": {
                "idMembers": bddOneMessage.idMembers,
                "pseudo": bddOneMessage.pseudo,
                "firstname": bddOneMessage.firstname,
                "lastname": bddOneMessage.lastname
            },
            "message": {
                "idMessages": bddOneMessage.idMessages,
                "message": bddOneMessage.text,
                "date": bddOneMessage.date
            }
        })

    } catch(err) {
        console.log(err);
    }

})

router.delete('/:idMessages', async (req, res, next) => {

    const idMessages = req.params.idMessages;

    try {

        let sqlRequeteDelete =
        "DELETE FROM Messages"
        + " WHERE idMessages = " + idMessages;

        let deleteMessage = await bdd.query(sqlRequeteDelete)

        console.log(deleteMessage.affectedRows);

        if(deleteMessage.affectedRows === 0) {
            return res.json({
                "message": "No Message found"
            })
        }

        return res.json({
            "message": "Message Deleted successfully"
        })



    } catch (err) {
        console.log(err);
    }
});

router.get('/:urlEvent', async (req, res, next) => {

    let urlEvent = req.params.urlEvent;

    try {

        let requeteSqlAllMessages = 
        "SELECT ms.*, mb.idMembers, mb.firstname, mb.lastname, mb.pseudo FROM Messages ms"
        + " INNER JOIN Events ev ON ms.id_event = ev.idEvents"
        + " INNER JOIN Members mb ON mb.idMembers = ms.id_member"
        + " WHERE ev.url = '" + urlEvent + "'"
        + " ORDER BY ms.idMessages DESC"

        console.log(requeteSqlAllMessages);

        let responseMessages = await bdd.all(requeteSqlAllMessages)

        console.log(responseMessages);

    } catch(err) {
        console.log(err)
    }

});



module.exports = router;