import type { Principal } from '@dfinity/principal';
export interface balanceType {
  'balance' : bigint,
  'isFreeTokensRecieved' : boolean,
}
export interface _SERVICE {
  'balanceOf' : (arg_0: Principal) => Promise<bigint>,
  'findData' : (arg_0: Principal) => Promise<balanceType>,
  'getCurrencySymbol' : () => Promise<string>,
  'payOut' : () => Promise<string>,
}
