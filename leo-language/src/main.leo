// The 'leotest' main function.
@program // means that this is an aleo program 
function main(public a: u32, b: u32) -> u32 {
    let c: u32 = a + b;
    // If we do not specify visibility it is considered to be private by default
    return c; 
}


function helper(a: bool, b: bool) -> bool {

    let receiver: address = aleo1ezamst4pjgj9zfxqq0fwfj8a4cjuqndmasgata3hggzqygggnyfq6kmyd4;
    let sc: scalar = 1scalar;
    let unit: group = 0group; // group unit 
    let g: group = 1group; // group generator 
    let g2: group = 2group; // generator square, see point multiplication

    return a && b;
}

