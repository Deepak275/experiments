import requests
import json

# Fetch the JSON file
response = requests.get('https://s3.amazonaws.com/open-to-cors/assignment.json')

# Parse the JSON file
data = json.loads(response.text)

products = data['products'].values()

for product_info in products:
  product_info['popularity'] = int(product_info['popularity'])

sorted_data = sorted(products, key=lambda x: x['popularity'], reverse=True)

for product in sorted_data:
  print("Title: {}, Price: {}".format(product['title'], product['price']))
