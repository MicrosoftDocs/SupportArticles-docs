---
title: Known issues for managing Group Policy clients
description: Describes known issues that occur when you manage a Windows 10 Group Policy Client from a Windows Server 2012 R2 server.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-computer-group-and-object-management, csstroubleshoot
---
# Known issues managing a Windows 10 Group Policy client in Windows Server 2012 R2

_Applies to:_ &nbsp; Window 10 - all editions, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4015786

## Summary

When you manage a Windows 10 Group policy client base from a Windows Server 2012 R2 server, some known challenges can occur. The same challenges apply to using the Advanced Group Policy Management server (AGPM) on a Windows Server 2012 R2 server when you manage Windows 10 clients.

This article is separated into sections for each subsequent upgrade as they were released. It also indicates when a change affects only a specific build of the Group Policy ADMX template files.

The following list of changes doesn't include the many new additional settings that are added to each template file. They don't have any effect if they're added to an existing deployment. The existing deployment doesn't use those settings. So, it's unlikely to affect the environment.

It's also important to consider that during the GPMC startup, the console caches the ADMX files into memory. Any changes to the templates that occur while the tool is open don't appear, even after a report refresh. After the tool is shut down and then reopened, it will get the new ADMX files from the PolicyDefinitions folder.

## More information

Traditionally, the method of translating group policy settings into a user interface that could be easily managed was provided by ADM files. These files use their own markup language. They were locale-specific. So, they were difficult to manage for multinational companies.

Windows Vista and Windows Server 2008 introduced a new method of displaying settings within the Group Policy Management Console. Registry-based policy settings are defined as using a standards-based, XML file format known as ADMX, more commonly known as administrative templates. These settings are located under the Administrative Templates category in the Group Policy Object Editor.

Group Policy Object Editor and Group Policy Management Console remain largely unchanged. In most situations, you don't notice the presence of ADMX files during your daily Group Policy administration tasks.

In some situations, you need to understand:

- how ADMX files are structured
- the location where they're stored

ADMX files provide an XML-based structure. This structure is used for defining the display of the Administrative Template policy settings in the Group Policy tools. The Group Policy tools recognize ADMX files only if you're using a computer that is running Windows Vista or Windows Server 2008 or later versions.

Unlike ADM files, ADMX files aren't stored in individual GPOs. For domain-based enterprises, administrators can create a central store location of ADMX files. And this location is accessible by anyone who has permission to create or edit GPOs. Group Policy tools continue to recognize any custom ADM files in your existing environment. But they will ignore any ADM file that has been superseded by an ADMX file, such as:

- System.adm
- Inetres.adm
- Conf.adm
- Wmplayer.adm
- Wuau.adm

If you've edited any of these files to change or create policy settings, the changed or new settings aren't read or displayed by the Windows Vista-based Group Policy tools.

The Group Policy Object Editor automatically reads and displays Administrative Template policy settings from ADMX files that are stored locally or in the optional ADMX central store. The Group Policy Object Editor automatically reads and displays Administrative Template policy settings from custom ADM files that are stored in the GPO. You can still add or remove custom ADM files by using the Add/Remove template menu option. All Group Policy settings currently in ADM files that are delivered by Windows Server 2003, Windows XP, and Windows 2000 are also available in Windows Vista and Windows Server 2008 ADMX files.

It can be challenging to upgrade the PolicyDefinitions folder that has later revisions of the ADMX files. The reason is that some settings are deprecated and some are added. Typically, adding settings has a minimal effect. However, deprecating settings often causes pre-configured Group Policies to keep settings that can no longer be changed. Commonly, those types of redundant settings from the new ADMX files are listed as Extra Registry Settings in the settings report. These settings are still applied to production, but the administrator can no longer turn them on or off.

To manage this situation, an administrator could delete the Group policy, if it's no longer required. Or, they could copy the legacy ADMX template back to the PolicyDefinitions folder. It would enable the setting to be managed again. But the new settings from the later revision ADMX template are lost.

## Known ADMX file content change issues in Windows 10 build 1607

