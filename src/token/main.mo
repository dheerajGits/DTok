import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
actor Token {
    var owner : Principal = Principal.fromText("i3sui-4jlhl-x5foh-vozkm-nq4uw-yqh4y-esg6g-wpylg-kf7a5-r2t3r-uae");
    var totalSupply : Nat = 1000000000; // total token
    var symbol : Text = "DTOK";
    var balances : HashMap.HashMap<Principal, Nat> = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
    balances.put(owner, totalSupply); // here we have initially assigned all the tokens to the owner

    public query func balanceOf(id : Principal) : async Nat {
        let balance : Nat = switch (balances.get(id)) {
            case null 0;
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
        let amount = 10000;
        let balance = await balanceOf(caller);
        if (balance != 0) {
            balances.put(msg.caller, amount +balance);
        } else {
            balances.put(msg.caller, amount);
        };
        return "Sucess";
    };
};
