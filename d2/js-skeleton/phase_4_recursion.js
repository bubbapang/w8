console.log("phase 4")
console.log("1")

function range(start, end) {
    // base case
    if (start === end) {
        return [start]; 
    }
    
    let resultArr = [start];
    // recursive step
    return resultArr.concat(
        range(start + 1, end)
        );
}

console.log(range(1, 10)) 
//[1, 2, 3, 4, 5 ... 10]

console.log(range(0, 2))
// [0, 1, 2]

/////////////////////////////////////////////////////////

console.log("2")

function sumRec(arr) {
    // base case
    if (arr.length === 1) {
        return arr[0];
    }
    return arr[0] + sumRec(arr.slice(1, arr.length));
}

console.log(sumRec([1, 2, 3])) 
//6

console.log(sumRec([-1, 2, 3, 10])) 
//14

/////////////////////////////////////////////////////////

console.log("3")

function exponent(base, exp) {
    // base case
    if (exp === 0) {
        return 1;
    }
    return base * exponent(base, exp - 1);
};

console.log(exponent(2, 4)) 
// 16

console.log(exponent(3, 3)) 
// 27

/////////////////////////////////////////////////////////

console.log("4")

function nth_fibonacci(nth) {
    if (nth < 1) {
        return 0;
    }
    else if (nth === 1) {
        return 0;
    }
    else if (nth === 2) {
        return 1;
    };
    return nth_fibonacci(nth - 1) + nth_fibonacci(nth - 2);
}

function fibonacci(n) {

    let arr = new Array();

    // base case
    if (n < 1) {
        return [];
    }
    else if (n === 1) {
        return [0];
    }
    else if (n === 2) {
        return [0, 1];
    };
    
    // inductive step
    arr = (fibonacci(n - 1));
    arr.push(nth_fibonacci(n));
    
    return arr
    
};

console.log(fibonacci(4)) 
// [0, 1, 1, 2]

console.log(fibonacci(6)) 
// [0, 1, 1, 2, 3, 5]

/////////////////////////////////////////////////////////

console.log("5")

function deepDup(arr) {
    // base case
    if (arr.length === 1){
        return [arr[0]];
    }
    // setting empty array
    let arrDup = [];
    arrDup.push(arr[0]);
    arrDup.push(...deepDup(arr.slice(1, arr.length)));
    return arrDup;
};

// spread
// rest


console.log(deepDup([1, 2, 3, 4])) 
// [1,2,3,4]

let arr = [4, 5, 6, 7]
console.log(deepDup(arr)) 
// [4, 5, 6, 7]

/////////////////////////////////////////////////////////

console.log("6")

function bsearch(array, target) {

    let start = 0;
    let end = array.length - 1;

    while (start <= end) {
        // find the middle element using array's length
        let middle_index = Math.floor((start + end) / 2);

        // compare against the target
        if (array[middle_index] === target) {
            // if the mid IS the target: 
            // return mid
            return middle_index;
        } 
        else if (array[middle_index] < target) {
            start = middle_index + 1;
        }
        else {
            end = mid - 1;
        }
    };

    return -1;

};

// let array = [4,7,9]
// let target = 9
// console.log(bsearch(array, target))
// should be index 2


/////////////////////////////////////////////////////////
console.log("7")

function mergesort(array){
    // write a merge helper method
        // it will take two sides and sort them
    // this function will call merge on two mergesorted left and right sides (inductive step)

    // divide the input array until you get the individual elements
    // recombine each inductive step elements, at each side, together again, sorted

    let left = array.slice(0, array.length / 2)
    let middle_index = 
    let right = array.slice()

    // Math.floor : rounds down
    // trunc : rounds normally
    // Math.ceiling : rounds up
}

let array = [4, 43, 3, -1, 0, 55]
console.log(mergesort(array))
// -1, 0, 3, 4, 43, 55
