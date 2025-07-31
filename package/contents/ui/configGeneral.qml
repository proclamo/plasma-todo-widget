import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami

Kirigami.FormLayout {
    property alias cfg_todoData: todoDataField.text

    QQC2.TextField {
        id: todoDataField
        visible: false
    }

    Kirigami.Heading {
        text: i18n("TODO Widget Configuration")
        level: 4
    }

    QQC2.Label {
        text: i18n("Tasks are automatically saved.")
    }
}
