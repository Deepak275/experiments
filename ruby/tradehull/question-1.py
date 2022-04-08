import csv
import requests


url = 'https://api.kite.trade/instruments'
r = requests.get(url, allow_redirects=True)
file_handle = open('instruments.csv', 'rb+')

file_handle.write(r.content)
file_handle.close()

input_handle = open('instruments.csv', 'r+')


next(input_handle)


input_reader = csv.reader(input_handle)

output_file = open('tradingsymbols.txt', 'w')
output = csv.writer(output_file, delimiter=',')

print('here')
for row in input_handle:
  if row[11] == 'NFO' and row[5] == '2022-04-13' and row[9] == 'CE':
    print(row)
    print('here')
    output.writerow(row)

