module Numerical.Float.Word where

open import Data.Nat as DN
open import Data.Bin as DB
open import Data.List using (length)
{-
mod 2ⁿ natural numbers

-}

record Word (n :  ℕ ) : Set where
  field
    word : ℕ
    pf : (length (toBits ( fromℕ word)) ≤ n)
