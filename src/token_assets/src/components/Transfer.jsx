import React, { useState } from "react";
import { token } from "../../../declarations/token";
function Transfer() {

  const [toUser, setToUser] = useState("");
  const [amount, setAmount] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  const [message, setMessage] = useState("");
  async function handleClick() {
    setIsLoading(true);
    const messageRecieved = await token.transfer(toUser, amount);
    setMessage(messageRecieved);
    setIsLoading(false);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={toUser}
                onChange={(e) => setToUser(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={amount}
                onChange={(e) => setAmount(e.target.value)}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled={isLoading} >
            Transfer
          </button>
          {message && <p>{message}</p>}
        </p>
      </div>
    </div>
  );
}

export default Transfer;
