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

### Orders

#### GET /api/v1/orders/:id

##### params
* id(string): Order UUID

```bash
curl -H "Authentication: Bearer {token}"
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
  "uuid": "949085E3-6FC3-4240-BC86-2940D543DB35"
}
```
