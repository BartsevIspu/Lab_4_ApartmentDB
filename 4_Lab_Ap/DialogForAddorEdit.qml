import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5   // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Добавление информации о квартире")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
            text: qsTr("Район города:")
        }
        TextField {
            id: textDistrict
            Layout.fillWidth: true
            placeholderText: qsTr("Введите район")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Кол-во комнат:")
        }
        TextField {
            id: textRoom
            Layout.fillWidth: true
            placeholderText: qsTr("Введите число комнат")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Этаж:")
        }
        TextField {
            id: textFloor
            Layout.fillWidth: true
            placeholderText: qsTr("Введите номер этажа")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Материал стен:")
        }
        TextField {
            id: textMaterial
            Layout.fillWidth: true
            placeholderText: qsTr("Введите материал стен")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Площадь:")
        }
        TextField {
            id: textArea
            Layout.fillWidth: true
            placeholderText: qsTr("Введите площадь")
        }
    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textDistrict.text, textRoom.text, textFloor.text, textMaterial.text, textArea.text)
            }
            else
            {
                edit(textDistrict.text, textRoom.text, textFloor.text, textMaterial.text, textArea.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    // изменение статуса видимости окна диалога
    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textDistrict.text = ""
          textRoom.text = ""
          textFloor.text = ""
          textMaterial.text = ""
          textArea.text = ""
      }
    }

    function execute(district, room, floor, material, area, index){
            textDistrict.text = district
            textRoom.text = room
            textFloor.text = floor
            textMaterial.text = material
            textArea.text = area
            root.currentIndex = index

            root.show()
        }
 }
