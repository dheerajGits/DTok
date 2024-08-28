import type { Principal } from '@dfinity/principal';
export interface balanceTypeWithMessage {
  'balance' : bigint,
  'message' : string,
  'isFreeTokensRecieved' : boolean,
}
export interface _SERVICE {
  'balanceOf' : (arg_0: Principal) => Promise<bigint>,
  'findData' : (arg_0: Principal) => Promise<balanceTypeWithMessage>,
  'getCurrencySymbol' : () => Promise<string>,
  'payOut' : () => Promise<string>,
  'transfer' : (arg_0: Principal, arg_1: bigint) => Promise<string>,
}
