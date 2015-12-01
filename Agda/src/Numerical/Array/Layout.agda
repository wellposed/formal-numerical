module Numerical.Array.Layout where

open import Data.Fin
open import Data.Vec
open import Data.Nat
open import Data.List
open import Relation.Binary.PropositionalEquality as PEq


record DominatedTuple (rank : ℕ ) (shape : Vec ℕ rank) : Set where
  field
       domIx : Vec ℕ rank
       .domBounded : ∀ (pos : Fin rank) -> lookup pos domIx Data.Nat.≤ lookup pos shape 

record TupleProjection (rank : ℕ ) (shape : Vec ℕ rank) : Set  where
   field
     manifest : ℕ 
     feasibleCount : manifest Data.Nat.≤ (product (toList shape))
     -- proof that manifest entry count is ≤ product of the dimensions
     
     index2address :  DominatedTuple rank shape → Fin manifest
     address2indes : Fin manifest -> DominatedTuple rank shape
     -- this almost feels like cheating, checked tuples by construction!
     -- also side steps strided addresses for now 
                         
     
