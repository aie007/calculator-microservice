module Calculator = struct
	let square_root n = sqrt (float_of_int n)

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

	let ln x = log (float_of_int x) 
	
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
	print_string "\n-------------------\nScientific Calculator\n--------------------- \n1. Square Root \n2. Factorial \n3. Natural Logarithm \n4. Exponentiation \n5. Exit \nEnter choice: ";

	let choice = read_line () in match choice with
			  "1" -> 
				print_string "Enter a number: ";
				let n = int_of_string (read_line ()) in print_endline ("Square root = "  ^ string_of_float (Calculator.square_root n));
				menu ()
			| "2" ->
				print_string "Enter a number: ";
				let n = int_of_string (read_line ()) in print_endline ("Factorial = " ^ string_of_int (Calculator.factorial n));
				menu ()
			| "3" -> 
				print_string "Enter a number: ";
				let n = int_of_string (read_line ()) in print_endline ("Natural Log = " ^ string_of_float (Calculator.ln n));
				menu ()
			| "4" ->
				print_string "Enter base: ";
				let x = int_of_string (read_line ()) in
				print_string "Enter exponent: "; 
				let b = int_of_string (read_line ()) in 
				print_endline ("Result = " ^ string_of_int (Calculator.pow x b));
				menu ()
			| "5" -> 
				print_endline "exiting\n-----------------\n"
			| _ -> 
				print_endline "Invalid choice\n----------------\n";
				menu ()
				
	
let () = menu ()
