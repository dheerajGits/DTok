import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'balanceOf' : (arg_0: Principal) => Promise<bigint>,
  'getCurrencySymbol' : () => Promise<string>,
  'payOut' : () => Promise<string>,
}
