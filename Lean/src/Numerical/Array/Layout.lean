
import data.bool
check bool

inductive Var (a b : Type) : Type :=
  | Free : a -> Var a b 
  | Bound : b -> Var a b 

check Var

inductive AST (a : Type) : Type  :=
  | V : a -> AST a 
