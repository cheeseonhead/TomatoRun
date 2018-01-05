function test(woodHeight, woodRope, spiderHeight, spiderRope, length) {
    var level = {
        "wooden_boards": getObjects(pair(woodHeight, woodRope)),
        "spiders": getObjects(pair(spiderHeight, spiderRope)),
        "length": length
    }

    function pair(lista, listb) {

        var result = [];

        for (var i=0; i<lista.length; i++) {
            result.push([lista[i], listb[i]])
        }

        return result;
    }

    function getObjects(infoList) {
        return infoList.reduce(function(acc, curVal) {
            console.log("ACC" + acc)
            return acc.concat([{
                "height_ratio": curVal[0],
                "rope": curVal[1]
            }])
        }, [])
    }

    return JSON.stringify(level)
}
