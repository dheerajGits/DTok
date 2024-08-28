import React, { useState } from "react";
import { token } from "../../../declarations/token";
function Transfer() {

  const [toUser, setToUser] = useState("");
  const [amount, setAmount] = useState(0);
  const [isLoading, setIsLoading] = useState(false);
  async function handleClick() {
    setIsLoading(true);
    const message = await token.transfer(toUser, amount);

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
          <button id="btn-transfer" onClick={handleClick} >
            Transfer
          </button>
        </p>
      </div>
    </div>
  );
}

export default Transfer;
