module Numerical.Array.Layout where

open import Data.Fin using (Fin)
open import Data.Vec using (Vec; lookup ; toList)
open import Data.Nat using (ℕ)
open import Data.List using (product)
open import Level as Lvl
open import Relation.Binary.PropositionalEquality as PEq
open import Relation.Binary as RB 

record DominatedTuple (rank : ℕ ) (shape : Vec ℕ rank) : Set where
  field
       domIx : Vec ℕ rank
       {.domBounded} : ∀ (pos : Fin rank) -> lookup pos domIx Data.Nat.≤ lookup pos shape 

record TupleLayout {c ℓ₁ ℓ₂ : Level } (rank : ℕ ) (shape : Vec ℕ rank) : Set (Lvl.suc (c Lvl.⊔ ℓ₁ Lvl.⊔  ℓ₂))  where
   field
     manifest : ℕ -- could also define manifest : Fin (product (toList shape))
     _≈_ : Rel (DominatedTuple rank shape) ℓ₁ 
     _≤_ : Rel (DominatedTuple rank shape) ℓ₂
     totalOrd : IsStrictTotalOrder _≈_ _≤_ 
     feasibleCount : manifest Data.Nat.≤ (product (toList shape))
     -- proof that manifest entry count is ≤ product of the dimensions
     
     index2address :  DominatedTuple rank shape → Fin manifest
     address2index : Fin manifest -> DominatedTuple rank shape
     {.addressRoundTrip} : ∀ (addr : Fin manifest) ->  index2address (address2index addr) ≡ addr
     -- this almost feels like cheating, checked tuples by construction!
     -- also side steps strided addresses for now 
     -- now, what if we additionally presume that
     {- 
       addr₁ ≤ addr₂ iff address2Index addr₁ ≤ address2Index addr₂ 
       with _ < _  iff _ < _ 
       too!

     question: what happens to the possible definitions of address2index and index2address if
     we add this ordering requirement? eg, can i do some sort of "universal"
     representation theorem in 1-2 dimensional cases given that info? 

     1 dim should be "easy" or "possible"

     2 dim will be a bit richer and 
     -}

     
