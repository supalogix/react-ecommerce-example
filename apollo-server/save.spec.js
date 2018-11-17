const { Client } = require("pg")
const client = new Client({
    user: "user",
    host: "localhost",
    database: "postgres",
    password: "mysecretpassword"
})

client.connect()

//client.query("SELECT $1::text as message", ["Hello World!"], (error, response) => {
//    console.log(error ? error.stack : response.rows[0].message)
//    client.end();
//})

const eventId = "10f40aa8-6ca1-413b-9b97-2bb1c8c2f903";
const nextEventId = "732f76e4-dc8b-4d8e-aad4-763ac4a95dd6";
const aggregateId = "87b9331e-91d5-4c5f-8b02-8ecf9b80afb4";

const payload = JSON.stringify({
    "eventType": "CREATE_PRODUCT",
    eventId,
    nextEventId,
    aggregateId,
    "version": 1,
    "creationDateTime": "2018-10-10T01:00:39.0101Z",
    "data": {
        "id": "87b9331e-91d5-4c5f-8b02-8ecf9b80afb4",
        "productName": "Product A",
        "description": "This is a description",
        "imageUrl": "https://via.placeholder.com/350x150",
        "retailPrice": "9.99"
    }
});



const save = event => new Promise(resolve => {
    const sql = `
        insert into topic.appEvents
        (
            eventId,
            nextEventId,
            aggregateId,
            creationDateTime,
            payload
        )
        values
        (
            '${event.eventId}',
            '${event.nextEventId}',
            '${event.aggregateId}',
            1,
            '${event}'
        );
    `;

    client.query(sql, [], (error, response) => {
        console.log(error ? error.stack : response)
        client.end();
    })
})

save(payload)