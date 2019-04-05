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


const getNearbyMemes = () => new Request("/api/memesnearby", Object.assign({},
  config,
  {
    method: 'GET'
  }
));

const fetchGifs = () => new Request("/api/getgifs", Object.assign({},
  {
    method: 'GET',
    headers: {'Content-Type': 'application/json'},
  }
));

const uploadMeme = (body) => new Request("api/addmeme", Object.assign({},
  config,
  {body: JSON.stringify(body)}
));

export {
  login,
  register,
  getNearbyMemes,
  fetchGifs,
  uploadMeme,
}
