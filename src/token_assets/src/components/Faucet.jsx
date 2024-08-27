import React, { useState } from "react";
import { token } from "../../../declarations/token";
import { Iso } from "@material-ui/icons";

function Faucet() {

  const [isLoading, setIsLoading] = useState(false);
  async function handleClick(event) {
    setIsLoading(true);
    const message = await token.payOut();
    setIsLoading(false);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free DTOK tokens here! Claim 10,000 DTOK coins to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={isLoading}>
          Gimme gimme
        </button>
      </p>
    </div>
  );
}

export default Faucet;
