# Referral API

## API Documentation

### Create new user:
```
POST /sign_up

request payload:
{
  "email": "",
  "password": ""
}

response example:
{
  "id": ""
  "email": "",
  "password": "",
  "created_at": "2021-02-09T11:10:01.575Z",
  "updated_at": "2021-02-09T11:10:01.621Z",
  "referrer_id": 1,
  "referral_points": 0,
  "credits": 0,
  "referral_code": ""
}

```

### Sign In with User credentials:
```
POST /sign_in

request payload:
{
  "email": "",
  "password": ""
}

response example:
{
  "auth_token": ""
}
```

### Get Users data with referral_link from Users page
```
GET /users

request headers:
{
  "Authorization": "auth_token" # sent from /sign_in emdpoint
}

response example:
{
    "email": "",
    "credist": 10,
    "referral_points": 2,
    "referral_link": "https://referral-api-alexp.herokuapp.com/sign_up?referred_by=zKJjLVQhZHGVCcRR6NiPjD22"
}
```

### Sign Up with referral_link
```
POST /sign_up?referred_by=zKJjLVQhZHGVCcRR6NiPjD22

request payload:
{
  "email": "",
  "password": ""
}

response example:
{
  "id": ""
  "email": "",
  "password": "",
  "created_at": "2021-02-09T11:10:01.575Z",
  "updated_at": "2021-02-09T11:10:01.621Z",
  "referrer_id": 1,
  "referral_points": 0,
  "credits": 10,
  "referral_code": ""
}

```

## Getting Started
Run the setup script to install dependencies and get the app running on your machine:

```
cd referral-api
bundle install
rails db:setup
```

## Specs & Linting
`rspec`

## License

Referral API was created and is maintained by Alex P.

