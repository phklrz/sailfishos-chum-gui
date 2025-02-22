import QtQuick 2.0
import Sailfish.Silica 1.0
import org.chum 1.0
import "../components"

Page {
    id: page
    allowedOrientations: Orientation.All

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: content.height + Theme.paddingLarge

        Column {
            id: content
            spacing: Theme.paddingLarge
            width: parent.width

            PageHeader {
                //% "Settings"
                title: qsTrId("chum-settings-title")
            }

            SectionHeader {
                //% "Status"
                text: qsTrId("chum-settings-status")
            }

            Label {
                anchors {
                    left: parent.left
                    leftMargin: Theme.horizontalPageMargin
                    right: parent.right
                    rightMargin: Theme.horizontalPageMargin
                }
                color: Theme.highlightColor
                text: {
                    if (!Chum.repoManaged) {
                        //% "Chum repository management failed"
                        return qsTrId("chum-settings-status-repo-management-failed");
                    }
                    if (Chum.busy)
                        return Chum.status

                    if (!Chum.repoAvailable)
                        //% "Chum repository is not available"
                        return qsTrId("chum-settings-status-repo-not-available");

                    if (Chum.manualVersion)
                        return Chum.repoTesting ?
                                    //% "Following testing Chum repository with a manually set Sailfish OS version (%1)"
                                    qsTrId("chum-settings-status-repo-testing-manual").arg(Chum.manualVersion) :
                                    //% "Following regular Chum repository with a manually set Sailfish OS version (%1)"
                                    qsTrId("chum-settings-status-repo-regular-manual").arg(Chum.manualVersion)
                    return Chum.repoTesting ?
                                //% "Following testing Chum repository with an automatically determined Sailfish OS version"
                                qsTrId("chum-settings-status-repo-testing-auto") :
                                //% "Following regular Chum repository with an automatically determined Sailfish OS version"
                                qsTrId("chum-settings-status-repo-regular-auto");

                }
                wrapMode: Text.WordWrap
            }

            SectionHeader {
                //% "General"
                text: qsTrId("chum-settings-general")
            }

            TextSwitch {
                checked: Chum.showAppsByDefault
                //% "When listing available software, show only applications by default. This is a default setting and, in each listing, "
                //% "you can switch between showing only applications or all packages using pulley menu."
                description: qsTrId("chum-settings-show-apps-description")
                //% "Show applications only by default"
                text: qsTrId("chum-settings-show-apps")
                onClicked: Chum.showAppsByDefault = !Chum.showAppsByDefault
            }

            TextSwitch {
                automaticCheck: false
                busy: Chum.busy
                checked: Chum.repoTesting
                //% "Use testing version of Chum repository. This is mainly useful for developers "
                //% "for testing their packages before publishing."
                description: qsTrId("chum-settings-testing-description")
                //% "Use testing repository"
                text: qsTrId("chum-settings-testing")
                onClicked: Chum.repoTesting = !Chum.repoTesting;
            }

            SectionHeader {
                //% "Advanced"
                text: qsTrId("chum-settings-advanced")
            }

            Label {
                anchors {
                    left: parent.left
                    leftMargin: Theme.horizontalPageMargin
                    right: parent.right
                    rightMargin: Theme.horizontalPageMargin
                }
                color: Theme.highlightColor
                //% "Override Chum repository selection"
                text: qsTrId("chum-settings-override-selection")
            }

            TextField {
                id: txtRelease
                anchors {
                    left: parent.left
                    leftMargin: Theme.horizontalPageMargin
                    right: parent.right
                    rightMargin: Theme.horizontalPageMargin
                }
                //% "Usually, selected Chum repository is automatically set to your Sailfish OS version. "
                //% "To follow Chum repository for specific Sailfish OS release, "
                //% "specify Sailfish OS release here (for example, 4.3.0.12). This is useful "
                //% "when Chum repository is not available for your Sailfish OS version, as for "
                //% "Cbeta users."
                description: qsTrId("chum-setings-override-release-description")
                //% "Specify Sailfish version
                placeholderText: qsTrId("chum-setings-override-release-placeholder")
                text: Chum.manualVersion
                EnterKey.enabled: true
                EnterKey.onClicked: {
                    console.log("Setting release to ", txtRelease.text);
                    Chum.manualVersion = txtRelease.text;
                    focus = false
                }
            }
        }
    }
}
