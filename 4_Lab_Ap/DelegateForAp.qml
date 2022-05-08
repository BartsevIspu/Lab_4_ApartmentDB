
import QtQuick 6.0
import QtQuick.Controls 6.0  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 6.0

Rectangle {
    id: apItem
    readonly property color evenBackgroundColor: "#98FB98"      // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#BDECB6"       // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#34C924"  // цвет выделенного элемента списка

    property bool isCurrent: apItem.ListView.view.currentIndex === index    // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: apItemMouseArea.containsMouse || isCurrent      // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant apartmentData: model                                   // свойство для доступа к данным о конкретной квартире

    width: parent ? parent.width : apList.width
    height: 160

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            // как реагировать, если состояние стало selected
            PropertyChanges { target: apItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                                  и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: apItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: apItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            apItem.ListView.view.currentIndex = index
            apItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfApartments
        width: parent.width
        height: 160
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t0
                anchors.horizontalCenter: parent.horizontalCenter
                text: "ID:"
                color: "Black"
                font.pointSize: 12
                 }
            Text {
                id: textid
                anchors.horizontalCenter: parent.horizontalCenter
                text: Id_apartment
                color: "Black"
                font.pointSize: 18
                font.bold: true
                 }
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Район города:"
                color: "Black"
                font.pointSize: 12
            }
            Text {
                id: textDistrict
                anchors.horizontalCenter: parent.horizontalCenter
                text: districtOfAp
                color: "Black"
                font.pointSize: 18
                font.bold: true
            }
        }
        Column{
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                text: "Кол-во комнат:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textRoom
                text: roomOfAp
                color: "Black"
                font.pointSize: 12
                font.bold: true
            }
            Text {
                text: "Этаж:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textFloor
                color: "Black"
                text: floorOfAp
                font.pointSize: 12
                font.bold: true
            }
            Text {
                text: "Материал стен:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textMaterial
                text: materialOfAp
                color: "Black"
                font.pointSize: 12
                font.bold: true
            }
            Text {
                text: "Площадь:"
                color: "Black"
                font.pointSize: 10
            }
            Text {
                id: textArea
                color: "Black"
                text: areaOfAp
                font.pointSize: 12
                font.bold: true
            }
        }

    }
}
