const express = require('express');
const router = express.Router();
const bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

var mysql      = require('mysql2');
var connection = mysql.createConnection({
    host     : 'db',
    user     : 'user',
    password: 'user',
    database:"reunion"
});
connection.connect();

router.get("/users", (req,res)=>{
    connection.query('SELECT * FROM Members', function(err, rows, fields) {
        if (err) throw err;
        let data=[]
        for (let i = 0; i < rows.length; i++){
            data.push({
                "id": rows[i].id,
                "firstname": rows[i].firstname,
                "name": rows[i].name,
                "mail": rows[i].mail,
                "pseudo": rows[i].pseudo,
                "password":rows[i].password
            })
        }
    res.send(data)   
  //console.log('The solution is: ', rows[0].solution);
});
})

router.get('/users/:id', (req, res) => {
    connection.query('SELECT * FROM Members WHERE id=?', [req.params.id], function (err, rows, fields) {
        if (err) throw err;
        let data = []
         if (rows.length == 0) {
             data.push("Il n'y a pas d'utilisateur avec cet id")
              res.send(data)
        }
        data.push({
            "id": rows[0].id,
            "firstname": rows[0].firstname,
            "name": rows[0].name,
            "mail": rows[0].mail,
            "pseudo": rows[0].pseudo,
            "password": rows[0].password
        })
        res.send(data)
       
    })
});

router.post("/users/connection/signup", (req,res) => {
    console.log(req.body);
    let firstname = req.body.firstname
    let name = req.body.name
    let mail = req.body.mail
    let pseudo = req.body.pseudo
    let password=req.body.password
     var sql = "INSERT INTO Members (firstname, name,mail,pseudo,password) VALUES (?,?,?,?,?)";
    connection.query(sql, [firstname,name,mail,pseudo,password],function (err, result) {

        if (err) {
            throw err;
            res.json(false)
    }
        console.log("1 record inserted");
          res.json(true)
  });
  
    
})

router.get('/users/connection/checkRegistered', (req, res) => {
    let login = req.query.login
    let pwd = req.query.pwd
   connection.query('SELECT * FROM Members WHERE pseudo=? AND password=?', [login,pwd], function (err, rows, fields) {
        if (err) throw err;

       res.json(!rows.length==0)
  
    })
return 	
});



module.exports = router;