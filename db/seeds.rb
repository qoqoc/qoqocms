User.find_or_create_by_email('admin@qoqoc.ru') do  |u|
  u.password = 'adminqoqocik'
end
User.find_or_create_by_email('stans20@mail.ru') do  |u|
  u.password = 'stansadm20'
end
