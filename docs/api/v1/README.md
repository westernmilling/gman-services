## API Documentation

### Authentication

### Required Headers
* Content-Type: application/json

gman-services is secured by the doorkeeper gem so before you make any requests
to the API you will need to obtain an access token.

#### POST /oauth/token

##### params
* grant_type(string):    This should be set to 'client_credentials'
* client_id(string):     This should be your applications client id
* client_secret(string): This should be your applications client secret

```bash
curl -X POST
     -H "Content-Type: application/json"
     -i {host}/oauth/token
     -d '{
       "grant_type": "client_credentials",
       "client_id": "{client_id}",
       "client_secret": "{client_secret}",
     }'
```

Returns a response containing the access token to use in further requests.

```
{
  "access_token": "...",
  "token_type": "bearer",
  "created_at": "..."
}
```

### Required Headers
* Content-Type: application/json
* Authorization: Bearer {access_token}

### Customer Contracts

#### GET /api/v1/customer_contracts?q[customer_id]={customer_ids}

Fetch the customer contract mapping records for the matching customer ids.

##### params
* q\[customer_id\](string): A comma separated list of Grossman customer ids.

```bash
curl -H "Authorization: Bearer {token}"
     -i {host}/api/v1/customer_contracts?q[customer_id]=100000,100001
```

Returns an array of customer contract items.

```
[
  {
    "contract_id": "10000000",
    "contract_type": "Sale",
    "customer_id": "100000",
    "location_id": "01"
  },
  {
    "contract_id": "10000100",
    "contract_type": "Sale",
    "customer_id": "100001",
    "location_id": "01"
  }
]
```

### Orders

#### GET /api/v1/orders/:id

Fetch a single order by the order UUID.

##### params
* id(string): Order UUID

```bash
curl -H "Authorization: Bearer {token}"
     -i {host}/api/v1/orders/949085E3-6FC3-4240-BC86-2940D543DB35
```

Returns a single order

```
{
  "order_number": 000000,
  "order_key": "000",
  "quantity_shipped": "0.0",
  "ship_date": "2000-01-01",
  "warehouse_id": 0,
  "uuid": "949085E3-6FC3-4240-BC86-2940D543DB35",
  "lines": [
    "item_number": "001",
    "item_price": "100.00",
    "contract": {
      "contract_id": "1000000",
      "contract_date": "2016-12-14",
      "contract_price": "100.00",
      "contract_number": "10000",
      "contract_sub": "00",
      "contract_type": "Sale",
      "location_id": "01"
    }
  ]
}
```

#### GET /api/v1/orders?order_number_eq={order_number}&warehouse_id_eq={warehouse_id}

Fetch orders by filter.

##### params
* order_number(string): The order number to match
* warehouse_id(string): The warehouse id to match

```bash
curl -H "Authorization: Bearer {token}"
     -i {host}/api/v1/orders?order_number_eq={order_number}&warehouse_id_eq={warehouse_id}
```

Returns an array of orders

```
[
  {
    "order_number": 123456,
    "order_key": "000",
    "quantity_shipped": "0.0",
    "ship_date": "2000-01-01",
    "warehouse_id": 1,
    "uuid": "949085E3-6FC3-4240-BC86-2940D543DB35"
  }
]
```

### Pick Up Orders

#### GET /api/v1/pick_up_orders?contract_commodity_id_eq={commodity_id}

Fetch pick up orders by filter.

##### params
* contract_commodity_id_eq(number)
* contract_contract_id_eq(string)
* purchase_customer_id_eq(string)
* release_prefix_eq(string)
* release_load_number_eq
* release_number_eq(string): A composite of the release prefix and release load
  number. The release prefix should be padded to 10 characters and the release
  load number should be padded to 4 zeros. For example:
    `TEST______0001`

```bash
curl -H "Authorization: Bearer {token}"
     -i {host}/api/v1/pick_up_orders?contract_commodity_id_eq={commodity_id}
```

Returns an array of pick up orders

```
[
  {
    "contract_id": "10000100",
    "contract_location_id": 1,
    "load_number": 1,
    "origin": "GOSHEN",
    "origin_state": "CA",
    "origin_weight_certificate": "ABC0001",
    "origin_tare_weight": 25000,
    "origin_gross_weight": 75000,
    "origin_net_weight": 50000,
    "pickup_type": "Contract",
    "purchase_customer_id": "00001000"
    "release_prefix": "TEST",
    "release_load_number": 1,
    "release_number": "TEST      0001",
    "ship_date": "2016-27-01",
    "status": "Open",
    "contract": {
      "contract_id": "10000100",
      "commodity_id": 1010
    }
  }
]
```
