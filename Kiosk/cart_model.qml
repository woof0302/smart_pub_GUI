pragma Singleton
import QtQuick 2.15

QtObject {
    // 얼음, 시럽, 레몬
    property var allQuantities: {
        "blue_lagoon": [1, 1, 1],
        "magarita": [1, 1, 1],
        "mojito": [1, 1, 1],
        "negroni": [1, 1, 1],
        "rum_punch": [1, 1, 1]
    }

    signal dataChanged()

    function getQuantity(menu, index){
        if(!allQuantities[menu]) return 0
        return allQuantities[menu][index]
    }

    function getQuantities(menuName) {
        return allQuantities[menuName] || [0, 0, 0]
    }

    function increase(menuName, index) {
        if (!allQuantities[menuName]) allQuantities[menuName] = [0, 0, 0]
        allQuantities[menuName][index]++
        dataChanged()
    }

    function decrease(menuName, index) {
        if (!allQuantities[menuName]) allQuantities[menuName] = [0, 0, 0]
        if (allQuantities[menuName][index] > 0)
            allQuantities[menuName][index]--
        dataChanged()
    }


    function printQuantities() {
        console.log(JSON.stringify(allQuantities))
    }
}
