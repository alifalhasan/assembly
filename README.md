# Assembly Language Programs Collection

## Project Description

This repository contains **10 practical MASM/TASM assembly language programs** designed for **x86 architecture** under DOS environments.  
This collection demonstrates core assembly programming concepts including character manipulation, ASCII conversions, binary and hexadecimal arithmetic, string operations, and sorting algorithms.  

These programs are tailored for **students** who wish to strengthen their understanding of low-level programming, bitwise operations, and DOS interrupt handling.  
Each program includes clear task objectives, well-commented code, and sample input/output demonstrations.

---

## Overview

This repository contains a collection of **10 Assembly Language programs** written for **MASM/TASM** targeting **x86 architecture** under DOS. Each program demonstrates fundamental assembly programming concepts such as:

- Character and string manipulation  
- ASCII and binary/hexadecimal conversions  
- Arithmetic operations (decimal, binary, hexadecimal)  
- Loops, conditionals, and stack usage  
- Array operations and sorting  

These programs are intended for **educational purposes and hands-on practice** in low-level programming.

---

## Repository Structure

| Filename                              | Description |
|---------------------------------------|-------------|
| `case_converter.asm`                 | Converts a character to its opposite case (upper ↔ lower). Handles invalid input. |
| `ascii_binary_and_bitcount.asm`      | Converts a character to its ASCII binary representation and counts the number of `1`s. |
| `ascii_to_hexadecimal.asm`           | Displays the hexadecimal representation of an input character. |
| `add_two_digits.asm`                  | Adds two single-digit numbers entered in `a b` format and displays the sum. |
| `binary_addition.asm`                 | Adds two binary numbers and displays inputs and sum in binary format. |
| `hexadecimal_addition.asm`            | Adds two hexadecimal numbers and displays the sum in binary format. |
| `reverse_last_10_chars.asm`           | Accepts a string (length ≤ 25) and prints the last 10 characters in reverse order. |
| `count_vowels_consonants.asm`         | Counts vowels and consonants in a user-input string (case-insensitive). |
| `reverse_string.asm`                  | Stores an input string in reverse order in another array and displays it. |
| `sort_n_numbers.asm`                  | Accepts `n` numbers, sorts them in ascending order, and displays the sorted array. |

---

## Detailed Task Descriptions

### 1. `case_converter.asm`
- **Objective:** Take a character input and convert it to uppercase if lowercase, or to lowercase if uppercase.  
- **Key Concepts:** ASCII manipulation, conditional jumps, DOS interrupts for input/output.  
- **Example Output:**
```

Enter a character: a
The uppercase is: A

```

### 2. `ascii_binary_and_bitcount.asm`
- **Objective:** Convert a character to binary and count the number of `1`s.  
- **Key Concepts:** Bit manipulation, loops, carry flag, ASCII conversion.  
- **Example Output:**
```

Enter a character: A
The ASCII code in binary: 01000001
Number of 1 bits: 2

```

### 3. `ascii_to_hexadecimal.asm`
- **Objective:** Display the hexadecimal value of an input character.  
- **Key Concepts:** ASCII manipulation, bit shifting, loops.  
- **Example Output:**
```

Enter a character: B
ASCII code in hexadecimal: 42h

```

### 4. `add_two_digits.asm`
- **Objective:** Add two single-digit numbers and display the sum in `a + b = c` format.  
- **Key Concepts:** Arithmetic operations, ASCII conversion, output formatting.  
- **Example Output:**
```

2 + 3 = 5

```

### 5. `binary_addition.asm`
- **Objective:** Add two binary numbers and print inputs and sum in binary.  
- **Key Concepts:** Binary arithmetic, bit shifting, loops, carry handling.  
- **Example Output:**
```

Enter First Number: 1010
Enter Second Number: 0111
Sum: 10001

```

### 6. `hexadecimal_addition.asm`
- **Objective:** Add two hexadecimal numbers and print the sum in binary.  
- **Key Concepts:** Hexadecimal to numeric conversion, bitwise operations, binary output.  
- **Example Output:**
```

Input 1: 1A
Input 2: 2B
Sum in binary: 0110101

```

### 7. `reverse_last_10_chars.asm`
- **Objective:** Accept a string of length ≤ 25 and print the last 10 characters in reverse order.  
- **Key Concepts:** Stack usage, loops, character handling.  
- **Example Output:**
```

Enter a string: HelloAssemblyWorld123
Output string: dlroW321ybm

```

### 8. `count_vowels_consonants.asm`
- **Objective:** Count vowels and consonants in a string (case-insensitive).  
- **Key Concepts:** Conditional branching, ASCII comparisons, counters.  
- **Example Output:**
```

Enter a string: Assembly
Number of vowels: 3
Number of consonants: 5

```

### 9. `reverse_string.asm`
- **Objective:** Store an input string in reverse order in another array and display it.  
- **Key Concepts:** Stack manipulation, memory storage, loops.  
- **Example Output:**
```

Insert input string: HelloWorld
Final string: dlroWolleH

```

### 10. `sort_n_numbers.asm`
- **Objective:** Accept `n` numbers, sort them in ascending order, and display the sorted array.  
- **Key Concepts:** Arrays, loops, sorting (bubble sort style), ASCII conversion.  
- **Example Output:**
```

Enter num of elements: 5
Sorted Array: 1 3 4 7 9

````

---

## Requirements

- **Assembler:** MASM or TASM  
- **Operating System:** DOS or DOSBox  
- **Architecture:** x86 16-bit  

---

## How to Run

1. Open DOSBox or a DOS environment.  
2. Assemble the program using MASM/TASM:
```bash
masm program_name.asm;
````

3. Link the object file:

```bash
link program_name.obj;
```

4. Run the executable:

```bash
program_name.exe
```

---

## Notes

* All programs use DOS interrupts for input/output.
* ASCII conversions are applied for proper number representation.
* Binary and hexadecimal programs demonstrate bitwise operations and numeric conversions.
* Programs are ideal for learning and teaching low-level programming fundamentals.

---

## License

This repository is for **educational purposes** and may be freely used and modified for learning Assembly Language programming.

```