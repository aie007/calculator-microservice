module Calculator = struct
	let add a b = Ok (a +. b)

	let sub a b = Ok (a -. b)

	let mul a b = Ok (a *. b)

	let div a b = 
		if b = 0. then Error "Division by zero undefined" else Ok (a /. b)

	let square_root n = 
		if n < 0. then Error "Square root of negative number undefined" else Ok (sqrt n)
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

	let ln x = 
		if x <= 0. then Error "Log of zero/negative number undefined" else Ok (log x)
 
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

end

let read_float_safe () = 
	try Ok (float_of_string (read_line ()))
	with Failure _ -> Error "Invalid input: expected a decimal number"

let read_int_safe () = 
	try Ok (int_of_string (read_line ()))
	with Failure _ -> Error "Invalid input: expected an integer"

let display string_of_val res = 
	match res with 
		  Ok v -> print_endline ("Result: " ^ string_of_val v)
		| Error e -> print_endline ("Error: " ^ e)

let rec menu () =
	print_endline "\nScientific Calculator";
	print_endline "1. Add		2. Subtract		3. Multiply";
	print_endline "4. Divide	5. Square Root 		6. Factorial";
	print_endline "7. Natural Log	8. Exponential		9. Exit";
	print_string "Enter choice: ";

	match read_line () with
		  "1" | "2" | "3" | "4" as ch ->
			print_string "Number1: ";
			(match read_float_safe () with
				  Error e -> print_endline e
				| Ok a -> 	
					print_string "Number2: ";
					(match read_float_safe () with
				 		  Error e -> print_endline e
						| Ok b -> 
							(let res = match ch with
							  "1" -> Calculator.add a b
							| "2" -> Calculator.sub a b
							| "3" -> Calculator.mul a b
							| _ -> Calculator.div a b
							in display string_of_float res)));
			menu ()	
		| "5" | "7" as ch -> 
			print_string "Number: ";
			(match read_float_safe () with 
				  Error e -> print_endline e
				| Ok a -> 
					(let res = if ch = "5" then Calculator.square_root a else Calculator.ln a
					in display string_of_float res));
			menu ()
		| "6" -> 
			print_string "Number: ";
			(match read_int_safe () with 
				  Error e -> print_endline e
				| Ok a -> display string_of_int (Calculator.factorial a)); menu ()
		| "8" ->
			print_string "Base: ";
			(match read_float_safe () with
				  Error e -> print_endline e
				| Ok base -> 
					print_string "Exponent: ";
					(match read_float_safe () with
						  Error e -> print_endline e
						| Ok exp -> display string_of_float (Calculator.pow base exp)
			)); menu ()
		| "9" -> print_endline "Exiting..."
		| _ -> 	print_endline "Invalid choice"; menu ()
				
let () = menu ()
