console.log("phase 2")
console.log("1")

function cb(ele){
    console.log(ele)
}

Array.prototype.myEach = function(callback){
    
    for (let idx = 0; idx < this.length; idx++) {
        callback(this[idx]);
    };

};

console.log([1, 2, 3, 4, 5].myEach(cb));

/////////////////////////////////////////////////////////

// like proc.new {|num| num * 2}
function cb(num){
    return num * 2;
};

console.log("2")
Array.prototype.myMap = function(callback){

    // initializing empty array
    let map_arr = [];
    
    // iterating over the Array object
    this.myEach(ele => {
            map_arr.push(callback(ele));
        }
    );

    // return the map_arr
    return map_arr;
};

console.log([1,2,3].myMap(cb))
// [2, 4, 6]

/////////////////////////////////////////////////////////

console.log("3")


Array.prototype.myReduce = function(callback, initialValue = 0){
    // setting a function-scope variable from the parameter: initialValue
    let accumulator = initialValue;
    
    // iterating over the Array, for each ele, setting the above accumulator equal
    // to the parameter callback function, with the previous accumulator, 
    // with each step accumulating the ele on top of it, 
    // based on how they setup their callback function
    this.myEach(function(ele){
        accumulator = callback(accumulator, ele)
        }
    );
    return accumulator; //returning the final accumulator value
}

console.log([1, 2, 3].myReduce(function(acc, el) {return acc + el;})); 
// => 6 (0 + 1 + 2 + 3)

console.log([1, 2, 3].myReduce(function(acc, el) {return acc + el;}, 25)); 
// => 31 (25 + 6)