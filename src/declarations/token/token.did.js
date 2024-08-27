export const idlFactory = ({ IDL }) => {
  const balanceType = IDL.Record({
    'balance' : IDL.Nat,
    'isFreeTokensRecieved' : IDL.Bool,
  });
  return IDL.Service({
    'balanceOf' : IDL.Func([IDL.Principal], [IDL.Nat], ['query']),
    'findData' : IDL.Func([IDL.Principal], [balanceType], ['query']),
    'getCurrencySymbol' : IDL.Func([], [IDL.Text], ['query']),
    'payOut' : IDL.Func([], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
