/*:

## 1. Optional String

 The var `s` might be a string, or it might be nil. Conditionally unwrap s using a `if let` statement. If `s` can be safely unwraped then print it using `print(s)`.
*/

let s: String?
s = generateStringOrNil()

// Your code for question 1 here.


/*:
 ---
## 2. Counting nils

The `generateRandomArrayOfIntsAndNils` function creates an array that is a random mix of Int values and nils. 
 
Write code that counts the number of nil values in array1
*/

let array1: [Int?]
array1 = generateRandomArrayOfIntsAndNils()

var total: Int = 0

// Your code for question 2 here


/*:
 ---
## 3. Mean

Write code that calculates the mean value of the non nil elements in array1.
*/
let array2 = generateRandomArrayOfIntsAndNils()

// Your code for question 3 here.

/*:
 ---
## 4. New Array

 Write code that creates a new array named nilFree that has the same elements
 as array3, except without the nil values. The elements in nilFree should be
 Ints, not Int optionals.
 
*/

let array3 = generateRandomArrayOfIntsAndNils()

// Your code for questio 4 here.
/*:
 ---
## 5. Sort array

 Write code that will sort array4 using your own logic. You might want to
 review the logic for Selection Sort or even Bubble Sort. Find a sort
 algorithm that you like in a language that you are familiar with and then
 translate it to Swift. Resist the temptation to find a sort online that
 is already written in swift. Do not use Swift's sort method.

 Note that array4 is declared with var, so that it is a mutable array.
*/
 
var array4 = generateRandomArrayOfIntsAndNils()

// Your code for question 5 here.

