const express = require('express');
const router = express.Router();
const bodyParser = require("body-parser");

//router.use(bodyParser.urlencoded({ extended: false }));
//router.use(bodyParser.json());

const bdd = require("../utils/DBclients");
const { json } = require('body-parser');

router.get("/", async (req, res, next)=>{

    try {
        const allUsers = await bdd.query('SELECT * FROM Members');
        let data = [];

        console.log(allUsers);

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
        res.json(data);
    } catch(err) {
        console.error(err);
        throw new Error(err);
    }
})

router.get('/:id', (req, res) => {
    bdd.query('SELECT * FROM Members WHERE id=?', [req.params.id], function (err, rows, fields) {
        if (err) throw err;
        let data = []
         if (rows.length == 0) {
             data.push("Il n'y a pas d'utilisateur avec cet id")
              res.send(data)
        }
        data.push({
            "id": rows[0].id,
            "firstname": rows[0].firstname,
            "lastname": rows[0].lastname,
            "mail": rows[0].mail,
            "pseudo": rows[0].pseudo,
            "password": rows[0].password
        })
        res.send(data)
       
    })
});

// router.post("/connection/signup", (req,res) => {
//     console.log(req.body);
//     let firstname = req.body.firstname
//     let lastname = req.body.lastname
//     let mail = req.body.mail
//     let pseudo = req.body.pseudo
//     let password=req.body.password
//      var sql = "INSERT INTO Members (firstname,lastname,mail,pseudo,password) VALUES (?,?,?,?,?)";
//     bdd.query(sql, [firstname,lastname,mail,pseudo,password],function (err, result) {

//         if (err) {
//             throw err;
//             res.json(false)
//     }
//         console.log("1 record inserted");
//           res.json(true)
//   });
  
    
// })

// router.get('/connection/checkRegistered', (req, res) => {
//     let login = req.query.login
//     let pwd = req.query.pwd
//    bdd.query('SELECT * FROM Members WHERE pseudo=? AND password=?', [login,pwd], function (err, rows, fields) {
//         if (err) throw err;
//        if (!rows.length == 0) {
//            res.json({
//                "id": rows[0].id,
//                "firstname": rows[0].firstname,
//                "lastname": rows[0].lastname,
//                "mail": rows[0].mail,
//                "pseudo": rows[0].pseudo,
//                "password": rows[0].password
//            })
//        } else {
//            res.json(-1)
//         }
       
  
//     })
// return 	
// });

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