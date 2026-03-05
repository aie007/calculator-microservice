open OUnit2
open Calculator_lib

let test_add _ =
	match Calculator.add 2. 3. with
		  Ok res -> assert_equal (cmp_float 5.0 res) true
		| Error _ -> assert_failure "Should have succeeded"

let test_div_by_zero _ =
	match Calculator.div 10. 0. with
		  Error msg -> assert_equal "Division by zero undefined" msg
		| Ok _ -> assert_failure "Should have failed with DividionByZero"

let test_factorial _ =
	match Calculator.factorial 5 with
		  Ok res -> assert_equal 120 res
		| Error _ -> assert_failure "Factorial 5 should be 120"

let suite = "Calculator Tests" >::: [
	"test_add" >:: test_add;
	"test_div_by_zero" >:: test_div_by_zero;
	"test_factorial" >:: test_factorial;
]

let () = run_test_tt_main suite
