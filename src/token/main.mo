import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
actor Token {
    var owner : Principal = Principal.fromText("i3sui-4jlhl-x5foh-vozkm-nq4uw-yqh4y-esg6g-wpylg-kf7a5-r2t3r-uae");
    var totalSupply : Nat = 1000000000; // total token
    var symbol : Text = "DTOK";
    type balanceType = {
        balance : Nat;
        isFreeTokensRecieved : Bool;
    };
    type balanceTypeWithMessage = {
        balance : Nat;
        isFreeTokensRecieved : Bool;
        message : Text;
    };
    var balances : HashMap.HashMap<Principal, balanceType> = HashMap.HashMap<Principal, balanceType>(1, Principal.equal, Principal.hash);
    balances.put(owner, { balance = totalSupply; isFreeTokensRecieved = true }); // here we have initially assigned all the tokens to the owner and initialize isFreeTokenRecieved to true

    public query func balanceOf(id : Principal) : async Nat {
        let balance : Nat = switch (balances.get(id)) {
            case null 0;
            case (?result) result.balance;
        };

        return balance;
    };

    public query func findData(id : Principal) : async balanceTypeWithMessage {
        let balance : balanceTypeWithMessage = switch (balances.get(id)) {
            case null {
                {
                    balance = 0;
                    isFreeTokensRecieved = false;
                    message = "error";
                };
            };
            case (?result) {
                {
                    balance = result.balance;
                    isFreeTokensRecieved = result.isFreeTokensRecieved;
                    message = "success";
                };
            };
        };

        return balance;

    };
    public query func getCurrencySymbol() : async Text {
        return symbol;
    };
    public shared (msg) func payOut() : async Text {
        let caller = msg.caller;
        Debug.print(debug_show (msg.caller));
        let ownerBalance : Nat = await balanceOf(owner);
        let amount = 10000;
        let balance = await findData(caller);
        if (balance.isFreeTokensRecieved == false and ownerBalance >= 10000) {
            if (balance.balance != 0) {
                balances.put(
                    msg.caller,
                    {
                        balance = balance.balance +amount;
                        isFreeTokensRecieved = true;
                    },
                );
            } else {
                balances.put(
                    msg.caller,
                    {
                        balance = amount;
                        isFreeTokensRecieved = true;
                    },
                );
            }; // added 10000 to the user account
            balances.put(owner, { balance = ownerBalance -10000; isFreeTokensRecieved = true }); // decreased the tokens from owner balance
        } else {
            return "Already claimed or no free tokens to give";
        };
        return "Sucess";
    };
    public shared (msg) func transfer(to : Principal, amount : Nat) : async Text {
        let callerPrincipal = msg.caller;
        let callerAccountDetails = await findData(callerPrincipal);
        let recepientAccount = await findData(to);
        let fromBalance = callerAccountDetails.balance;
        if (fromBalance >= amount and callerAccountDetails.message == "success") {
            if (recepientAccount.message == "success") {
                let newFromBalance : Nat = fromBalance -amount;
                balances.put(
                    callerPrincipal,
                    {
                        balance = newFromBalance;
                        isFreeTokensRecieved = callerAccountDetails.isFreeTokensRecieved;
                    },
                );

            } else {
                return "Error in fetching the recipient account details or the reciepient does not exist";
            };
        } else {
            return "Unsufficient money or sender account doesn't exist";
        };
        return "Success";
    };
};
