import { createStore, combineReducers } from 'redux';
import deepFreeze from 'deep-freeze';

const INIT_FORM = {
  completed: false,
  token: "",
  id: "",
  creator_id: "",
  user_id: "",
  title: "",
  description: "",
  time_spent: 0,
};

const modals = (state = {createMemeModal: false, profileModal: false}, action) => {
  switch (action.type) {
    case 'UPDATE_MODAL_STATE':
      return Object.assign({}, state, action.data)
    default:
      return state;
  }
}

const position = (state = {}, action) => {
  switch (action.type) {
    case 'UPDATE_POSITION':
      return Object.assign({}, state, action.data);
    default: 
      return state;
  }
}

const form = (state = INIT_FORM, action) => {
  switch (action.type) {
    case 'UPDATE_FORM':
      return Object.assign({}, state, action.data);
    case 'INIT_FORM':
      let cleared = {
        title: "",
        description: "",
        time_spent: 0,
        completed: false
      }
      return Object.assign({}, state, cleared);
    case 'SET_TOKEN':
      let session = {
        creator_id: action.token.user_id,
        token: action.token.token,
        user_id: action.token.user_id
      }
      return Object.assign({}, state, session);
    case 'CLEAR_TOKEN':
      return {email: "",pass: ""};
    default:
      return state;
  }
}

let initToken = null;
if (window.userToken) {
  initToken = window.userToken
}

const token = (state = initToken, action) =>{
  switch (action.type) {
    case 'SET_TOKEN':
      return action.token;
    case 'CLEAR_TOKEN':
      return null;
    default:
      return state;
  }
}

const register = (state = {email: "",name: "",password: ""}, action) => {
  switch (action.type) {
    case 'INIT_FORM':
      return {email: "",name: "",password: ""};
    case 'UPDATE_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

const login = (state = {email: "",pass: ""}, action) => {
  switch (action.type) {
    case 'CLEAR_TOKEN':
      return {email: "",pass: ""};
    case 'UPDATE_LOGIN_FORM':
      return Object.assign({}, state, action.data);
    default:
      return state;
  }
}

<<<<<<< Updated upstream
const memes = (state = [], action) => {
  switch (action.type) {
    case 'ADD_MEMES':
      return [...state, ...action.data]
    default:
      return state
=======
const createMemeFormDefaultState = {
  isUserCreated: true, 
  textLineOne: "", 
  textLineTwo: "",
  imageURL: "",
  gifId: "",
  gifUrl: "",
  gifsAvailable: [],
}

const createMemeForm = (state = createMemeFormDefaultState, action) => {
  switch(action.type) {
    case "UPDATE_CREATE_MEME_FORM":
      console.log(action.data);
      return Object.assign({}, state, action.data)
    case "CLEAR_CREATE_MEME_FORM":
      return createMemeFormDefaultState;
    default:
      return state;
>>>>>>> Stashed changes
  }
}

const reducers = (state, action) => {
<<<<<<< Updated upstream
  let reducer = combineReducers({form, token, memes, login, register, position, modals});
=======
  let reducer = combineReducers({form, token, login, register, position, modals, createMemeForm});
>>>>>>> Stashed changes
  return deepFreeze(reducer(state, action));
};

let store = createStore(reducers, 
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
);

export default store;
