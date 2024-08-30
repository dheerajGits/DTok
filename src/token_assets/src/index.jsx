import ReactDOM from 'react-dom'
import React from 'react'
import App from "./components/App";
import { AuthClient } from "@dfinity/auth-client";

const init = async () => {
  const authClient = await AuthClient.create();
  if (await authClient.isAuthenticated()) {
    const auth = await authClient.isAuthenticated()
    console.log(auth);
    ReactDOM.render(<App />, document.getElementById("root"));
  }
  else {
    await authClient.login({
      identityProvider: "https://identity.ic0.app/#authorize",
      onSucess: () => {
        ReactDOM.render(<App />, document.getElementById("root"));
      }
    });
  }
}

init();


