onmessage = function (event) {
  var n = event.data;
  for (var i=1; i <=n; i++) {
    for (var j=1; j<=50000; j++)
      for (var k=1; k<=50000; k++);
    postMessage(i);
  }
}