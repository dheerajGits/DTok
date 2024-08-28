import React, { useState } from "react";
import { Principal } from "@dfinity/principal";
import { token } from "../../../declarations/token"

function Balance() {

  const [id, setId] = useState("");
  const [symbol, setSymbol] = useState("");
  const [balance, setBalance] = useState();
  const [isLoading, setIsLoading] = useState(false);
  async function handleClick() {
    const principal = Principal.fromText(id);
    setIsLoading(true);
    const balance = await token.balanceOf(principal);
    const symbol = await token.getCurrencySymbol();
    setSymbol(symbol);
    setBalance(balance.toLocaleString());
    setIsLoading(false);
  }


  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          type="text"
          placeholder="Enter a Principal ID"
          value={id}
          required={true}
          onChange={(e) => setId(e.target.value)}
        />
      </p>
      <p className="trade-buttons">
        <button
          id="btn-request-balance"
          onClick={handleClick}
          disabled={isLoading}
        >
          Check Balance
        </button>
      </p>
      {balance && <p>This account has a balance of {balance} {symbol}.</p>
      }
    </div>
  );
}

export default Balance;
