const express = require('express')
const bodyParser = require("body-parser");
const app = express()
const port=3000

const auth_routes = require("./Routes/AuthRoutes");
const event_routes = require('./Routes/EventRoutes');

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.use('/users', auth_routes);
app.use('/events', event_routes);

app.listen(port, () => {
    console.log(`api listening at http://localhost:${port}`)
    
})