module Calculator = struct
	let add = (+.)
	let sub = (-.)
	let mult = ( *. )
	let div = (/.)
	let square_root n = sqrt n
	(* 
	let rec factorial2 n = 
		if n = 0 then 1 else (factorial (n - 1)) * n
	*)
	let factorial n = 		
		let rec iter n acc = 
			if n = 0 then acc
			else iter (n - 1) (acc * n)
		in
		iter n 1
	let ln x = log x 
	(* 
	let rec pow x b = 
		if b = 0 then 1 else x * pow x (b - 1)
	*)
	(* fast doubling - exponentation *)
	let rec pow x b = 
		if b = 0 then 1
		else if b = 1 then x
		else (let y = pow x (b / 2) in y * y * (if b mod 2 = 0 then 1 else x))		
end

let rec menu () =
	print_endline "Scientific Calculator"
	print_endline "1. Add"
	print_endline "2. Subtract"
	print_endline "3. Multiply"
	print_endline "4. Divide"
	print_endline "5. Square Root"
	print_endline "6. Factorial"
	print_endline "7. Natural Logarithm"
	print_endline "8. Exponential"
	print_string "Enter choice: ";

	let choice = read_line () in 
		match choice with
			  "1" ->
				print_string "Enter number: "
				let a = float_of_string (read_line ()) in 
				print_string "Enter number: " 
				let b = float_of_string (read_line ()) in
				print_endline ("Addition: " ^ string_of_float (Calculator.add a b));
				menu ()
			| "2" ->
				print_string "Enter number: "
                                let a = float_of_string (read_line ()) in
                                print_string "Enter number: "
                                let b = float_of_string (read_line ()) in
                                print_endline ("Subtraction: " ^ string_of_float (Calculator.sub a b));
                                menu ()
			| "3" ->
				print_string "Enter number: "
                                let a = float_of_string (read_line ()) in
                                print_string "Enter number: "
                                let b = float_of_string (read_line ()) in
                                print_endline ("Multiplication: " ^ string_of_float (Calculator.mult a b));
                                menu ()
			| "4" -> 
				print_string "Enter number: "
                                let a = float_of_string (read_line ()) in
                                print_string "Enter number: "
                                let b = float_of_string (read_line ()) in
                                let r = (Calculator.div a b) in print_endline ("Division: " ^ string_of_float r);
                                menu ()
			| "5" -> 
				print_string "Enter a number: ";
				let n = float_of_string (read_line ()) in print_endline ("Square root = "  ^ string_of_float (Calculator.square_root n));
				menu ()
			| "6" ->
				print_string "Enter a number: ";
				let n = int_of_string (read_line ()) in print_endline ("Factorial = " ^ string_of_int (Calculator.factorial n));
				menu ()
			| "7" -> 
				print_string "Enter a number: ";
				let n = float_of_string (read_line ()) in print_endline ("Natural Log = " ^ string_of_float (Calculator.ln n));
				menu ()
			| "8" ->
				print_string "Enter base: ";
				let x = int_of_string (read_line ()) in
				print_string "Enter exponent: "; 
				let b = int_of_string (read_line ()) in 
				print_endline ("Result = " ^ string_of_int (Calculator.pow x b));
				menu ()
			| "9" -> 
				print_endline "Exiting..."
			| _ -> 
				print_endline "Invalid choice";
				menu ()
				
	
let () = menu ()
