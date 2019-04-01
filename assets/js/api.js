const config = {
  method: 'POST',
  headers: {'Content-Type': 'application/json'},
}

const login = (email, pass) => new Request("/taskify-api//token", Object.assign({},
  config, 
  {body: JSON.stringify({email, pass}) }
));

const register = (email, name, password) => new Request("/taskify-api//users", Object.assign({},
  config, 
  {body: JSON.stringify({user: {email, name, password}}) }
));

export {
  login,
  register,
}
