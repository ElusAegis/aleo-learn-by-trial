// The 'firstprogram.aleo' program.
// To run, rename file to `main.aleo` and change the `program` to `main.aleo` in the `program.json`
program firstprogram.aleo;

// An array with fixed length of 3
// Note that we need to explicitly list all data types
// Interface is like a structure  
interface array3:
    a0 as u32;
    a1 as u32;
    a2 as u32;

// Function that sums up two numbers, one of which is private
// And outputs a private result 
function hello:
    // We need to specify which input registers are private or public
    input r0 as u32.public;
    input r1 as u32.private;
    // After an operation we need to save result into a register
    add r0 r1 into r2;
    // If we want to output the register we need to mark it as such
    output r2 as u32.private;


// Function that adds one to each element of array 3
function sum_one_to_array3:
    input r0 as array3.private;
    // We can index on the interfaces to get values
    add r0.a0 1u32 into r1;
    add r0.a1 1u32 into r2;
    add r0.a2 1u32 into r3;
    // We can cast a set of registers to form an interface
    cast r1 r2 r3 into r4 as array3;
    // We also need to mark register as output and specify visibility
    output r4 as array3.private;

// RUN INSTRUCTIONS 

// To call first compile the program with `aleo build`
// And then run it by 
// aleo run sum_one_to_array3 "{a0: 1u32, a1: 2u32, a2: 3u32}"
// To remove all the compiled files run `aleo clean`

 // END 




