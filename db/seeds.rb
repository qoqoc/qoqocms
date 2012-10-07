User.find_or_create_by_email('admin@qoqoc.ru') do  |u|
  u.password = 'adminqoqocik'
end
