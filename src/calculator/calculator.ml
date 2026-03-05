let add a b = Ok (a +. b)

let sub a b = Ok (a -. b)

let mul a b = Ok (a *. b)

let div a b = if b = 0. then Error "Division by zero undefined" else Ok (a /. b)

let square_root n = if n < 0. then Error "Square root of negative number undefined" else Ok (sqrt n)
(* 
let rec factorial2 n = 
	if n = 0 then 1 else (factorial (n - 1)) * n
*)
let factorial n =
	if n < 0 then Error "Factorial of negative integer undefined" 
	else 
		let rec iter n acc = 
			if n = 0 then acc
			else iter (n - 1) (acc * n)
		in Ok (iter n 1)

let ln x = if x <= 0. then Error "Log of zero/negative number undefined" else Ok (log x)
 
(* 
let rec pow x b = 
	if b = 0 then 1 else x * pow x (b - 1)
*)
(* fast doubling - exponentation *)
(*	let rec pow x b = 
		if b = 0 then 1
		else if b = 1 then x
		else (let y = pow x (b / 2) in y * y * (if b mod 2 = 0 then 1 else x)) *)
let pow x b = 
	let res = x ** b in 
	if Float.is_nan res then Error "Exponential of complex number undefined"
	else if not (Float.is_finite res) then Error "Overflow or division by zero"
	else Ok res
