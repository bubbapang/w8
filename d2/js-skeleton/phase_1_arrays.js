console.log("phase 1")
console.log("1")
Array.prototype.uniq = function() {
    
    let uniq_arr = new Array();

    this.forEach(ele => {
        if (!uniq_arr.includes(ele))  {
            uniq_arr.push(ele);
        }
    });

    return uniq_arr;
    
};

console.log([1,2,2,3,3,3].uniq()) 
//[1,2,3]

/////////////////////////////////////////////////////////
console.log("2")
Array.prototype.twoSum = function(){

    let two_sum_arr = new Array();
    
    for (let i = 0; i < this.length - 1; i++) {
        for (let j = i + 1; j < this.length; j++) {
            if (this[i] + this[j] === 0) {
                two_sum_arr.push([i, j]);
            }
        };
    };
    
    return two_sum_arr;
    
};

console.log([1,-2,2,3,-3,3,-1].twoSum());
//[[0, 6], [1, 2], [3, 4], [4, 5]]

/////////////////////////////////////////////////////////
console.log("3")
Array.prototype.transpose = function(){
    
    let transposed_arr = new Array();
    
    for (let row = 0; row < this.length; row++) {
        let temp_arr = [];
        for (let col = 0; col < this[row].length; col++) {
            temp_arr.push(this[col][row]);
        };

        transposed_arr.push(temp_arr);
        temp_arr = []; 
    };

    return transposed_arr;
    
};

console.log(
    [
    [1,2,3],
    [4,5,6],
    [7,8,9]
    ].transpose()
    );
//[[1,4,7],[2,5,8],[3,6,9]]


