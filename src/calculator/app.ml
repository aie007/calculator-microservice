open Calculator_lib
module Calc = Calculator

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
        print_endline "1. Add           2. Subtract             3. Multiply";
        print_endline "4. Divide        5. Square Root          6. Factorial";
        print_endline "7. Natural Log   8. Exponential          9. Exit";
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
                                                          "1" -> Calc.add a b
                                                        | "2" -> Calc.sub a b
                                                        | "3" -> Calc.mul a b
                                                        | _ -> Calc.div a b
                                                        in display string_of_float res)));
                        menu ()
                | "5" | "7" as ch ->
                        print_string "Number: ";
                        (match read_float_safe () with
                                  Error e -> print_endline e
                                | Ok a ->
                                        (let res = if ch = "5" then Calc.square_root a else Calc.ln a
                                        in display string_of_float res));
                        menu ()
                | "6" ->
                        print_string "Number: ";
                        (match read_int_safe () with
                                  Error e -> print_endline e
                                | Ok a -> display string_of_int (Calc.factorial a)); menu ()
                | "8" ->
                        print_string "Base: ";
                        (match read_float_safe () with
                                  Error e -> print_endline e
                                | Ok base ->
                                        print_string "Exponent: ";
                                        (match read_float_safe () with
                                                  Error e -> print_endline e
                                                | Ok exp -> display string_of_float (Calc.pow base exp)
                        )); menu ()
                | "9" -> print_endline "Exiting..."
                | _ ->  print_endline "Invalid choice"; menu ()

let () = menu ()
