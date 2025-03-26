-- Define functions for symbolic representation
data Function
    = Const Double
    | Var
    | Power Function Int
    | FractionalPower Function Double
    | Exp Function
    | LogBase2 Function
    | Sin Function
    | Cos Function
    | Arcsin Function
    | Multiply Function Function
    | Add Function Function
    | Subtract Function Function
    | Divide Function Function
    deriving Show

-- Convert functions to a string representation
toString :: Function -> String
toString (Const c) = show c
toString Var = "x"
toString (Power f n) = "(" ++ toString f ++ ")^" ++ show n
toString (FractionalPower f p) = "(" ++ toString f ++ ")^" ++ show p
toString (Exp f) = "e^(" ++ toString f ++ ")"
toString (LogBase2 f) = "log2(" ++ toString f ++ ")"
toString (Sin f) = "sin(" ++ toString f ++ ")"
toString (Cos f) = "cos(" ++ toString f ++ ")"
toString (Arcsin f) = "asin(" ++ toString f ++ ")"
toString (Multiply f g) = "(" ++ toString f ++ " * " ++ toString g ++ ")"
toString (Add f g) = "(" ++ toString f ++ " + " ++ toString g ++ ")"
toString (Subtract f g) = "(" ++ toString f ++ " - " ++ toString g ++ ")"
toString (Divide f g) = "(" ++ toString f ++ " / " ++ toString g ++ ")"

-- Derivatives of functions
derivative :: Function -> Function
derivative (Const _) = Const 0
derivative Var = Const 1
derivative (Power f n) = Multiply (Multiply (Const (fromIntegral n)) (Power f (n - 1))) (derivative f)
derivative (FractionalPower f p) = Multiply (Multiply (Const p) (FractionalPower f (p - 1))) (derivative f)
derivative (Exp f) = Multiply (Exp f) (derivative f)
derivative (LogBase2 f) = Divide (derivative f) (Multiply f (Const (logBase 2 (exp 1))))
derivative (Sin f) = Multiply (Cos f) (derivative f)
derivative (Cos f) = Multiply (Const (-1)) (Multiply (Sin f) (derivative f))
derivative (Arcsin f) = 
    Divide (derivative f) (FractionalPower (Subtract (Const 1) (Power f 2)) 0.5)
derivative (Multiply f g) = Add (Multiply (derivative f) g) (Multiply f (derivative g))
derivative (Add f g) = Add (derivative f) (derivative g)
derivative (Subtract f g) = Subtract (derivative f) (derivative g)
derivative (Divide f g) =
    Divide (Subtract (Multiply (derivative f) g) (Multiply f (derivative g))) (Power g 2)

-- Define the complex function
complexFunction :: Function
complexFunction =
    Add
    (Divide
        (Add
            (Add
                (Multiply (Const 5) (Power Var 2))
                (Multiply (Multiply (Const 4) (Exp (Power Var 2))) (Multiply (Const 9) Var))
            )
            (Multiply (Const 34) (LogBase2 Var))
        )
        (Sin (Power Var 3))
    )
    (Arcsin (Multiply (Const 85) Var))

-- Main function
main :: IO ()
main = do
    putStrLn $ "Function: " ++ toString complexFunction
    putStrLn $ "Derivative: " ++ toString (derivative complexFunction)

