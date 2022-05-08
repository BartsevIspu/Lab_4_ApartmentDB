import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    visible: true
    width: 800
    height: 550
    title: qsTr("Каталог риелтора")

    // объявляется системная палитра
    SystemPalette {
          id: palette;
          colorGroup: SystemPalette.Active
       }

    Rectangle{
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btnAdd.top
        anchors.bottomMargin: 8
        border.color: "gray"
    ScrollView {
        anchors.fill: parent
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 15
        //flickableItem.interactive: true  // сохранять свойство "быть выделенным" при потере фокуса мыши
        Text {
            anchors.fill: parent
            text: "Could not connect to SQL"
            color: "red"
            font.pointSize: 20
            font.bold: true
            visible: IsConnectionOpen === false
        }
        ListView {
            id: apList
            anchors.fill: parent
            model: apartmentModel // назначение модели, данные которой отображаются списком
            delegate: DelegateForAp{}
            clip: true //
            activeFocusOnTab: true  // реагирование на перемещение между элементами ввода с помощью Tab
            focus: true  // элемент может получить фокус
            //opacity: {if (IsConnectionOpen === true) {100} else {0}}
        }
    }
   }

    Button {
        id: btnAdd
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.rightMargin: 8
        anchors.right:btnEdit.left
        text: "Добавить"
        width: 100

        onClicked: {
            windowAddEdit.currentIndex = -1
            windowAddEdit.show()
        }
    }

    Button {
        id: btnEdit
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right: btnDel.left
        anchors.rightMargin: 8
        text: "Редактировать"
        width: 100
        onClicked: {
            var districtA = apList.currentItem.apartmentData.districtOfAp
            var floorA = apList.currentItem.apartmentData.floorOfAp
            var roomA = apList.currentItem.apartmentData.roomOfAp
            var materialA = apList.currentItem.apartmentData.materialOfAp
            var areaR = apList.currentItem.apartmentData.areaOfAp
            var rID = apList.currentItem.apartmentData.Id_apartment

//            roles[Qt::UserRole + 2] = "districtOfAp";
//            roles[Qt::UserRole + 3] = "roomOfAp";
//            roles[Qt::UserRole + 4] = "floorOfAp";
//            roles[Qt::UserRole + 5] = "materialOfAp";
//            roles[Qt::UserRole + 6] = "areaOfAp";
//            roles[Qt::UserRole + 1] = "Id_apartment";

            windowAddEdit.execute(districtA, floorA, roomA, materialA, areaR, rID)
        }
    }

    Button {
        id: btnDel
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 8
        anchors.right:parent.right
        anchors.rightMargin: 8
        text: "Удалить"
        width: 100
        enabled: {
            if (apList.currentItem==null || apList.currentItem.apartmentData == null)
            {false}
            else
            {apList.currentItem.apartmentData.Id_apartment >= 0} }
        onClicked: del(apList.currentItem.apartmentData.Id_apartment)
    }

    DialogForAddorEdit {
        id: windowAddEdit
    }
}
