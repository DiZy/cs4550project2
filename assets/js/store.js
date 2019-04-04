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

const token = (state = null, action) =>{
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

const reducers = (state, action) => {
  let reducer = combineReducers({form, token, login, register, position, modals});
  return deepFreeze(reducer(state, action));
};

let store = createStore(reducers,
  window.__REDUX_DEVTOOLS_EXTENSION__ && window.__REDUX_DEVTOOLS_EXTENSION__()
);

export default store;
