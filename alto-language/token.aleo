//import library.aleo;

program token.aleo; // here .aleo stands for network, but right now only aleo is available
// The network can be used to deploy programs for particular network  

// Record is information that will be stored on chain 
// It represents users assets and application state
// Records are consumed and produced during state transitions 

// This is an example of a record for a token NFT
record nft:
   owner as address.private; // Who owns a token, should be the public address of the program 
   gates as u64.private; // Amount of credit that the record need to spend


// Note that records are only visible to the owner
// And the program only can consume records that were defined in it
// This is the security model that Aleo has, assuming:
// the function can see any of its own records, but none of the others

// This is a record for a fungible fungible token
// When doing a transfer we will consume some of the records
// And then produce new records.
// Note that records are very close to Bitcoins UTXO model
record fungible_token:
   owner as address.private; // mandatory for each record, must be in this order
   gates as u64.private; // mandatory for each record, must be in this order
   amount as u64.private; // user defined 

// If the order of mandatory fields is not maintained, you will get a parser error

function transfer_amount:
   // Sender token record
   input r0 as fungible_token.record; // Please note such notation for depicting token
   // Receiver address 
   input r1 as address.private;
   // Amount to transfer
   input r2 as u64.private;


   // Final balance after transfer
   sub r0.amount r2 into r3;
   // Final balance of receiver  
   add 0u64 r2 into r4;

   // Generate a sender record after transfer
   cast r0.owner r3  r0.gates into r5 as fungible_token.record;
   // Generate a receiver record after transfer
   cast r1 r4 0u64 into r6 as fungible_token.record;


   // Generate outputs
   // We still need to specify whihc are outputs, 
   // but we do not need to visibility as the records are private to the program 
   output r5 as fungible_token.record; 
   output r6 as fungible_token.record;


// RUN THE PROGRAM

// Make sure to replace the owner value with the `address` provided in the `program.json`

// aleo clean && aleo run transfer_amount "{owner: aleo1v3jyehtrzl468hf7xnm3k9j03dhrnq06kfydde4xlaa6y4u9q5zskxk9u4.private, gates: 0u64.private, amount: 50u64.private}" aleo1h3gu7fky36y8r7v2x9phc434fgf20g8qd7c7u45v269jfw6vmugqjegcvp 10u64

// As an output you will get two records, each having a field `_nonce`.
// This field is used as a unique identifier for each record.



mapping token_holders:
   key owner as address.public;
   value amount as u64.public;


// `finalise` is a check that is performed to identify if the state of the program after the execution is valid
// If it is not, the program will revert to the previous state
function transfer_public:
   // Input the token sender and reciever
   input r0 as address.public;
   input r1 as address.public;

   input r2 as u64.public;

   // We can use decrement and increment functions to easily operate on the mapping
   decrement token_holders[r0] r2;
   increment token_holders[r1] r2;



// As we can see by now we have created two ways to transfer tokens:
// Publicly via the mapping and privately via records
// As they are the same tokens we need to make sure that the user can convert from public to private and back
function transfer_public_to_private:
   input r0 as address.public; // reciever address

   input amount as u64.public;

   cast r0 0u64 r1 into r2 as fungible_token.record;
   output r2 as fungible_token.record;

   // We can access who has submitted the request via `self.caller`
   finalize self.caller r1; 


finalize transfer_public_to_private:
   input r0 as adderss.public;
   input r1 as u64.public;

   decrement account[r0] by r1;


