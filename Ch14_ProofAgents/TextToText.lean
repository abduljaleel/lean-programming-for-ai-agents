-- Book listing around line 7896 (Ch14_ProofAgents).
class TextToText (τ : Type) where
  generate (model : τ) (input : String) (targetPrefix : String) :
    IO (Array (String × Float))
