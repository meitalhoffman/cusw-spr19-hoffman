
 
import requests
import json

r = requests.get("https://api.tel-aviv.gov.il/telofan/Stations")
with open('bikes.json', 'w') as outfile:
    json.dump(json.loads(r.text), outfile)