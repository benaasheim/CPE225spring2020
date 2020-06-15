# Implements operations on binary numbers.
# CSC 225, Assignment 1
# Given code, Winter '20


def add(addend_a, addend_b):
	"""
	Add two 8-bit, two's complement binary numbers; ignore carries/overflows.
	TODO: Implement this function. Do *not* convert the numbers to decimal.
	
	:param addend_a: A bitstring representing the first number
	:param addend_b: A bitstring representing the second number
	:return: A bitstring representing the sum
	"""
	string2 = '0'
	string = string2*0
	ind = 7
	carry = "0"
	first = ("0", "0")
	while ind >= 0:
		#print("Current String: " + string)
		#print("A@" + str(ind) + ": " + addend_a[ind] + "  B@" + str(ind) + ": " +  addend_b[ind])
		first = addDigits(addend_a[ind], addend_b[ind], carry)
		carry = first[0]
		string = first[1] + string
		ind -= 1
	return string



def negate(number):
	"""
	Negate an 8-bit, two's complement binary number.
	TODO: Implement this function. Do *not* convert the number to decimal.
	
	:param number: A bitstring representing the number to negate
	:return: A bistring representing the negated number
	"""
	string2 = '0'
	string = string2*0
	ind = 7
	while ind >= 0:
		string = switch(number[ind]) + string
		ind -= 1
	return add(string, "00000001")

def addDigits(digA, digB, carry):
	if (digA == "1") and (digB == "1") and (carry == "1"):
		return ("1", "1")
	elif (digA == "0") and (digB == "0") and (carry == "0"):
		return ("0", "0")
	elif ((digA == "1") and (digB == "1")) or ((digA == "1") and (carry == "1")) or ((digB == "1") and (carry == "1")):
		return ("1", "0")
	else:
		return ("0", "1")

def switch(dig):
	if dig == "0":
		return "1"
	else:
		return "0"


def subtract(minuend, subtrahend):
	"""
	Subtract one 8-bit, two's complement binary number from another.
	TODO: Implement this function. Do *not* convert the numbers to decimal.
	
	:param minuend: A bitstring representing the number from which to subtract
	:param subtrahend: A bitstring representing the number to subtract
	:return: A bitstring representing the difference
	"""
	return add(minuend, negate(subtrahend))


def binary_to_decimal(number):
	"""
	Convert an 8-bit, two's complement binary number to decimal.
	TODO: Implement this function.
	
	:param number: A bitstring representing the number to convert
	:return: An integer, the converted number
	"""
	#print()
	negative = False
	if number[0] == "1":
		number = negate(number)
		negative = True
	retnum = 0
	ind = 7
	while ind >= 1:
		#print(number[ind], ind, retnum)
		retnum += twoto(number[ind], 7-ind)
		ind -= 1
	if negative:
		retnum *= -1
	return retnum

def twoto(dig, ind):
	if dig == "1":
		return 2**ind
	else:
		return 0

def decimal_to_binary(number):
	"""
	Convert a decimal number to 8-bit, two's complement binary.
	TODO: Implement this function.
	
	:param number: An integer, the number to convert
	:return: A bitstring representing the converted number
	:raise OverflowError: If the number cannot be represented with 8 bits
	"""
	if number > 127:
		raise(OverflowError())
	if number < -128:
		raise(OverflowError())
	string2 = '0'
	string = string2*0
	negative = False
	if number < 0:
		negative = True
		number *= -1
	string += "0"
	ind = 6
	while ind >= 0:
		if number - (2**ind) >= 0:
			number -= (2**ind)
			string += "1"
		else:
			string += "0"
		ind -= 1
	if negative:
		string = negate(string)
	return string

