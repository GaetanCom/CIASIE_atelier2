const express = require('express');
const router = express.Router();
const bodyParser = require("body-parser");
const passwordHash = require('password-hash');


const bdd = require("../utils/DBclients");
const { json } = require('body-parser');

router.get("/", async (req, res, next) => {

    try {
        const allUsers = await bdd.query('SELECT * FROM Members');
        let data = [];

        allUsers.forEach(element => {
            data.push({
                "idMembers": element.id,
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
    }
});

router.get('/:id', async (req, res, next) => {

    const idUser = req.params.id;
    let data = [];

    try {
        let oneUser = await bdd.query('SELECT * FROM Members WHERE idMembers=' + idUser);


        if (oneUser.length === 0) {
            data.push({
                "message": "No User found"
            })
            return res.send(data);
        }
        
        oneUser = oneUser[0];

        data.push({

            "idMembers": oneUser.id,
            "firstname": oneUser.firstname,
            "lastname": oneUser.lastname,
            "mail": oneUser.mail,
            "pseudo": oneUser.pseudo,
            "password": oneUser.password
        })
        return res.send(data);
        
    } catch(err) {
        console.log(err);
    }
});

router.post("/connection/signup", async (req, res, next) => {
    console.log(req.body);
    let firstname = req.body.firstname;
    let lastname  = req.body.lastname;
    let mail      = req.body.mail;
    let pseudo    = req.body.pseudo;
    let password = passwordHash.generate(req.body.password);
    var sql = "INSERT INTO Members (firstname, lastname, mail, pseudo, password,id_status) VALUES ('"
        + firstname + "', '"
        + lastname + "', '"
        + mail + "', '"
        + pseudo + "', '"
        + password + "', 2);";

    

    try {
        let createUser = await bdd.query(sql);

        const response = {
            "idMembers": createUser.insertId,
            "firstname": firstname,
            "lastname": lastname,
            "mail": mail,
            "pseudo": pseudo,
        }
        return res.status(201).json(response);
    } catch(err) {
        console.log(err);
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
            try {
                if (passwordHash.verify(pwd, password)) {
                    user = user[0];
                    responseJson = {
                        "idMembers": user.idMembers,
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
            } catch (err) {
                console.log(err);
            }
        } else {
            responseJson = {
                "message": "No user found"
            }
        }

        return res.json(responseJson)
    } catch (err) {
        console.log(err);
    }

});

router.post("/update/firstname", async (req, res, next) => {
    let newFirstName = req.body.firstname;
    let id = req.body.id;

<<<<<<< HEAD
    let requeteSQL = "UPDATE Members SET firstname='"+  newFirstName +"' WHERE idMembers=" + id;
=======
    let requeteSQL = "UPDATE Members SET firstname='"+  newFirstName +"' WHERE id=" + id;
>>>>>>> Arthur

    try {
        let newUser = await bdd.query(requeteSQL);

        return res.json({
<<<<<<< HEAD
            "idmembers": id,
=======
            "id": id,
>>>>>>> Arthur
            "firstname": newFirstName
        })
    } catch(err) {
        console.log(err);
        
        return res.json({
            "message": "ERROR"
        })
    }
})

router.post("/update/lastname", async (req, res, next)=> {
    let newLastName = req.body.lastname;
    let id = req.body.id;

<<<<<<< HEAD
    let requeteSQL = "UPDATE Members SET lastname='"+  newLastName +"' WHERE idMembers=" + id;
=======
    let requeteSQL = "UPDATE Members SET lastname='"+  newLastName +"' WHERE id=" + id;
>>>>>>> Arthur

    try {
        let newUser = await bdd.query(requeteSQL);

        return res.json({
<<<<<<< HEAD
            "idMembers": id,
=======
            "id": id,
>>>>>>> Arthur
            "lastname": newLastName
        })
    } catch(err) {
        console.log(err);
        
        return res.json({
            "message": "ERROR"
        })
    }
})

router.post("/update/mail", async (req, res, next)=> {
    let newMail = req.body.mail;
    let id = req.body.id;

<<<<<<< HEAD
    let requeteSQL = "UPDATE Members SET mail='"+  newMail +"' WHERE idMembers=" + id;
=======
    let requeteSQL = "UPDATE Members SET mail='"+  newMail +"' WHERE id=" + id;
>>>>>>> Arthur

    try {
        let newUser = await bdd.query(requeteSQL);

        return res.json({
<<<<<<< HEAD
            "idMembers": id,
=======
            "id": id,
>>>>>>> Arthur
            "mail": newMail
        })
    } catch(err) {
        console.log(err);
        
        return res.json({
            "message": "ERROR"
        })
    }
})

router.post("/update/pseudo", async (req, res, next)=> {
    let newPseudo = req.body.pseudo;
    let id = req.body.id;

<<<<<<< HEAD
    let requeteSQL = "UPDATE Members SET pseudo='"+  newPseudo +"' WHERE idMembers=" + id;
=======
    let requeteSQL = "UPDATE Members SET pseudo='"+  newPseudo +"' WHERE id=" + id;
>>>>>>> Arthur
    console.log(requeteSQL);

    try {
        let newUser = await bdd.query(requeteSQL);

        return res.json({
<<<<<<< HEAD
            "idMembers": id,
=======
            "id": id,
>>>>>>> Arthur
            "pseudo": newPseudo
        })
    } catch(err) {
        console.log(err);
        
        return res.json({
            "message": "ERROR"
        })
    }
})

router.post("/update/password", async (req, res, next)=> {
    let newpassword = req.body.newpassword;
    let oldpassword = req.body.oldpassword;
    let id = req.body.id;

    try {
<<<<<<< HEAD
        let sqlfindUser = "SELECT * FROM Members WHERE idMembers="+id
        let findUser = await bdd.all(sqlfindUser);

        try {
            if (passwordHash.verify(oldpassword, findUser[0].password)) {
                let requeteSQL = "UPDATE Members SET password='" + passwordHash.generate(newpassword) + "' WHERE idMembers=" + id + ";";
                let newUser = await bdd.query(requeteSQL);
            

                return res.status(201).json({
                    "idMembers": id
                })
            
            } else {
                return res.json({
                    "message": "WRONG OLD PASSWORD"
                })
            }
        } catch (err) {
            console.log("err");
=======
        let sqlfindUser = "SELECT * FROM Members WHERE id="+id
        let findUser = await bdd.all(sqlfindUser);


        if(passwordHash.verify(oldpassword, findUser[0].password)) {
            let requeteSQL = "UPDATE Members SET password='"+  passwordHash.generate(newpassword) +"' WHERE id=" + id + ";";
            let newUser = await bdd.query(requeteSQL);
            

            return res.status(201).json({
                "id": id
            })
            
        } else {
            return res.json({
                "message": "WRONG OLD PASSWORD"
            })
>>>>>>> Arthur
        }


    } catch(err) {
        console.log(err);
        
        return res.json({
            "message": "ERROR"
        })
    }
<<<<<<< HEAD
})

router.post("/delete/member", async (req, res, next)=> {
    let id = req.body.id;

    let requeteSQL = "DELETE FROM Members WHERE idMembers=" + id;

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
=======

>>>>>>> Arthur
})

module.exports = router;