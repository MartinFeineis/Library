## Filter Helper
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

## Find Helper
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

<!-- parStr.reduce((prev, paStr) => {
    if ( paStr.toArray().filter(char) ={ return char === "\(")} ){
        prev += 1
    } else {
        prev -= 1
    }
    return prev

}, 0) -->
