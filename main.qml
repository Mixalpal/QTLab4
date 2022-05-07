import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2


Window {
    visible: true
    width: 720
    height: 480
    title: qsTr("Каталог кафе")

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
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn

        Text {
            anchors.fill: parent
            text: "Could not connect to SQL"
            color: "red"
            font.pointSize: 20
            font.bold: true
            visible: IsConnectionOpen === false
        }

        ListView {
            id: cafeList
            anchors.fill: parent
            model: cafeModel // назначение модели, данные которой отображаются списком
            delegate: DelegateForCafe{}
            clip: true //
            activeFocusOnTab: true  // реагирование на перемещение между элементами ввода с помощью Tab
            focus: true  // элемент может получить фокус
            opacity: {if (IsConnectionOpen === true) {100} else {0}}
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
            var nameCafe = cafeList.currentItem.cafeData.nameOfCafe
            var kitchenTypeCafe = cafeList.currentItem.cafeData.kitchenTypeOfCafe
            var addressCafe = cafeList.currentItem.cafeData.addressOfCafe
            var timeCafe = cafeList.currentItem.cafeData.timeOfCafe
            var index = cafeList.currentItem.cafeData.idOfCafe

            windowAddEdit.execute(nameCafe, addressCafe, kitchenTypeCafe, timeCafe, index)
        }
    }

    ComboBox
    {
        id: comboBoxKitchenType
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 3
        anchors.left:parent.left
        width: 120
        model: ["Японская", "Русская", "Итальянская", "Американская"]
    }

    Button {
           id: butCount
           // Устанавливаем расположение кнопки
           anchors.bottom: parent.bottom
           anchors.bottomMargin: 8
           anchors.left: comboBoxKitchenType.right
           anchors.leftMargin: 8

           text: "Подсчитать"

           width: 100

           onClicked: {
               windowAnswer.countCafes(comboBoxKitchenType.currentValue.toString())
           }
       }

       DialogCount {
           id: windowAnswer
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
            if (cafeList.currentItem == null || cafeList.currentItem.cafeData == null)
            { false }
            else
            { cafeList.currentItem.cafeData.idOfCafe >= 0 } }
        onClicked: del(cafeList.currentItem.cafeData.idOfCafe)
    }

    DialogForAddorEdit {
        id: windowAddEdit
    }


}
