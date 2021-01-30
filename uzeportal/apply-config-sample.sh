#!/bin/bash
# Pull in the helper functions for configuring BigBlueButton
source /etc/bigbluebutton/bbb-conf/apply-lib.sh

enableUFWRules
enableMultipleKurentos
echo "  - Setting camera defaults"
yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==low).bitrate' 50
yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==medium).bitrate' 100
yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==high).bitrate' 200
yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==hd).bitrate' 300

yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==low).default' true
yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==medium).default' false
yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==high).default' false
yq w -i $HTML5_CONFIG 'public.kurento.cameraProfiles.(id==hd).default' false

echo "Running three parallel Kurento media server"
enableMultipleKurentos

echo "Fix till 2.2.30 - https://github.com/bigbluebutton/bigbluebutton/issues/9667"
yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.media.sipjsHackViaWs true
sed -i 's/https/http/g'  /etc/bigbluebutton/nginx/sip.nginx 
sed -i 's/7443/5066/g'  /etc/bigbluebutton/nginx/sip.nginx 

echo "Oynatmada Telif Hakkını Ayarlama"
sed -i "s/defaultCopyright = .*/defaultCopyright = \'<p>uzeportal.com<\/p>\';/g" /var/bigbluebutton/playback/presentation/2.0/playback.js

#seetings.yml AYARLAR BAŞLIYOR
#--------------------------------------------------
echo "Chat Sesleri Aktif"
sed -i 's/audioChatNotification:.*/audioChatNotification: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set Client Title"
sed -i 's/clientTitle:.*/clientTitle: UzePortal/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set App Title"
sed -i 's/appName:.*/appName: UzePortal Uzaktan Egitim Sistemi/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set Copyright"
sed -i 's/copyright:.*/copyright: "©2019 UzePortal.Com"/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set Allow User Lookup"
sed -i 's/allowUserLookup:.*/allowUserLookup: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set enableNetworkInformation"
sed -i 's/enableNetworkInformation:.*/enableNetworkInformation: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set mirrorOwnWebcam"
sed -i 's/mirrorOwnWebcam:.*/mirrorOwnWebcam: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set chatAudioAlerts"
sed -i 's/chatAudioAlerts:.*/chatAudioAlerts: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set chatPushAlerts"
sed -i 's/chatPushAlerts:.*/chatPushAlerts: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set showHelpButton"
sed -i 's/showHelpButton:.*/showHelpButton: false/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set enableNetworkMonitoring"
sed -i 's/enableNetworkMonitoring:.*/enableNetworkMonitoring: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set showLineNumbers"
sed -i 's/showLineNumbers:.*/showLineNumbers: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set showChat"
sed -i 's/showChat:.*/showChat: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set relayOnlyOnReconnect"
sed -i 's/relayOnlyOnReconnect:.*/relayOnlyOnReconnect: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set restoreOnUpdate"
sed -i 's/restoreOnUpdate:.*/restoreOnUpdate: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set multiUserPenOnly"
sed -i 's/multiUserPenOnly:.*/multiUserPenOnly: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Set streamerLog"
sed -i 's/streamerLog:.*/streamerLog: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml


echo "Set Helplink"
sed -i 's/helpLink:.*/helpLink: https:\/\/uzeportal.com/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml



#bigbluebutton.properties AYARLAR BAŞLIYOR
#--------------------------------------------------

echo "Make the HTML5 client default"
sed -i 's/attendeesJoinViaHTML5Client=.*/attendeesJoinViaHTML5Client=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sed -i 's/moderatorsJoinViaHTML5Client=.*/moderatorsJoinViaHTML5Client=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Set Welcome message"
sed -i 's/defaultWelcomeMessage=.*/defaultWelcomeMessage=Merhaba,Uzaktan Egitim Canli Derse Hosgeldiniz./g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sed -i 's/defaultWelcomeMessageFooter=.*/defaultWelcomeMessageFooter=Daha fazla bilgi icin UzePortal.Com/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Set disableRecordingDefault"
sed -i 's/disableRecordingDefault=.*/disableRecordingDefault=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Set webcamsOnlyForModerator"
sed -i 's/webcamsOnlyForModerator=.*/webcamsOnlyForModerator=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Let Moderators unmute users"
sed -i 's/allowModsToUnmuteUsers=.*/allowModsToUnmuteUsers=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Set lockSettingsDisablePrivateChat"
sed -i 's/lockSettingsDisablePrivateChat=.*/lockSettingsDisablePrivateChat=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Set lockSettingsLockOnJoinConfigurable"
sed -i 's/lockSettingsLockOnJoinConfigurable=.*/lockSettingsLockOnJoinConfigurable=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Set endWhenNoModerator"
sed -i 's/endWhenNoModerator=.*/endWhenNoModerator=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Don't Mute the class on start"
sed -i 's/muteOnStart=.*/muteOnStart=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Saves meeting events even if the meeting is not recorded"
sed -i 's/keepEvents=.*/keepEvents=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

#echo "Set maximum users per class to 100"
#sed -i 's/defaultMaxUsers=.*/defaultMaxUsers=100/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

#echo "Disable public chat"
#sed -i 's/lockSettingsDisablePublicChat=.*/lockSettingsDisablePublicChat=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

#echo "Disable shared note"
#sed -i 's/lockSettingsDisableNote=.*/lockSettingsDisableNote=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

#echo "See other users in the Users list"
#sed -i 's/lockSettingsHideUserList=.*/lockSettingsHideUserList=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

#echo "Prevent viewers from sharing webcams"
#sed -i 's/lockSettingsDisableCam=.*/lockSettingsDisableCam=false/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Prevent users from joining classes from multiple devices"
sed -i 's/allowDuplicateExtUserid=.*/allowDuplicateExtUserid=false/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "Belirli bir süre sonra moderatör olmadığında canlı dersi sonlandırın. Öğrencilerin kafasını karıştırmasını engeller."
sed -i 's/endWhenNoModerator=.*/endWhenNoModerator=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties

echo "No listen only mode"
sed -i 's/listenOnlyMode:.*/listenOnlyMode: false/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

echo "Enable audio check otherwise may face audio issue"
sed -i 's/skipCheck:.*/skipCheck: false/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
