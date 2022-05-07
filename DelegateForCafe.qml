import QtQuick 2.6
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2

Rectangle {
    id: cafeItem
    readonly property color evenBackgroundColor: "#f9f9f9"  // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#ffffff"   // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#eaf1f7"  // цвет выделенного элемента списка

    property bool isCurrent: cafeItem.ListView.view.currentIndex === index   // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: cafeItemMouseArea.containsMouse || isCurrent // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant cafeData: model // свойство для доступа к данным конкретного кафе

    width: parent ? parent.width : cafeList.width
    height: 150

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            PropertyChanges { target: cafeItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                           и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: cafeItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: cafeItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            cafeItem.ListView.view.currentIndex = index
            cafeItem.forceActiveFocus()
        }
    }
    Item {
        id: itemOfCafes
        width: parent.width
        height: 150
        Column{
            id: t2
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 240
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: t1
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Название кафе:"
                color: "firebrick"
                font.pointSize: 12
            }
            Text {
                id: textName
                anchors.horizontalCenter: parent.horizontalCenter
                text: nameOfCafe
                color: "red"
                font.pointSize: 18
                font.bold: true
            }
        }

        Column{
            anchors.left: t2.right
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            Text {
                text: "Адрес:"
                color: "firebrick"
                font.pointSize: 8
            }
            Text {
                id: textAddress
                text: addressOfCafe
                color: "purple"
                font.pointSize: 8
            }
            Text {
                text: "Тип кухни:"
                color: "firebrick"
                font.pointSize: 8
            }
            Text {
                id: textkitchenType
                color: "purple"
                text: kitchenTypeOfCafe
                font.pointSize: 8
            }
            Text {
                text: "Время работы:"
                color: "firebrick"
                font.pointSize: 8
            }
            Text {
                id: textTime
                color: "purple"
                text: timeOfCafe
                font.pointSize: 8
            }
        }
    }
}
