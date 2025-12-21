//import axios from "axios";
import api from "../utils/api";


const setAuthToken = token => {
  if (token) {
    api.defaults.headers.common["Authorization"] = `Token ${token}`;
  } else {
    delete api.defaults.headers.common["Authorization"];
  }
};

export default setAuthToken;
