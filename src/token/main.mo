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
    var balances : HashMap.HashMap<Principal, balanceType> = HashMap.HashMap<Principal, balanceType>(1, Principal.equal, Principal.hash);
    balances.put(owner, { balance = totalSupply; isFreeTokensRecieved = true }); // here we have initially assigned all the tokens to the owner and initialize isFreeTokenRecieved to true

    public query func balanceOf(id : Principal) : async Nat {
        let balance : Nat = switch (balances.get(id)) {
            case null 0;
            case (?result) result.balance;
        };

        return balance;
    };

    public query func findData(id : Principal) : async balanceType {
        let balance : balanceType = switch (balances.get(id)) {
            case null {
                {
                    balance = 0;
                    isFreeTokensRecieved = false;
                };
            };
            case (?result) result;
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
        if (balance.isFreeTokensRecieved == false and ownerBalance > 0) {
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
            };

        } else {
            return "Already claimed or no free tokens to give";
        };
        return "Sucess";
    };
};
