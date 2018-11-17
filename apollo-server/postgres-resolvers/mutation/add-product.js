const {v4} = require("uuid")

module.exports = function(root, args, context) 
{
    const {
        product
    } = args

    const result = addProduct(product)

    return result;
}

function addProduct(product)
{
    const eventId = v4()
    const nextEventId = v4()
    const aggregateId = v4()

    const payload = JSON.stringify({
        "eventType": "CREATE_PRODUCT",
        eventId,
        nextEventId,
        aggregateId,
        "version": 1,
        "creationDateTime": "2018-10-10T01:00:39.0101Z",
        "data": {
            "id": aggregateId,
            "productName": product.name,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "retailPrice": product.retailPrice
        }
    });

    const result = save(payload)

    if(result.isOk)
    {
        dispatch(payload)
        return result
    }
    else
    {
        return result
    }
}

function dispatch(event)
{

}


function save (event)
{
    return new Promise(resolve => {
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
}