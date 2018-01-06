var testLevel = {
     "wooden_boards": [{
         "height_ratio": 0.1,
         "rope": 0
     }, {
         "height_ratio": 0.37,
         "rope": 0
     }, {
         "height_ratio": 0.57,
         "rope": 0
     }, {
         "height_ratio": 0.2,
         "rope": 1
     }, {
         "height_ratio": 0.43,
         "rope": 1
     }, {
         "height_ratio": 0.8,
         "rope": 1
     }, {
         "height_ratio": 0.05,
         "rope": 2
     }, {
         "height_ratio": 0.5,
         "rope": 2
     }],
     "spiders": [{
         "height_ratio": 0.22,
         "rope": 0
     }, {
         "height_ratio": 0.68,
         "rope": 0
     }, {
         "height_ratio": 0.91,
         "rope": 1
     }, {
         "height_ratio": 0.3,
         "rope": 2
     }, {
         "height_ratio": 0.7,
         "rope": 2
     }, {
         "height_ratio": 0.24,
         "rope": 3
     }, {
         "height_ratio": 0.76,
         "rope": 3
     }],
     "length": 1200
 };

var exampleIntersections = [
  [0, 0.15, "spider"],
  [0, 0.56, "wooden_board"]
];

var Entity = (function() {
  function Entity(rope, heightRatio) {
    this.rope = rope;
    this.heightRatio = heightRatio;
  }

  Entity.compare = function(a, b) {
    return a.rope - b.rope || a.heightRatio - b.heightRatio;
  };

  return Entity;
})();

function Intersection(rope, heightRatio, tag) {
  this.rope = rope;
  this.heightRatio = heightRatio;
  this.tag = tag;

  var neighbors = [];

  Intersection.prototype.addNeighbor = function(neighbor) {
    console.log("Pushed neighbor");
    neighbors.push(neighbor);
    console.log(neighbors);
  }

  Intersection.prototype.getNeighbors = function() {
    return [...neighbors];
  }
}

(function() {

  console.log("Array wrapped");

  Array.prototype.sorted = function(comparison) {
    return [...this].sort(comparison);
  };
})();

function nextIntersections(intersections, curInter) {
  var result = curInter.getNeighbors();

  var aboveInter = null;

  intersections.filter(function(intersection) {
    return intersection.rope == curInter.rope && intersection.heightRatio > curInter.heightRatio;
  }).forEach(function(intersection) {
       if(!aboveInter || intersection.heightRatio < aboveInter.heightRatio) {
      aboveInter = intersection;
    }
  });

  if(!aboveInter) {
    result.push(new Intersection(curInter.rope, curInter.heightRatio + 0.1, "freedom"));
  } else {
    result.push(aboveInter);
  }

  return result;
}

function makeIntersections(level) {

  var result = [];

  level.wooden_boards.forEach(function(board) {

    let leftInter = new Intersection(board.rope, board.height_ratio, "wooden_board");
    let rightInter = new Intersection(board.rope + 1, board.height_ratio, "wooden_board");

    leftInter.addNeighbor(rightInter);
    rightInter.addNeighbor(leftInter);

    result.push(leftInter);
    result.push(rightInter);
  });

  level.spiders.forEach(function(spider) {
    result.push(new Intersection(spider.rope, spider.height_ratio, "spider"));
  });

  result.sort(function(a, b) {
    return a.rope - b.rope === 0 ? a.heightRatio - b.heightRatio : a.rope - b.rope;
  });

  return result;
}

function verify(level) {

}

function testSuite() {
  (function() {
    let intersections = makeIntersections(testLevel);

    console.log(nextIntersections(intersections, intersections[1]));

    console.log([new Entity(1, 1.9), new Entity(1, 0), new Entity(0, 9)].sort(Entity.compare));
  })();
}

function wrap(obj, method, newFunction) {
  var oldFunction = obj[method];

  obj[method] = function() {
    return newFunction.apply(this, [oldFunction.bind(this),...Array.prototype.slice.call(arguments)]);
  }
}
