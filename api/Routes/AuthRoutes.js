const express = require('express');
const router = express.Router();
const bodyParser = require("body-parser");
const passwordHash = require('password-hash');
const bcrypt = require('bcrypt');


const bdd = require("../utils/DBclients");
const { json } = require('body-parser');

router.get("/", async (req, res, next) => {

    try {
        const allUsers = await bdd.query('SELECT * FROM Members');
        let data = [];

        allUsers.forEach(element => {
            data.push({
                "id": element.id,
                "firstname": element.firstname,
                "lastname": element.lastname,
                "mail": element.mail,
                "pseudo": element.pseudo,
                "password":element.password
            })
        });
        return res.json(data);
    } catch(err) {
        console.error(err);
        throw new Error(err);
    }
});

router.get('/:id', async (req, res, next) => {

    const idUser = req.params.id;
    let data = [];

    try {
        let oneUser = await bdd.query('SELECT * FROM Members WHERE id=' + idUser);


        if (oneUser.length === 0) {
            data.push({
                "message": "No User found"
            })
            return res.send(data);
        }
        
        oneUser = oneUser[0];

        data.push({
            "id": oneUser.id,
            "firstname": oneUser.firstname,
            "lastname": oneUser.lastname,
            "mail": oneUser.mail,
            "pseudo": oneUser.pseudo,
            "password": oneUser.password
        })
        return res.send(data);
        
    } catch(err) {
        console.log(err);
        throw new Error(err);
    }
});

router.post("/connection/signup", async (req, res, next) => {
    console.log(req.body);
    let firstname = req.body.firstname;
    let lastname  = req.body.lastname;
    let mail      = req.body.mail;
    let pseudo    = req.body.pseudo;
    let password  = passwordHash.generate(req.body.password);
    var sql = "INSERT INTO Members (id, firstname, lastname, mail, pseudo, password) VALUES (null, '"
        + firstname + "', '"
        + lastname + "', '"
        + mail + "', '"
        + pseudo + "', '"
        + password + "');";

    try {
        let createUser = await bdd.query(sql);

        const response = {
            "id": createUser.insertId,
            "firstname": firstname,
            "lastname": lastname,
            "mail": mail,
            "pseudo": pseudo,
        }
        return res.status(201).json(response);
    } catch(err) {
        console.log(err);
        throw new Error(err);
    }
    
})

router.get('/connection/checkRegistered', async (req, res, next) => {
    let login = req.query.login;
    let pwd = req.query.pwd;

    let sqlReq = "SELECT * FROM Members WHERE pseudo='" + login + "'";
    let responseJson
    try {
        let user = await bdd.all(sqlReq);
        if(user.length !== 0) {
            const password = user[0].password;

            if(passwordHash.verify(pwd, password)) {
                user = user[0];
                responseJson = {
                    "id": user.id,
                    "firstname": user.firstname,
                    "lastname": user.lastname,
                    "mail": user.mail,
                    "pseudo": user.pseudo
                }
            } else {    
                responseJson = {
                    "message": "Wrong password"
                }
            }
        } else {
            responseJson = {
                "message": "No user found"
            }
        }

        return res.json(responseJson)
    } catch (err) {
        console.log(err);
        throw new Error(err);
    }

});

// router.post("/update/firstname", (req, res)=> {
//     let newFirstName = req.body.firstname
//     let id = req.body.id
//     bdd.query("UPDATE Members SET firstname=? WHERE id=?", [newFirstName, id], function (err, row, fields) {
//         if (err) {
//               throw err;
//               res.json(false)
//           } 

//        res.json(true)
//     })
// })

// router.post("/update/lastname", (req, res)=> {
//     let newLastname = req.body.lastname
//     let id = req.body.id
//     bdd.query("UPDATE Members SET lastname=? WHERE id=?", [newLastname, id], function (err, row, fields) {
//         if (err) {
//               throw err;
//               res.json(false)
//           } 

//        res.json(true)
//     })
// })

// router.post("/update/mail", (req, res)=> {
//     let newMail = req.body.mail
//     let id = req.body.id
//     bdd.query("UPDATE Members SET mail=? WHERE id=?", [newMail, id], function (err, row, fields) {
//         if (err) {
//               throw err;
//               res.json(false)
//           } 

//        res.json(true)
//     })
// })

// router.post("/update/pseudo", (req, res)=> {
//     let newPseudo = req.body.pseudo
//     let id = req.body.id
//     bdd.query("UPDATE Members SET pseudo=? WHERE id=?", [newPseudo, id], function (err, row, fields) {
//         if (err) {
//               throw err;
//               res.json(false)
//           } 

//        res.json(true)
//     })
// })

// router.post("/update/password", (req, res)=> {
//     let newPassword = req.body.password
//     let id = req.body.id
//     bdd.query("UPDATE Members SET password=? WHERE id=?", [newPassword, id], function (err, row, fields) {
//         if (err) {
//               throw err;
//               res.json(false)
//           } 

//        res.json(true)
//     })
// })

module.exports = router;