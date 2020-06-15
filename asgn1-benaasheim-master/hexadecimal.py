# Implements operations on hexadecimal numbers.
# CSC 225, Assignment 1
# Given code, Winter '20


def binary_to_hex(number):
	"""
	Convert a 16-bit binary number to hexadecimal.
	TODO: Implement this function.
	
	:param number: A bitstring representing the number to convert
	:return: A hexadecimal string, the converted number
	"""
	string = "0" * 0
	number = number[::-1]
	for i in range(0, len(number), 4):
		string = four2one(number[i:i+4]) + string
	return "0x" + string

def four2one(number):
	number = number[::-1]
	n = binary_to_decimal(number)
	if n - 10 >= 0:
		n -= 10
		return chr(n+65)
	else:
		return single2char(n)

def single2char(n):
	if n == 9:
		return "9"
	elif n == 8:
		return "8"
	elif n == 7:
		return "7"
	elif n == 6:
		return "6"
	elif n == 5:
		return "5"
	elif n == 4:
		return "4"
	elif n == 3:
		return "3"
	elif n == 2:
		return "2"
	elif n == 1:
		return "1"
	else:
		return "0"

def hex_to_binary(number):
	"""
	Convert a hexadecimal number to 16-bit binary.
	TODO: Implement this function.
	
	:param number: A hexadecimal string, the number to convert
	:return: A bitstring representing the converted number
	"""
	if len(number) > 6:
		raise(OverflowError())
	string = "0"*0
	number = number[::-1]
	for i in number:
		if i != "x":
			#print(i, one2four(i), string)
			string = one2four(i) + string
		else:
			return string

def one2four(n):
	if n == "F":
		return "1111"
	elif n == "E":
		return "1110"
	elif n == "D":
		return "1101"
	elif n == "C":
		return "1100"
	elif n == "B":
		return "1011"
	elif n == "A":
		return "1010"
	elif n == "9":
		return "1001"
	elif n == "8":
		return "1000"
	elif n == "7":
		return "0111"
	elif n == "6":
		return "0110"
	elif n == "5":
		return "0101"
	elif n == "4":
		return "0100"
	elif n == "3":
		return "0011"
	elif n == "2":
		return "0010"
	elif n == "1":
		return "0001"
	elif n == "0":
		return "0000"

def binary_to_decimal(number):
	"""
	Convert an 8-bit, two's complement binary number to decimal.
	TODO: Implement this function.
	
	:param number: A bitstring representing the number to convert
	:return: An integer, the converted number
	"""
	#print()
	#print("# ", number)
	retnum = 0
	ind = 3
	while ind >= 0:
		#print(number[ind], ind, retnum)
		retnum += twoto(number[ind], 3-ind)
		ind -= 1
	return retnum

def twoto(dig, ind):
	if dig == "1":
		return 2**ind
	else:
		return 0
