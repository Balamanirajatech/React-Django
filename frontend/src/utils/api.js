import axios from "axios";

const api = axios.create({
  baseURL: "/api",  // important!
  withCredentials: true,
});

export default api;
