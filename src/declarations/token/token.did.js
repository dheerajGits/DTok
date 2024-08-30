export const idlFactory = ({ IDL }) => {
  const balanceTypeWithMessage = IDL.Record({
    'balance' : IDL.Nat,
    'message' : IDL.Text,
    'isFreeTokensRecieved' : IDL.Bool,
  });
  return IDL.Service({
    'balanceOf' : IDL.Func([IDL.Principal], [IDL.Nat], ['query']),
    'findData' : IDL.Func([IDL.Principal], [balanceTypeWithMessage], ['query']),
    'getCurrencySymbol' : IDL.Func([], [IDL.Text], ['query']),
    'payOutFaucet' : IDL.Func([], [IDL.Text], []),
    'transfer' : IDL.Func([IDL.Principal, IDL.Nat], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
