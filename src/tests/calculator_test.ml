open OUnit2
open Calculator_lib

let test_add _ =
	match Calculator.add 2. 3. with
		  Ok res -> assert_equal (cmp_float 5.0 res) true
		| Error _ -> assert_failure "Should have succeeded"

let test_div_by_zero _ =
	match Calculator.div 10. 0. with
		  Error msg -> assert_equal "Division by zero undefined" msg
		| Ok _ -> assert_failure "Should have failed with DivisionByZero"

let test_factorial_positive _ =
	match Calculator.factorial 5 with
		  Ok res -> assert_equal 120 res
		| Error _ -> assert_failure "Factorial 5 should be 120"

let test_factorial_zero _ =
	match Calculator.factorial 0 with
		  Ok res -> assert_equal 1 res
		| Error _ -> assert_failure "Factorial 0 should be 1"

let test_factorial_negative _ =
	match Calculator.factorial (-6) with
		  Error msg -> assert_equal "Factorial of negative integer undefined" msg
		| Ok _ -> assert_failure "factorial -6 should fail"

let test_sqrt_negative _ =
	match Calculator.square_root (-25.) with
		  Error msg -> assert_equal "Square root of negative number undefined" msg
		| Ok _ -> assert_failure "square_root -25 should fail" 

let suite = "Calculator Tests" >::: [
	"test_add" >:: test_add;
	"test_div_by_zero" >:: test_div_by_zero;
	"test_factorial_positive" >:: test_factorial_positive;
	"test_factorial_negative" >:: test_factorial_negative;
	"test_factorial_zero" >:: test_factorial_zero;
	"test_sqrt_negative" >:: test_sqrt_negative;
]

let () = run_test_tt_main suite
