const username = _getEnv('MONGODB_USER')
const password = _getEnv('MONGODB_PASSWORD')
const userNumber = db.getSiblingDB('admin').getUser(username)
if (userNumber == null) {
  db.getSiblingDB('admin').createUser({ user: username, pwd: password, roles: ['root'] })
  print(`[+] admin user ${username} has been created`)
}
else {
  print(`[+] admin user ${username} already exists`)
}
