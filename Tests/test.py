import requests

url = "https://thinking-tester-contact-list.herokuapp.com/users/me"

token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NWNhMzMwZGUxNTlkZTAwMTNmYTk4M2YiLCJpYXQiOjE3MDc4MzI5MDd9.gPPqRGCXu68BBITgZdqyB_amSQ2zqh-eI_qMtqKmnYQ"

payload={}
headers = {
  'Authorization': token
}

response = requests.request("GET", url, headers=headers, data=payload)

print(response.text)