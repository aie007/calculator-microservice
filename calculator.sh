# !bin/bash
# A simple calculator

echo "1. Addition \n2. Subtraction \n3. Multiplication \n4. Division"

echo -n "Enter first number: "
read a

echo -n "Enter second number: "
read b

echo -n "Enter your choice: "
read ch

case $ch in
	1) res=`expr $a + $b`
	;;
	2) res=`expr $a - $b`
	;;
	3) res=`expr $a \* $b`
	;;
	4) res=`expr $a / $b`
	;;
esac

echo "Result: $res"
