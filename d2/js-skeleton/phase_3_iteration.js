console.log("phase 3")
console.log("1")

Array.prototype.bubbleSort = function(){
    
    let sorted = false;
    
    while(!sorted) {
        sorted = true;
        
        // iterate over pairs
        for(let i = 0; i < this.length - 1; i++) {
            
            // if there's an unsorted pair
            if(this[i] > this[i + 1]) {
                [this[i], this[i + 1]] = [this[i + 1], this[i]];
                sorted = false;
            };
        };
    };
    // return the sorted array
    return this;
};

console.log([4,43,3,-1,0,55].bubbleSort())
// [-1,0,3,4,43,55]

/////////////////////////////////////////////////////////

console.log("2")
String.prototype.substrings = function(){
    let all_substrings = [];
    for (let start=0; start < this.length; start++) {
        for (let end=start; end < this.length; end++) {
            all_substrings.push(this.slice(start, end + 1));
        };
    };
    return all_substrings;
};

console.log("hello".substrings())



