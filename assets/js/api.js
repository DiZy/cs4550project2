const config = {
  method: 'POST',
  headers: {'Content-Type': 'application/json'},
}

const login = (email, password) => new Request("/api/auth", Object.assign({},
  config, 
  {body: JSON.stringify({email, password}) }
));

const register = (email, password) => new Request("/api/users", Object.assign({},
  config, 
  {body: JSON.stringify({user: {email, password}})}
));

export {
  login,
  register,
}
