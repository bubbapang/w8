
// function test(){
//     return "hello world"
// }

// console.log(test())

///////////////////////////////////////////////////////////////////////////////

// clock

// class Clock {
//     // like instance variables
//     constructor() {

//         // 1. Create a Date object.
//         const date = new Date();

//         // 2. Store the hours, minutes, and seconds.

//         // hours
//         this.hours = date.getHours();

//         // minutes = 
//         this.minutes = date.getMinutes();

//         // seconds
//         this.seconds = date.getSeconds();

//         // 3. Call printTime.
//         this.printTime();

//         // 4. Schedule the tick at 1 second intervals.
//         setInterval(this._tick.bind(this), 1000)
//     }
    
//     // like instance methods
//     printTime() {
//         // Format the time in HH:MM:SS
//         let combinedTime = `${this.hours}:${this.minutes}:${this.seconds}`
//         // Use console.log to print it.
//         console.log(combinedTime)
//     }

//     _tick() {
//         // seconds
//         if (this.seconds < 59) {
//             // 1. Increment the time by one second.
//             this.seconds++;
//         } else {
//             // when seconds reaches 60
//             this.minutes++;
//             this.seconds = 0;
//         }

//         // minutes
//         if (this.minutes < 59) {
//         } else {
//             // when minutes reaches 60
//             this.hours++;
//             this.minutes = 0;
//         }

//         // hours
//         if (this.hours < 23) {
//         } else {
//             // when hours reaches 24
//             this.hours = 0;
//         }

//         // 2. Call printTime.
//         this.printTime();
//     }
// };

// const clock = new Clock();







///////////////////////////////////////////////////////////////////////////////

// const readline = require('readline');
// const reader = readline.createInterface({
//     input: process.stdin, 
//     output: process.stdout
// });

// function addNumbers(sum, numsLeft, completionCallback){

//     if (numsLeft > 0){ // if the reader still has more questions to ask
//         reader.question('Enter a number: ', (number) => {
//             sum += parseInt(number);
//             console.log(`Partial Sum: ${sum}`);
//             addNumbers(sum, numsLeft - 1, completionCallback);
//         })
//     } else {
//         completionCallback(sum)
//         reader.close();
//     }
// };

// addNumbers(0, 3, sum => console.log(`Total Sum: ${sum}`)); //should equal the sum of all 3 numbers you type

// class inheritance
// my bind
// my call
// my apply


// class Cat {
//     constructor(name) {
//         this.name = name;
//     }

//     says(sound, person) {
//         console.log(`${this.name} says ${sound} to ${person}!`);
//     }
// }

// class Dog {
//     constructor(name) {
//         this.name = name;
//     }
// }

// const markov = new Cat("Markov");
// const pavlov = new Dog("Pavlov");

// console.log(markov.says.bind(pavlov))


// markov.says("meow", "Ned");
// Markov says meow to Ned!

// markov.says.bind(pavlov)("meow", "Chris")

// markov is a cat
// all cats have the "says" function
// were binding pavlov's context to the "says" function
// then were invoking the "says" function with the arguments it wants


// ///////////////////////////////////////////////////////////////////////

// const gustavo = new Cat("gustavo");
// gustavo.meow.myBind(bob) // bob is a dog
// // bob meowed!




// myBind, myCall, myApply

// Object
// objects
// primitive

// Function.prototype.myBind = function(){















Function.prototype.myBind = function(context) {
    const that = this;
    return function(){
        that.apply(context);
    }
};


class Lamp {
    constructor() {
        this.name = "a lamp";
    }
}

const turnOn = function() {
    console.log("Turning on " + this.name);
};

const lamp = new Lamp();


const boundTurnOn = turnOn.bind(lamp);
const myBoundTurnOn = turnOn.myBind(lamp);

turnOn(); // should not work the way we want it to
boundTurnOn(); // should say "Turning on a lamp"
myBoundTurnOn(); // should say "Turning on a lamp"

