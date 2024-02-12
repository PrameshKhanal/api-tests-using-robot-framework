import  requests

url_endpoint = "https://thinking-tester-contact-list.herokuapp.com/contacts/"


token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWNhMzMwZGUxNTlkZTAwMTNmYTk4M2YiLCJpYXQiOjE3MDc3NjYxMjd9.4Ghromoy7yxm3fkbOwU2uqr1EcX7bcijKJGeqiNpC8Y"

payload={
    "firstName": "Amy",
    "lastName": "Miller",
    "birthdate": "1992-02-02",
    "email": "amiller@fake.com",
    "phone": "8005554242",
    "street1": "13 School St.",
    "street2": "Apt. 5",
    "city": "Washington",
    "stateProvince": "QC",
    "postalCode": "A1A1A1",
    "country": "Canada"
}

headers = {
  'Authorization': token
}

response = requests.request("PUT", url_endpoint, headers=headers, data=payload)

print(response.text)