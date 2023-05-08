require 'csv'

file_name = 'data.csv'
headers = ['index', 'first_name', 'last_name', 'job', 'age']
data = [
  [1, 'Alice', 'Smith', 'Engineer', 34],
  [2, 'Bob', 'Johnson', 'Architect', 42],
  [3, 'Carol', 'Williams', 'Software Developer', 29],
  [4, 'Dave', 'Brown', 'Project Manager', 37],
  [5, 'Eve', 'Jones', 'Product Manager', 31],
  [6, 'Frank', 'Garcia', 'Data Scientist', 28],
  [7, 'Grace', 'Miller', 'UX Designer', 26],
  [8, 'Heidi', 'Davis', 'CTO', 45],
  [9, 'Ivan', 'Rodriguez', 'Graphic Designer', 30],
  [10, 'Jasmine', 'Martinez', 'Database Administrator', 33],
  [11, 'Karl', 'Hernandez', 'Network Engineer', 40],
  [12, 'Linda', 'Young', 'DevOps Engineer', 35],
  [13, 'Mike', 'King', 'Sales Manager', 38],
  [14, 'Nancy', 'Wright', 'Digital Marketer', 27],
  [15, 'Oscar', 'Lopez', 'QA Engineer', 32]
]

CSV.open(file_name, 'wb') do |csv|
  csv << headers
  data.each { |row| csv << row }
end