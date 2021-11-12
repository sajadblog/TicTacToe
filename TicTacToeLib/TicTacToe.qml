import QtQuick 2.15
import QtTest 1.15

Rectangle{
    id: root

    signal gameOver(int winner)
    signal gameRestarted()

    QtObject{
        id: internal

        property int dimention: 3
        property int itemCount: dimention * dimention

        property int cellSpacing: Theme.itemSpacing
        property int cellWidth: (root.width - (dimention - 1) * cellSpacing) / dimention
        property int cellHeight: (root.height - (dimention - 1) * cellSpacing) / dimention

        property var winnerSelection: []
        property int moveCount: 0

        function checkWinner(items, type)
        {
            if(items.length !== internal.dimention)   return false

            internal.winnerSelection = items
            root.gameOver(type)
            return true
        }

        function findWinner(index, type)
        {
            if(internal.dimention > internal.moveCount ) return

            var allItems = gridItem.children

            // vertical checker
            var matchCase = []
            for(var i = index % internal.dimention ; i < internal.itemCount ; i+= internal.dimention)
                if(allItems[i].type === type)
                    matchCase.push(i)
            if(internal.checkWinner(matchCase, type))    return

            // horizontal checker
            matchCase = []
            var startRowIndex = Math.floor(index / internal.dimention)*internal.dimention
            for(i = startRowIndex ; i < startRowIndex + internal.dimention ; i++)
                if(allItems[i].type === type)
                    matchCase.push(i)
            if(internal.checkWinner(matchCase, type))    return

            // diognal checker
            matchCase = []
            for(i = 0 ; i < internal.itemCount ; i+=internal.dimention + 1)
                if(allItems[i].type === type)
                    matchCase.push(i)
            if(internal.checkWinner(matchCase, type))    return

            matchCase = []
            for(i = internal.dimention - 1 ; i < internal.itemCount - 1 ; i+=internal.dimention - 1) // because there is a exeption(8 number) we iterate to 7
                if(allItems[i].type === type)
                    matchCase.push(i)
            if(internal.checkWinner(matchCase, type))    return
        }

        function nextAIMove()
        {
            if(internal.winnerSelection.length !== 0) return ;

            var allItems = gridItem.children

            // just a simple next move Finder
            // search across columns
            var nextMove = -1
            for(var columnIndex = 0 ; columnIndex < internal.dimention ; columnIndex++)
            {
                for(var i = columnIndex ; i < internal.itemCount ; i+= internal.dimention){
                    if(allItems[i].type === Cell.Type.Cross){
                        nextMove = -1
                        break
                    }
                    else if(allItems[i].type === Cell.Type.None)
                        nextMove = i
                }
                if(nextMove !== -1)    {
                    allItems[nextMove].setType(Cell.Type.Circle)
                    return
                }
            }

            // search across rows
            for(var rowIndex = 0 ; rowIndex < internal.itemCount ; rowIndex += internal.dimention)
            {
                for(i = rowIndex ; i < rowIndex + internal.dimention ; i++){
                    if(allItems[i].type === Cell.Type.Cross){
                        nextMove = -1
                        break
                    }
                    else if(allItems[i].type === Cell.Type.None)
                        nextMove = i
                }
                if(nextMove !== -1)    {
                    allItems[nextMove].setType(Cell.Type.Circle)
                    return
                }
            }

            // just search for free Cell
            for(var cellIndex = 0 ; cellIndex < internal.itemCount ; cellIndex++)
            {
                if(allItems[cellIndex].type === Cell.Type.None)
                {
                    allItems[cellIndex].setType(Cell.Type.Circle)
                    return
                }
            }
            root.gameOver(Cell.Type.None)
        }
    }

    color: Theme.backgroundColor

    Grid{
        id: gridItem
        anchors.fill: parent
        columns: internal.dimention
        spacing: internal.cellSpacing
        Repeater {
            model : internal.itemCount
            delegate: Cell {
                width: internal.cellWidth
                height: internal.cellHeight
                color: (internal.winnerSelection[0] === index ||
                        internal.winnerSelection[1] === index ||
                        internal.winnerSelection[2] === index) ? Theme.winColor : "transparent"
                enabled: internal.winnerSelection.length === 0
                onClicked : {
                    setType(Cell.Type.Cross)
                    internal.nextAIMove()
                }
                Connections{
                    target: root
                    function onGameRestarted(){type = Cell.Type.None}
                }

                function setType(_type)
                {
                    type = _type
                    internal.moveCount++
                    internal.findWinner(index, type)
                }
            }
        }
    }
    function restartGame()
    {
        internal.winnerSelection = []
        internal.moveCount = 0
        root.gameRestarted()
    }

}
