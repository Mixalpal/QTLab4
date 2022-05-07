import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal
    title: qsTr("Информация о кафе")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 350
    maximumHeight: 350

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Название кафе:")
        }
        TextField {
            id: textName
            Layout.fillWidth: true
            placeholderText: qsTr("Введите название кафе")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Адрес кафе:")
        }
        TextField {
            id: textAddress
            Layout.fillWidth: true
            placeholderText: qsTr("Введите адрес кафе")
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Тип кухни:")
        }
        ComboBox
        {
            id: textKitchenType
            Layout.fillWidth: true
            model: ["Японская", "Русская", "Итальянская", "Американская"]
        }
        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Время работы:")
        }
        TextField {
            id: textTime
            Layout.fillWidth: true
            placeholderText: qsTr("Введите время работы")
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
                add(textName.text, textAddress.text, textKitchenType.currentValue, textTime.text)
            }
            else
            {
                edit(textName.text, textAddress.text, textKitchenType.currentValue, textTime.text, root.currentIndex)
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
          textName.text = ""
          textAddress.text = ""
          textKitchenType.currentIndex = 0
          textTime.text = ""
      }
    }

    function execute(name, address, kitchenTypeCafe, time, index){
        isEdit = true

        textName.text = name
        textAddress.text = address
        textKitchenType.currentIndex = textKitchenType.model.indexOf(kitchenTypeCafe)
        textTime.text = time

        root.currentIndex = index

        root.show()
    }
 }

