import QtQuick 6.0
import QtQuick.Window 6.0
import QtQuick.Controls 6.0
import QtQuick.Layouts 6.0


Window {
    id: root
    modality: Qt.ApplicationModal
    title: qsTr("Ответ")
    width: 220
    height: 50

    GridLayout {
        anchors { left: parent.left;
                  top: parent.top;
                  right: parent.right;
                  margins: 10 }
        columns: 2

        Label {
            Layout.alignment: Qt.AlignRight
            text: qsTr("Получившийся результат:")
        }
        Label {
            id: textCount
            Layout.fillWidth: true
            text: "0"
        }

    }

    function countCafes(kitchenType){
        textCount.text = count(kitchenType);
        root.show()
    }
 }
