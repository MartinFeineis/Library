# Javascript on ES6
Udemy course [ES6 Javascript Development from scratch. Get practice with live examples and learn exactly where to apply ES6 features.](https://www.udemy.com/course/javascript-es6-tutorial)
## Array Helpers

### For Each

### Map Helper
![Map-Helper](https://media.404founders.com/Map-Helper.png)
### Filter Helper
![Filter-Helper](https://media.404founders.com/Filter-Helper.png)
```
function reject(array, iteratorFunction) {
    console.log(iteratorFunction)
    let permarr = array.filter(iteratorFunction)
    console.log(permarr + " permarr " + Array.isArray(permarr))
    console.log(array + " array " + Array.isArray(array))
    let retarr = array.filter((element) => { return !(permarr.includes(element)) })
    console.log(retarr+ " retar")
  return array.filter((vele) => { return !(permarr.includes(vele)) })
}
```

### Find Helper
![Find-Helper](https://media.404founders.com/Find-Helper.png)
```
var ladders = [
  { id: 1, height: 20 },
  { id: 3, height: 25 }
];

function findWhere(array, criteria) {
    console.log(Object.keys(criteria) + " criteria keys");
    console.log(Object.values(criteria) + " criteria values");
  return array.find(arr => { 
    console.log(typeof(arr[(Object.keys(criteria))]) + " # " + Number(Object.values(criteria)));
    console.log(arr[(Object.keys(criteria))] === Number(Object.values(criteria)))
    return arr[(Object.keys(criteria))] === Number(Object.values(criteria)) })
}

console.log(findWhere(ladders, { height: 25 })); 
```

function balancedParens(prev, parStr) {


}


### Every and Some Helper
Every returns a boolean for every element evaluated and compared with AND
![Every-Helper](https://media.404founders.com/Every-Helper.png)  
Some returns a boolean comparing every element with OR  
![Some-Helper](https://media.404founders.com/Some-Helper.png)


### Reduce Helper
<!-- parStr.reduce((prev, paStr) => {
    if ( paStr.toArray().filter(char) ={ return char === "\(")} ){
        prev += 1
    } else {
        prev -= 1
    }
    return prev

}, 0) -->
