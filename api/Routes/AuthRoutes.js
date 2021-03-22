const express = require('express');
const router = express.Router();

//router.use(bodyParser.urlencoded({ extended: false }));
//router.use(bodyParser.json());

var mysql      = require('mysql2');
var connection = mysql.createConnection({
    host     : 'db',
    user     : 'user',
    password: 'user',
    database:"reunion"
});
connection.connect();

router.get("/", (req,res)=>{
    connection.query('SELECT * FROM Members', function(err, rows, fields) {
        if (err) throw err;
        let data=[]
        for (let i = 0; i < rows.length; i++){
            data.push({
                "id": rows[i].id,
                "firstname": rows[i].firstname,
                "lastname": rows[i].lastname,
                "mail": rows[i].mail,
                "pseudo": rows[i].pseudo,
                "password":rows[i].password
            })
        }
    res.send(data)   
  //console.log('The solution is: ', rows[0].solution);
});
})

router.get('/:id', (req, res) => {
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
            "lastname": rows[0].lastname,
            "mail": rows[0].mail,
            "pseudo": rows[0].pseudo,
            "password": rows[0].password
        })
        res.send(data)
       
    })
});

router.post("/connection/signup", (req,res) => {
    console.log(req.body);
    let firstname = req.body.firstname
    let lastname = req.body.lastname
    let mail = req.body.mail
    let pseudo = req.body.pseudo
    let password=req.body.password
     var sql = "INSERT INTO Members (firstname,lastname,mail,pseudo,password) VALUES (?,?,?,?,?)";
    connection.query(sql, [firstname,lastname,mail,pseudo,password],function (err, result) {

        if (err) {
            throw err;
            res.json(false)
    }
        console.log("1 record inserted");
          res.json(true)
  });
  
    
})

router.get('/connection/checkRegistered', (req, res) => {
    let login = req.query.login
    let pwd = req.query.pwd
   connection.query('SELECT * FROM Members WHERE pseudo=? AND password=?', [login,pwd], function (err, rows, fields) {
        if (err) throw err;

       res.json(!rows.length==0)
  
    })
return 	
});



module.exports = router;