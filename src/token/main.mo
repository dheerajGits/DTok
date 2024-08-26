import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
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

};
