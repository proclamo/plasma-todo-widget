import QtQuick
import QtQuick.Layouts
import QtQuick.Controls as QQC2
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    width: Kirigami.Units.gridUnit * 15
    height: Kirigami.Units.gridUnit * 15

    property var todoItems: []

    property var taskText: ""

    fullRepresentation: ColumnLayout {
        anchors.fill: parent
        anchors.margins: Kirigami.Units.smallSpacing

        Kirigami.Heading {
            text: "TODO List"
            level: 3
            Layout.alignment: Qt.AlignHCenter
        }

        RowLayout {
            Layout.fillWidth: true

            PlasmaComponents.TextField {
                id: newTaskField
                Layout.fillWidth: true
                placeholderText: "Enter new task..."
                //onAccepted: addTask()
                onTextChanged: taskText = text;
            }

            PlasmaComponents.Button {
                text: "Add"
                onClicked: addTask()
            }
        }

        QQC2.ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            ListView {
                id: todoListView
                model: root.todoItems

                delegate: Item {
                    width: ListView.view.width
                    height: Kirigami.Units.gridUnit * 2

                    Rectangle {
                        anchors.fill: parent
                        color: index % 2 === 0 ? "transparent" : Kirigami.Theme.alternateBackgroundColor
                        opacity: 0.3

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: Kirigami.Units.smallSpacing

                            QQC2.CheckBox {
                                checked: modelData.completed || false
                                onToggled: toggleTask(index)
                            }

                            PlasmaComponents.Label {
                                Layout.fillWidth: true
                                text: modelData.text || ""
                                font.strikeout: modelData.completed || false
                                opacity: modelData.completed ? 0.6 : 1.0
                                color: Kirigami.Theme.textColor
                            }

                            PlasmaComponents.Button {
                                text: "×"
                                implicitWidth: Kirigami.Units.gridUnit * 1.5
                                onClicked: removeTask(index)
                            }
                        }
                    }
                }
            }
        }


        function addTask() {
            if (taskText.trim() !== "") {
                var newTasks = todoItems.slice(); // Create a copy
                newTasks.push({
                    text: taskText.trim(),
                            completed: false
                });
                todoItems = newTasks;
                taskText = "";
                newTaskField.text = "";
                saveTasks();
            }
        }

        function toggleTask(index) {
            var newTasks = todoItems.slice(); // Create a copy
            newTasks[index].completed = !newTasks[index].completed;
            todoItems = newTasks;
            saveTasks();
        }

        function removeTask(index) {
            var newTasks = todoItems.slice(); // Create a copy
            newTasks.splice(index, 1);
            todoItems = newTasks;
            saveTasks();
        }

        function saveTasks() {
            Plasmoid.configuration.todoData = JSON.stringify(todoItems);
        }

        function loadTasks() {
            try {
                const saved = Plasmoid.configuration.todoData;
                if (saved) {
                    todoItems = JSON.parse(saved);
                }
            } catch (e) {
                console.log("Error loading tasks:", e);
                todoItems = [];
            }
        }


        Component.onCompleted: {
            loadTasks();
        }
    }
}