|Filename|Change|Possible effect|
|---|---|---|
| DataCollection.admx| Changed Policy setting `Allow Telemetry` class value from **Machine** to **Both**| This ADMX first appeared in Windows 10 RTM and was set to Machine in both the RTM and 1511 revisions. In build 1607, the class changed to **Both**. It means that the setting was applicable to both the User and Machine sides of the registry. Because it's an extension of an existing setting, this change has no expected effect. |
| DeliveryOptimization.admx| Changed Policy setting **Download Mode** (DownloadMode) configuration item from **None** to **HTTP only**| This change is a display text change only. The underlying values are the same as for previous builds of the ADMX file. So, there's no effect on production group policies. |
| inetres.admx| Removed Policy setting **Show Content Advisor on Internet Options**| This setting was deprecated from the 1607 build of the ADMX file, which has been present pre-2012 and Windows 8. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| MicrosoftEdge.admx| The following 15 settings have had class changes from **Machine** to **Both**: <ul><li>Configure Autofill (AllowAutofill)</li><li>Allow Developer Tools (AllowDeveloperTools)</li><li>Configure don't Track (AllowDoNotTrack)</li><li>Allow InPrivate browsing (AllowInPrivate)</li><li>Configure Password Manager (AllowPasswordManager)</li><li>Configure Pop-up Blocker (AllowPopups)</li><li>Configure SmartScreen Filter (AllowSmartScreen)</li><li>Allow web content on New Tab page (AllowWebContentOnNewTabPage)</li><li>Configure cookies (Cookies)</li><li>Configure the Enterprise Mode Site List (EnterpriseModeSiteList)</li><li>Prevent using Localhost IP address for WebRTC (HideLocalHostIPAddress)</li><li>Configure Home pages (HomePages)</li><li>Prevent bypassing SmartScreen prompts for files (PreventSmartScreenPromptOverrideForFiles)</li><li>Configure Favorites (Favorites)</li><li>Send all intranet sites to Internet Explorer 11 (SendIntranetTraffictoInternetExplorer)</li></ul> | This ADMX first appeared in Windows 10 RTM, and was set to **Machine** in both the RTM and 1511 revisions. In build 1607, the class changed to Both. It means that the setting was applicable to both the User and Machine sides of the registry. Because it's an extension of an existing setting, this change has no expected effect. |
| WindowsDefender.admx| Removed Policy setting **Define the rate of detection events for logging**| This setting was deprecated from the ADMX file. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| WindowsDefender.admx| Removed Policy settings **IP address range Exclusions** and **Port number Exclusions**| This setting was deprecated from the ADMX file. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| WindowsDefender.admx| Removed Policy setting **Process Exclusions for outbound traffic**| This setting was deprecated from the ADMX file. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| WindowsDefender.admx| Removed Policy setting **Threat ID Exclusions**| This setting was deprecated from the ADMX file. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| WindowsDefender.admx:| Removed Policy setting **Turn on Information Protection Control**| This setting was deprecated from the ADMX file. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| WindowsDefender.admx| Removed Policy setting **Turn on network protection against exploits of known vulnerabilities**| This setting was deprecated from the ADMX file. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| WindowsDefender.admx| Changed Policy setting **Suppress all notifications** (UX_Configuration_Notification_Suppress) enabled and disabled value from enabledValue=0 and disabledValue=1 to enabledValue=1 and disabledValue=0| This change has occurred on build 1607 and differs from build 1511 and previous. The change enables this setting to work as expected, because to previously enable this setting, it had to be disabled. The impact for an upgrade is: if the setting was configured and the PolicyDefinitions were upgraded to 1607, then the setting would automatically revert to the opposite setting that was previously configured. <br/>See [Appendix 1 Windows Defender](#appendix-1-windows-defender) <br/>|
| WindowsDefender.admx| Removed Policy setting **Configure local setting override to turn off Intrusion Prevention System**| This setting was deprecated from the ADMX file. The setting remains configured under the following conditions: <ul><li>the setting had already been deployed into production</li><li>the ADMX file was upgraded</li></ul> But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| WindowsExplorer.admx| Changed Policy setting **Configure Windows SmartScreen** (EnableSmartScreen), replaced drop-down item to enabled/disabled configuration item.| This setting has changed in this version from previous versions, in particular the option to enable smart screen but Require approval from an administrator before running downloaded unknown software has been deprecated. If this setting was configured previously, it will become unmanageable after the ADMX upgrade. If this setting is enabled, but the smart screen was disabled, then the whole setting becomes disabled after the upgrade. <br/> See [Appendix 2 Windows Explorer](#appendix-2-windows-explorer) |
| WindowsUpdate.admx| Removed Policy setting **Defer Upgrades and Updates** (DeferUpgrade), replaced by more detailed Policy settings (`DeferFeatureUpdates`, `DeferQualityUpdates`, `ExcludeWUDriversInQualityUpdate`, `ActiveHours`)| The defer upgrade option was made available as per Windows 10 RTM and was changed on build 1607. Once the settings have been configured, and the `PolicyDefinitions` folder is upgraded to build 1607, the settings become unmanageable. The configured settings will remain configured. But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul> As the new DeferUpgrade settings are new to build 1607, it isn't expected to affect existing configurations. <br/>See [Appendix 3 Windows Update](#appendix-3-windows-update) |
  
## Known ADMX file content change issues in Windows 10 build 1511

| Filename| Change| Possible Effect |
|---|---|---|
| Explorer.admx| Removed Policy setting **Turn off soft landing help tips** (DisableSoftLanding)| This setting has been deprecated from the Window 10 RTM ADMX file and wasn't present in 2012 R2. If the setting had already been deployed into production and the ADMX was upgraded, the setting remains configured. But it can't be changed without using one of the following methods: <ul><li>using a custom ADMX</li><li>deleting the whole policy that stores the setting.</li></ul>|
| inetres.admx| Removed Policy setting **Prevent configuration of top-result search on Address bar** (TopResultPol) (computer/Windows Components/IE/Internet Settings/Advanced Settings/Searching)| This setting has been deprecated from the ADMX file. If the setting had already been deployed into production and the ADMX was upgraded, the setting remains configured. But it isn't changeable without either using a custom ADMX or deleting the whole policy that stores the setting. |
| LocationProviderAdm.admx| Deprecated Microsoft-Windows-Geolocation-WLPAdm.admx for the new filename LocationProviderAdm.admx| When you upgrade from Windows 10 RTM to Windows 10 version 1511, the new LocationProviderAdm.admx file is copied to the folder while keeping the old Microsoft-Windows-Geolocation-WLPAdm.admx file. So, there are two ADMX files that address the same policy namespace. This generating an error. See ["'Microsoft.Policies.Sensors.WindowsLocationProvider' is already defined" error when you edit a policy in Windows](https://support.microsoft.com/help/3077013)|
| MicrosoftEdge.admx| Removed Policy setting **Allows you to run scripts, like JavaScript** (AllowActiveScripting) (Computer)| This setting has been deprecated from the ADMX file. If the setting had already been deployed into production, and the ADMX was upgraded, the setting remains configured. But it won't be changeable without either using a custom ADMX or deleting the whole policy that stores the setting. |
| MicrosoftEdge.admx| The following nine settings have had class changes from **Both** to **Machine**: <ul><li>Turn off Autofill (AllowAutofill)</li></li>Allow employees to send don't Track headers (AllowDoNotTrack)</li></li>Turn off Password Manager (AllowPasswordManager)</li></li>Turn off Pop-up Blocker (AllowPopups)</li></li>Turn off address bar search suggestions (AllowSearchSuggestionsinAddressBar)</li></li>Turn off the SmartScreen Filter (AllowSmartScreen)</li></li>Configure Cookies (Cookies)</li></li>Configure the Enterprise Mode Site List (EnterpriseModeSiteList)</li></li>Send all intranet sites to Internet Explorer 11 (SendIntranetTraffictoInternetExplorer) | Change from **Both** to **Machine** means: <br/>&nbsp;&nbsp;&nbsp;a setting is descoped from being applicable to both the User and Machine sides of a policy to only the Machine side. <br/><br/>If the policy has already been configured in the User side, you can't change the user side settings again after the ADMX upgrade. However, the setting remains configured. |
| ParentalControls.admx| Was removed in this build of ADMX| When an ADMX is removed from the latest build of templates, all settings that may have been configured from previous versions of the file become stagnant. If the `PolicyDefinitions` folder is upgraded, the existing previous file is still present. So, there's no effect. The settings will still be present and functional if the following conditions are true: <ul><li>the content of the `PolicyDefinitions` folder is removed</li><li>the new templates are populated</li><li>some group policies are still configured by using the settings from parentalcontrols.ADMX</li></ul> However, they can't be reconfigured without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsStore.admx| Was added, that directly replaces WinStoreUI.admx (obtained from Windows 2012/8 RTM ADMX and wasn't present in 2012 R2/8.1)| The **EnableWindowsStoreOnWTG** setting in the key named `Software\Policies\Microsoft\WindowsStore` that has the value name of **EnableWindowsStoreOnWTG** is deprecated. It prevents the setting from being reconfigurable without either using a custom ADMX or deleting the whole policy that stores the setting. Also, the DisableAutoDownload setting value is changed from 3 (winStoreUI) to 4 (WindowsStore). It causes the original setting to be superseded and appear under extra registry settings. It also causes the original setting to become unchangeable. However, it will still be set. See [Appendix 4 WinStoreUI upgrade to WindowsStore](#appendix-4-winstoreui-upgrade-to-windowsstore). If both files are present at the same time, the GPMC fails to load. It's because the namespaces of both files are also duplicates. It causes the error while generating the settings `reportNamespace` 'Microsoft.Policies.WindowsStore' is already defined as the target namespace for another file in the store. File \\\\\<Domain Name>\SysVol\<DomainName>\Policies\PolicyDefinitions\WinStoreUI.admx, line 4, column 80 |
  
## Known ADMX file content change issues in Windows 10 RTM

| Filename| Change| Possible effect |
|---|---|---|
| AppXRuntime.admx| Changed Policy **Allow Microsoft accounts to be optional** class value change from **Both** to **Machine**| It means that a setting has been descoped from being applicable to both the User and Machine sides of a policy to just the Machine. If the policy has already been configured in the User side, you can't change the User side settings again after the ADMX upgrade. However, the setting remains configured. |
| ErrorReporting.admx| Removed Policy setting **Automatically send memory dumps for OS-generated error reports** (WerAutoApproveOSDumps_1 (User setting), WerAutoApproveOSDumps_2 (Machine setting))| If the ADMX is upgraded in place from the Windows Server 2012 R2 version, you can't change the settings again. The setting remains configured. However, you can't change it without either using a custom ADMX or deleting the whole policy that stores the setting. |
| ErrorReporting.admx| Removed Policy setting **Configure Default consent** (WerDefaultConsent_1 (User setting), WerDefaultConsent_2 (Machine setting))| Once the ErrorReporting.ADMX is replaced from the 2012 R2 revision to the Windows 10 RTM version, you see the following error: **Registry value DefaultConsent is of unexpected type.** To resolve this issue, remove the Group Policy, and rebuild the settings into a new policy using the new ADMX template. See [Appendix 5 Error reporting](#appendix-5-error-reporting) |
| inetres.admx| Removed Policy setting **Allow Internet Explorer to use the SPDY/3 network protocol**| This setting has been deprecated from the 2012 R2 ADMX file. If the setting had already been deployed into production and the ADMX was upgraded, the setting remains configured. However, you can't change it without either using a custom ADMX or deleting the whole policy that stores the setting. |
| NAPXPQec.admx| The ADMX file has been deprecated.| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file become stagnant. If the PolicyDefinitions folder has been upgraded, the existing previous file remains present. So, there's no effect. The settings remain present and functional if the following conditions are true: <ul><li>the content of the PolicyDefinitions folder has been removed</li><li>the new templates are populated</li><li>there are group policies still configured by using the settings from the NAPXPQec.ADMX</li></ul> But you can't reconfigure them without using one of the following methods: <ul><li>using a custom ADMX</li><li>reinserting the file from a backup</li><li>deleting the whole policy that stores the setting.</li></ul>|
| NetworkProjection.admx| The ADMX file has been deprecated.| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file becomes stagnant. If the PolicyDefinitions folder has been upgraded, then the existing previous file will still be present, so there will be no effect. The settings remain present and functional if the following conditions are true: <ul><li>the content of the PolicyDefinitions folder is removed</li><li>the new templates are populated</li><li>there are group policies still configured by using the settings from the NetworkProjection.ADMX</li></ul> But you can't reconfigure them without using one of the following methods: <ul><li>using a custom ADMX</li><li>reinserting the file from a backup</li><li>deleting the whole policy that stores the setting.</li></ul>|
| PswdSync.admx| This file was removed and now only delivered with Server Operating Systems only| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file will become stagnant. If the PolicyDefinitions folder has been upgraded, the existing previous file will remain present, so there will be no effect. The settings remain present and functional if the following conditions are true: <ul><li>the content of the PolicyDefinitions folder has been removed</li><li>the new templates are populated</li><li>there are group policies still configured by using the settings from the PswdSync.ADMX</li></ul> But you can't reconfigure them without using one of the following methods: <ul><li>using a custom ADMX</li><li>reinserting the file from a backup</li><li>reinserting the file from a server build</li><li>deleting the whole policy that stores the setting.</li></ul>|
| SkyDrive.admx| There are many changes to this file from 2012 R2 revision, but all change references from Skydrive to OneDrive, with relevant registry location changes also. Below are a few examples: <br/>1. Changed policyNamespace from "target prefix="skydrive" namespace="Microsoft.Policies.Skydrive"" to "target prefix="onedrive" namespace="Microsoft.Policies.OneDrive"" <br/>2. Changed category Skydrive to OneDrive <br/>3. Changed policy **Prevent the usage of OneDrive for file storage** to use the OneDrive registry key (`Software\Policies\Microsoft\Windows\OneDrive`) from the Skydrive registry key (`Software\Policies\Microsoft\Windows\Skydrive`) | After the Windows 10 RTM version of the Skydrive.admx replaces the 2012 R2 revision of the file, all control of Skydrive components is replaced with the OneDrive versions settings. If you're still using the Skydrive application, those settings will still apply. However, they'll be unmanageable without either using a custom ADMX or recovering the 2012 R2 version of the template. |
| Snis.admx| This file was removed and now only delivered with Server Operating Systems only| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file will become stagnant. If the PolicyDefinitions folder has been upgraded, the existing previous file will remain present. So, there's no effect. The settings remain present and functional if the following conditions are true: <ul><li>the content of the PolicyDefinitions folder is removed</li><li>the new templates are populated</li><li>there are group policies still configured by using the settings from the Snis.ADMX</li></ul> However, you can't reconfigure them without using one of the following methods: <ul><li>using a custom ADMX</li><li>reinserting the file from a backup</li><li>deleting the whole policy that stores the setting.</li></ul> |
| TerminalServer.admx| Changed Policy setting **Optimize visual experience when using RemoteFX** (TS_RemoteDesktopVirtualGraphics), removed typing error from **...ScreeenImageQuality...** to **...ScreenImageQuality...**| This setting has been changed internally and its name reference is only used to link the ADMX file to the ADML content. This change has no impact to the actual settings configured or the use of the settings in the policy. |
| WinStoreUI.admx| The ADMX file has been deprecated.| This file was removed from Windows 10 RTM. If the Microsoft Store was configured using Windows Server 2012 R2, these settings will become extra registry settings. The settings are still present and functional. But you can't reconfigure them without either using a custom ADMX or deleting the whole policy that stores the setting. Note: This file was replaced in Windows 10 build 1511 with the file WindowsStore.ADMX. Read the details of that file in the next section. |
  
## ADMX source file references

|Filename|Reference Build|Revision Number|Digital Signal Date|
|---|---|---|---|
| Windows8-Server2012ADMX-RTM.msi| RTM| {EEDEB0DE-8C60-4EB6-A04D-7B3C5E121D03}| ‎Thursday, ‎January ‎24, ‎2013 10:08:25 PM |
| [Windows8.1-Server2012R2ADMX-RTM.msi](https://www.microsoft.com/download/details.aspx?id=41193)| RTM| {4AED4C7A-9B51-445C-9066-91F3CEE0E690}| ‎Monday, ‎November ‎25, ‎2013 2:09:46 AM |
| [Windows10-ADMX.msi](https://www.microsoft.com/download/details.aspx?id=48257)| RTM| {79A07922-2B64-445E-B6DD-5578B607A411}| ‎Monday, ‎August ‎3, ‎2015 6:07:15 AM |
| [Windows10_Version_1511_ADMX.msi](https://www.microsoft.com/download/details.aspx?id=48257)| 1511| {095735F1-0D68-4941-A4CE-16BDEC8CAF21}| ‎Tuesday, ‎November ‎17, ‎2015 7:38:18 AM |
| [Windows 10 and Windows Server 2016 ADMX.msi](https://www.microsoft.com/download/details.aspx?id=53430)| 1607| {7848F166-A24F-4AE3-AEC9-6622770F8A85}| ‎Monday December ‎19, ‎2016 2:07:42 PM, ‎ |
  
### Other references

- [How to create and manage the Central Store for Group Policy Administrative Templates in Windows](https://support.microsoft.com/help/3087759/how-to-create-and-manage-the-central-store-for-group-policy-administrative-templates-in-windows)
- [Managing Group Policy ADMX Files Step-by-Step Guide](/previous-versions/windows/it-pro/windows-vista/cc709647(v=ws.10))
- ["'Microsoft.Policies.Sensors.WindowsLocationProvider' is already defined" error when you edit a policy in Windows](https://support.microsoft.com/help/3077013)
- [ADMX Version History](/archive/blogs/grouppolicy/admx-version-history)
- The content differences between ADMX/L files, within an Excel spreadsheet are available here: [https://go.microsoft.com/fwlink/?linkid=829685](https://go.microsoft.com/fwlink/?linkid=829685).

## Appendix

### Appendix 1 Windows Defender

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-defender-1.png" alt-text="Screenshot shows the Display notifications to clients when they need to perform actions policy is enabled.":::

The same setting (without editing the policy) after an ADMX upgrade to 1607d

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-defender-2.png" alt-text="Screenshot shows the Suppress all the notifications policy is disabled.":::

### Appendix 2 Windows Explorer

If the SmartScreen setting is enabled, and the **Require approval from an administrator before running downloaded unknown software** option is selected, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-1.png" alt-text="Screenshot shows the Configure Windows SmartScreen policy is enabled and there is a Pick one of the following settings box with 1 item under this policy.":::

After you upgrade the templates directly without changing the policy, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-2.png" alt-text="Screenshot shows the Display names for some settings cannot be found under Extra Registry Settings. 3 settings are listed under this item.":::

If you select the second option ("Give a warning"), you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-3.png" alt-text="Screenshot of the Configure Windows SmartScreen setting window in Group Policy Object Editor if you select the second option.":::

However, in the settings tab of GPMC, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-4.png" alt-text="Screenshot shows the Configure Windows SmartScreen policy is enabled and there is a Pick one of the following settings box under this policy.":::

> [!NOTE]
> No items are listed under **Pick one of the following settings**.

After the templates are upgraded, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-5.png" alt-text="Screenshot shows the Configure Windows SmartScreen policy is enabled and it is empty under this policy.":::

You now enable the policy and select to disable the smart screen, as shown:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-6.png" alt-text="Screenshot of the Configure Windows SmartScreen setting window in Group Policy Object Editor when you select the Turn off SmartScreen option.":::

After you make this setting, you see the following in the report:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-7.png" alt-text="Screenshot shows the Configure Windows SmartScreen policy is enabled. Turn off SmartScreen is listed under the Pick one of the following settings box.":::

After you upgrade the templates to build 1607, the settings report reads as follows:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-8.png" alt-text="Screenshot shows the Configure Windows SmartScreen policy is disabled.":::

If you now edit the setting, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-9.png" alt-text="Screenshot of the Configure Windows SmartScreen setting window in Group Policy Object Editor. The value is set to Disabled.":::

### Appendix 3 Windows Update

After the policy definitions are upgraded to at least the Windows 10 RTM build, and you configure the Windows Update settings to defer upgrades, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-update-1.png" alt-text="Screenshot shows the Defer Upgrades and Updates policy is enabled and 3 items are listed under this policy.":::

After the PolicyDefinitions folder is upgraded to build 1611, the settings become extra registry settings, as shown:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-update-2.png" alt-text="Screenshot shows the Display names for some settings cannot be found under Extra Registry Settings. 5 settings are listed under this item.":::

### Appendix 4 WinStoreUI upgrade to WindowsStore

Enabling the Microsoft Store options by using the Windows Server 2012 R2 build of ADMX provides the report:

:::image type="content" source="media/known-issues-for-group-policy-clients/winstoreui-upgrade-to-windowsstore-1.png" alt-text="Screenshot shows 3 policies are enabled.":::

After the ADMX files are replaced in the central store by build 1511, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/winstoreui-upgrade-to-windowsstore-2.png" alt-text="Screenshot shows the Turn off the Store application policy is enabled and Display names for some settings cannot be found under Extra Registry Settings. 7 settings are listed.":::

### Appendix 5 Error reporting

In Windows Server 2012 R2, you receive the following report if you enable **Configure Default consent**:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-1.png" alt-text="Screenshot shows the Turn off the Configure Default consent policy is enabled. The box under this policy shows that Consent level is Send all data.":::

If errorreporting.admx is replaced, the report becomes as follows:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-2.png" alt-text="Screenshot shows An error has occurred while collecting data for Administrative Templates. Registry value DefaultConsent is of unexpected type.":::

You can also see the image:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-3.png" alt-text="Screenshot shows 3 policies are enabled: Turn off Automatic Download of updates, Allow Store to install apps on Windows To Go workspaces and Turn off the Store application.":::

After WinStoreUI is removed and WindowsStore is added, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-4.png" alt-text="Screenshot shows the Turn off the Store application policy is enabled and Display names for some settings cannot be found under Extra Registry Settings. 2 settings are listed.":::

After both ADMX/L templates are present in the policy definitions folder, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-5.png" alt-text="Screenshot shows a namespace error has occurred while collecting data for Administrative Templates. ":::
