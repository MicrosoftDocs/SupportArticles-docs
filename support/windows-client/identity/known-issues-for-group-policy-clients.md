---
title: Known issues for managing Group Policy clients
description: Describes known issues that occur when you manage a Windows 10 Group Policy Client from a Windows Server 2012 R2 server.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: User, computer, group, and object management
ms.technology: windows-client-active-directory
---
# Known issues managing a Windows 10 Group Policy client in Windows Server 2012 R2

_Original product version:_ &nbsp; Window 10 - all editions, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4015786

## Summary

This article describes the known challenges that can occur when you manage a Windows 10 Group policy client base from a Windows Server 2012 R2 server. The same challenges apply to using the Advanced Group Policy Management server (AGPM) on a Windows Server 2012 R2 server when you manage Windows 10 clients.

The document is separated into sections for each subsequent upgrade as they were released. It also indicates when a change affects only a specific build of the Group Policy ADMX template files.

The following list of changes doesn't include the many new additional settings that are added to each template file because they don't have any effect if they're added to an existing deployment. The existing deployment doesn't use those settings. So, it's unlikely to affect the environment.

It's also important to consider that during the GPMC startup, the console caches the ADMX files into memory. So, any changes to the templates that occur while the tool is open don't appear, even after a report refresh. After the tool is shut down and then reopened, it will get the new ADMX files from the PolicyDefinitions folder.

## More information

Traditionally, the method of translating group policy settings into a user interface that could be easily managed was provided by ADM files. These files use their own markup language. They were locale-specific. So, they were difficult to manage for multinational companies.

Microsoft Windows Vista and Windows Server 2008 introduced a new method of displaying settings within the Group Policy Management Console. Registry-based policy settings (located under the Administrative Templates category in the Group Policy Object Editor) are defined as using a standards-based, XML file format known as ADMX (more commonly known as administrative templates).

Group Policy Object Editor and Group Policy Management Console remain largely unchanged. In most situations, you don't notice the presence of ADMX files during your daily Group Policy administration tasks.

Some situations require an understanding of how ADMX files are structured and the location in which they're stored. ADMX files provide an XML-based structure for defining the display of the Administrative Template policy settings in the Group Policy tools. The Group Policy tools recognize ADMX files only if you're using a computer that is running Windows Vista or Windows Server 2008 or later versions.

Unlike ADM files, ADMX files aren't stored in individual GPOs. For domain-based enterprises, administrators can create a central store location of ADMX files that is accessible by anyone who has permission to create or edit GPOs. Group Policy tools continue to recognize any custom ADM files that you've in your existing environment, but will ignore any ADM file that has been superseded by an ADMX file, such as System.adm, Inetres.adm, Conf.adm, Wmplayer.adm, and Wuau.adm. So, if you've edited any of these files to change or create policy settings, the changed or new settings aren't read or displayed by the Windows Vista-based Group Policy tools.

The Group Policy Object Editor automatically reads and displays Administrative Template policy settings from ADMX files that are stored either locally or in the optional ADMX central store. The Group Policy Object Editor automatically reads and displays Administrative Template policy settings from custom ADM files that are stored in the GPO. You can still add or remove custom ADM files by using the Add/Remove template menu option. All Group Policy settings that are currently in ADM files that are delivered by Windows Server 2003, Windows XP, and Windows 2000 are also available in Windows Vista and Windows Server 2008 ADMX files.

It can be challenging to upgrade the PolicyDefinitions folder that has later revisions of the ADMX files. This is because some settings are deprecated and some are added. Typically, adding settings has a minimal effect. However, deprecating settings often causes pre-configured Group Policies to keep settings that can no longer be changed. Commonly, those types of redundant settings from the new ADMX files are listed as Extra Registry Settings in the settings report. These settings are still applied to production, but the administrator can no longer turn them on or off.

To manage this situation, an administrator could delete the Group policy, if it's no longer required. Or, they could copy the legacy ADMX template back to the PolicyDefinitions folder. This would enable the setting to be managed again, but at the cost of losing the new settings from the later revision ADMX template.

## Known ADMX file content change issues in Windows 10 build 1607

|Filename|Change|Possible effect|
|---|---|---|
| DataCollection.admx| Changed Policy setting `Allow Telemetry` class value from **Machine** to **Both**| This ADMX first appeared in Windows 10 RTM and was set to Machine in both the RTM and 1511 revisions. In build 1607, the class changed to Both. This means that the setting was applicable to both the User and Machine sides of the registry. Because this is an extension of an existing setting, this change has no expected effect. |
| DeliveryOptimization.admx| Changed Policy setting **Download Mode** (DownloadMode) configuration item from **None** to **HTTP only**| This change is a display text change only. The underlying values are the same as for previous builds of the ADMX file. So, there's no effect on production group policies. |
| inetres.admx| Removed Policy setting **Show Content Advisor on Internet Options**| This setting was deprecated from the 1607 build of the ADMX file, which has been present pre-2012 and Windows 8. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| MicrosoftEdge.admx| The following 15 settings have had class changes from **Machine** to **Both**: <br/>- Configure Autofill (AllowAutofill) <br/>- Allow Developer Tools (AllowDeveloperTools) <br/>- Configure don't Track (AllowDoNotTrack) <br/>- Allow InPrivate browsing (AllowInPrivate) <br/>- Configure Password Manager (AllowPasswordManager) <br/>- Configure Pop-up Blocker (AllowPopups) <br/>- Configure SmartScreen Filter (AllowSmartScreen) <br/>- Allow web content on New Tab page (AllowWebContentOnNewTabPage) <br/>- Configure cookies (Cookies) <br/>- Configure the Enterprise Mode Site List (EnterpriseModeSiteList) <br/>- Prevent using Localhost IP address for WebRTC (HideLocalHostIPAddress) <br/>- Configure Home pages (HomePages) <br/>- Prevent bypassing SmartScreen prompts for files (PreventSmartScreenPromptOverrideForFiles) <br/>- Configure Favorites (Favorites) <br/>- Send all intranet sites to Internet Explorer 11 (SendIntranetTraffictoInternetExplorer) | This ADMX first appeared in Windows 10 RTM and was set to Machine in both the RTM and 1511 revisions. In build 1607, the class changed to Both. This means that the setting was applicable to both the User and Machine sides of the registry. Because this is an extension of an existing setting, this change has no expected effect. |
| WindowsDefender.admx| Removed Policy setting **Define the rate of detection events for logging**| This setting was deprecated from the ADMX file. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsDefender.admx| Removed Policy setting **IP address range Exclusions** WindowsDefender.admx: Removed Policy setting **Port number Exclusions**| This setting was deprecated from the ADMX file. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsDefender.admx| Removed Policy setting **Process Exclusions for outbound traffic**| This setting was deprecated from the ADMX file. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsDefender.admx| Removed Policy setting **Threat ID Exclusions**| This setting was deprecated from the ADMX file. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsDefender.admx:| Removed Policy setting **Turn on Information Protection Control**| This setting was deprecated from the ADMX file. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsDefender.admx| Removed Policy setting **Turn on network protection against exploits of known vulnerabilities**| This setting was deprecated from the ADMX file. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsDefender.admx| Changed Policy setting **Suppress all notifications** (UX_Configuration_Notification_Suppress) enabled and disabled value from enabledValue=0 and disabledValue=1 to enabledValue=1 and disabledValue=0| This change has occurred on build 1607 and differs from build 1511 and previous. This change enables this setting to work as expected, because to previously enable this setting, it had to be disabled. The impact for an upgrade is that if the setting was configured and the PolicyDefinitions were upgraded to 1607, then the setting will automatically revert to the opposite setting that was previously configured. <br/>See [Appendix 1 Windows Defender](#appendix-1-windows-defender) <br/>|
| WindowsDefender.admx| Removed Policy setting **Configure local setting override to turn off Intrusion Prevention System**| This setting was deprecated from the ADMX file. This means that if the setting had already been deployed into production, and the ADMX file was upgraded, the setting remains configured, but it can't be changed without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsExplorer.admx| Changed Policy setting **Configure Windows SmartScreen** (EnableSmartScreen), replaced drop-down item to enabled/disabled configuration item.| This setting has changed in this version from previous versions, in particular the option to enable smart screen but Require approval from an administrator before running downloaded unknown software has been deprecated. This means that if this setting was configured previously, it will become unmanageable, after the ADMX upgrade. it's also important to note that if this setting is enabled, but the smart screen was disabled, then after the upgrade, the whole setting becomes disabled. <br/>See [Appendix 2 Windows Explorer](#appendix-2-windows-explorer) |
| WindowsUpdate.admx| Removed Policy setting **Defer Upgrades and Updates** (DeferUpgrade), replaced by more detailed Policy settings (`DeferFeatureUpdates`, `DeferQualityUpdates`, `ExcludeWUDriversInQualityUpdate`, `ActiveHours`)| The defer upgrade option was made available as per Windows 10 RTM and was changed on build 1607. Once the settings have been configured and the PolicyDefinitions folder is upgraded to build 1607, the settings become unmanageable. The configured settings will remain configured, but it won't be changeable without either a custom ADMX or deleting the whole policy that stores the setting. As the new DeferUpgrade settings are new to build 1607, it's not expected to have any impact on existing configurations. <br/>See [Appendix 3 Windows Update](#appendix-3-windows-update) |
||||

## Known ADMX file content change issues in Windows 10 build 1511

| Filename| Change| Possible Effect |
|---|---|---|
| Explorer.admx| Removed Policy setting **Turn off soft landing help tips** (DisableSoftLanding)| This setting has been deprecated from the Window 10 RTM ADMX file and wasn't present in 2012 R2. This means that if the setting had already been deployed into production and the ADMX was upgraded, the setting remains configured, but it's not changeable without either using a custom ADMX or deleting the whole policy that stores the setting. |
| inetres.admx| Removed Policy setting **Prevent configuration of top-result search on Address bar** (TopResultPol) (computer/Windows Components/IE/Internet Settings/Advanced Settings/Searching)| This setting has been deprecated from the ADMX file. This means that if the setting had already been deployed into production and the ADMX was upgraded, the setting remains configured, but it's not changeable without either using a custom ADMX or deleting the whole policy that stores the setting. |
| LocationProviderAdm.admx| Deprecated Microsoft-Windows-Geolocation-WLPAdm.admx for the new filename LocationProviderAdm.admx| When you upgrade from Windows 10 RTM to Windows 10 version 1511, the new LocationProviderAdm.admx file is copied to the folder while keeping the old Microsoft-Windows-Geolocation-WLPAdm.admx file. So, there are two ADMX files that address the same policy namespace. This generating an error. See ["'Microsoft.Policies.Sensors.WindowsLocationProvider' is already defined" error when you edit a policy in Windows](https://support.microsoft.com/help/3077013)|
| MicrosoftEdge.admx| Removed Policy setting **Allows you to run scripts, like JavaScript** (AllowActiveScripting) (Computer)| This setting has been deprecated from the ADMX file. This means that if the setting had already been deployed into production and the ADMX was upgraded, the setting remains configured, but it won't be changeable without either using a custom ADMX or deleting the whole policy that stores the setting. |
| MicrosoftEdge.admx| The following nine settings have had class changes from **Both** to **Machine**: <br/>- Turn off Autofill (AllowAutofill) <br/>- Allow employees to send don't Track headers (AllowDoNotTrack) <br/>- Turn off Password Manager (AllowPasswordManager) <br/>- Turn off Pop-up Blocker (AllowPopups) <br/>- Turn off address bar search suggestions (AllowSearchSuggestionsinAddressBar) <br/>- Turn off the SmartScreen Filter (AllowSmartScreen) <br/>- Configure Cookies (Cookies) <br/>- Configure the Enterprise Mode Site List (EnterpriseModeSiteList) <br/>- Send all intranet sites to Internet Explorer 11 (SendIntranetTraffictoInternetExplorer) | A change of class from **Both** to **Machine** means that a setting is descoped from being applicable to both the User and Machine sides of a policy to only the Machine side. This means that if the policy has already been configured in the User side, you would be unable to change the user side settings again after the ADMX upgrade. However, the setting remains configured. |
| ParentalControls.admx| Was removed in this build of ADMX| When an ADMX is removed from the latest build of templates, all settings that may have been configured from previous versions of the file become stagnant. If the PolicyDefinitions folder is upgraded, the existing previous file is still present. So, there's no effect. If the contents of the PolicyDefinitions folder is removed, and the new templates are populated, and some group policies are still configured by using the settings from parentalcontrols.ADMX, the settings will still be present and functional. However, they can't be reconfigured without either using a custom ADMX or deleting the whole policy that stores the setting. |
| WindowsStore.admx| Was added, that directly replaces WinStoreUI.admx (obtained from Windows 2012/8 RTM ADMX and wasn't present in 2012 R2/8.1)| The **EnableWindowsStoreOnWTG** setting in the key named Software\Policies\Microsoft\WindowsStore that has the value name of **EnableWindowsStoreOnWTG** is deprecated. This prevents the setting from being reconfigurable without either using a custom ADMX or deleting the whole policy that stores the setting. Also, the DisableAutoDownload setting value is changed from 3 (winStoreUI) to 4 (WindowsStore). This causes the original setting to be superseded and appear under extra registry settings. This also causes the original setting to become unchangeable. However, it will still be set. See [Appendix 4 WinStoreUI upgrade to WindowsStore](#appendix-4-winstoreui-upgrade-to-windowsstore) If both files are present at the same time, the GPMC fails to load. This is because the namespaces of both files are also duplicates. This causes the error while generating the settings `reportNamespace` 'Microsoft.Policies.WindowsStore' is already defined as the target namespace for another file in the store. File \\\\\<Domain Name>\SysVol\<DomainName>\Policies\PolicyDefinitions\WinStoreUI.admx, line 4, column 80 |
||||

## Known ADMX file content change issues in Windows 10 RTM

| Filename| Change| Possible effect |
|---|---|---|
| AppXRuntime.admx| Changed Policy **Allow Microsoft accounts to be optional** class value change from **Both** to **Machine**| A change of class from **Both** to **Machine** means that a setting has been descoped from being applicable to both the User and Machine sides of a policy to just the Machine. This means that if the policy has already been configured in the User side, you can't change the User side settings again after the ADMX upgrade. However, the setting remains configured. |
| ErrorReporting.admx| Removed Policy setting **Automatically send memory dumps for OS-generated error reports** (WerAutoApproveOSDumps_1 (User setting), WerAutoApproveOSDumps_2 (Machine setting))| If the ADMX is upgraded in place from the Windows Server 2012 R2 version, you can't change the settings again. The setting remains configured. However, you can't change it without either using a custom ADMX or deleting the whole policy that stores the setting. |
| ErrorReporting.admx| Removed Policy setting **Configure Default consent** (WerDefaultConsent_1 (User setting), WerDefaultConsent_2 (Machine setting))| Once the ErrorReporting.ADMX is replaced from the 2012 R2 revision to the Windows 10 RTM version, you see the following error: **Registry value DefaultConsent is of unexpected type.** To resolve this issue, the Group Policy should either be removed, and the settings be rebuilt into a new policy using the new ADMX template. See [Appendix 5 Error reporting](#appendix-5-error-reporting) |
| inetres.admx| Removed Policy setting **Allow Internet Explorer to use the SPDY/3 network protocol**| This setting has been deprecated from the 2012 R2 ADMX file. This means that if the setting had already been deployed into production and the ADMX was upgraded, the setting remains configured. However, you can't change it without either using a custom ADMX or deleting the whole policy that stores the setting. |
| NAPXPQec.admx| The ADMX file has been deprecated.| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file become stagnant. If the PolicyDefinitions folder has been upgraded, the existing previous file remains present. So, there's no effect. If the contents of the PolicyDefinitions folder has been removed, and the new templates are populated, and there are group policies still configured by using the settings from the NAPXPQec.ADMX, the settings remain present and functional. However, you can't reconfigure them without either using a custom ADMX or reinserting the file from a backup or deleting the whole policy that stores the setting. |
| NetworkProjection.admx| The ADMX file has been deprecated.| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file becomes stagnant. If the PolicyDefinitions folder has been upgraded, then the existing previous file will still be present, so there will no effect. If the contents of the PolicyDefinitions folder are removed, and then the new templates are populated, and there are group policies still configured by using the settings from the NetworkProjection.ADMX, the settings remain present and functional. However, you can't reconfigure them without using a custom ADMX, reinserting the file from a backup, or deleting the whole policy that stores the setting. |
| PswdSync.admx| This file was removed and now only delivered with Server Operating Systems only| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file will become stagnant. If the PolicyDefinitions folder has been upgraded, the existing previous file will remain present, so there will no effect. If the contents of the PolicyDefinitions folder has been removed, and the new templates are populated, and there are group policies still configured by using the settings from the PswdSync.ADMX, the settings will still remain present and functional. However, you can't reconfigure them without either using a custom ADMX, or reinserting the file from a backup, or reinserting the file from a server build or deleting the whole policy that stores the setting. |
| SkyDrive.admx| There are many changes to this file from 2012 R2 revision, but all change references from Skydrive to OneDrive, with relevant registry location changes also. Below are a few examples: <br/>1. Changed policyNamespace from "target prefix="skydrive" namespace="Microsoft.Policies.Skydrive"" to "target prefix="onedrive" namespace="Microsoft.Policies.OneDrive"" <br/>2. Changed category Skydrive to OneDrive <br/>3. Changed policy **Prevent the usage of OneDrive for file storage** to use the OneDrive registry key (`Software\Policies\Microsoft\Windows\OneDrive`) from the Skydrive registry key (`Software\Policies\Microsoft\Windows\Skydrive`) | After the Windows 10 RTM version of the Skydrive.admx replaces the 2012 R2 revision of the file, all control of Skydrive components is replaced with the OneDrive versions settings. If you're still using the Skydrive application, those settings will still apply. However, they'll be unmanageable without either using a custom ADMX or recovering the 2012 R2 version of the template. |
| Snis.admx| This file was removed and now only delivered with Server Operating Systems only| When an ADMX has been removed from the RTM build of templates, all settings that may have been configured from previous versions of the file will become stagnant. If the PolicyDefinitions folder has been upgraded, the existing previous file will remain present. So, there's no effect. If the contents of the PolicyDefinitions folder are removed, and the new templates are populated, and there are group policies still configured by using the settings from the Snis.ADMX, the settings will remain present and functional. However, you can't reconfigure them without either using a custom ADMX or reinserting the file from a backup or deleting the whole policy that stores the setting. |
| TerminalServer.admx| Changed Policy setting **Optimize visual experience when using RemoteFX** (TS_RemoteDesktopVirtualGraphics), removed typing error from **...ScreeenImageQuality...** to **...ScreenImageQuality...**| This setting has been changed internally and its name reference is only used to link the ADMX file to the ADML content. So, this change has no impact to the actual settings configured or the use of the settings in the policy. |
| WinStoreUI.admx| The ADMX file has been deprecated.| This file was removed for the Windows 10 RTM, so if the Microsoft Store was configured using Windows Server 2012 R2, then these settings will become extra registry settings. The settings are still present and functional. However, you can't reconfigure them without either using a custom ADMX or deleting the whole policy that stores the setting. Note: This file was replaced in Windows 10 build 1511 with the file WindowsStore.ADMX. Read the details of that file in the next section. |
||||

## ADMX source file references

|Filename|Reference Build|Revision Number|Digital Signal Date|
|---|---|---|---|
| [Windows8-Server2012ADMX-RTM.msi](https://www.microsoft.com/download/details.aspx?id=36991)| RTM| {EEDEB0DE-8C60-4EB6-A04D-7B3C5E121D03}| ‎Thursday, ‎January ‎24, ‎2013 10:08:25 PM |
| [Windows8.1-Server2012R2ADMX-RTM.msi](https://www.microsoft.com/download/details.aspx?id=41193)| RTM| {4AED4C7A-9B51-445C-9066-91F3CEE0E690}| ‎Monday, ‎November ‎25, ‎2013 2:09:46 AM |
| [Windows10-ADMX.msi](https://www.microsoft.com/download/details.aspx?id=48257)| RTM| {79A07922-2B64-445E-B6DD-5578B607A411}| ‎Monday, ‎August ‎3, ‎2015 6:07:15 AM |
| [Windows10_Version_1511_ADMX.msi](https://www.microsoft.com/download/details.aspx?id=48257)| 1511| {095735F1-0D68-4941-A4CE-16BDEC8CAF21}| ‎Tuesday, ‎November ‎17, ‎2015 7:38:18 AM |
| [Windows 10 and Windows Server 2016 ADMX.msi](https://www.microsoft.com/download/details.aspx?id=53430)| 1607| {7848F166-A24F-4AE3-AEC9-6622770F8A85}| ‎Monday December ‎19, ‎2016 2:07:42 PM, ‎ |
|||||

### Other references

- [How to create and manage the Central Store for Group Policy Administrative Templates in Windows](https://support.microsoft.com/help/3087759/how-to-create-and-manage-the-central-store-for-group-policy-administrative-templates-in-windows)
- [Managing Group Policy ADMX Files Step-by-Step Guide](/previous-versions/windows/it-pro/windows-vista/cc709647(v=ws.10))
- ["'Microsoft.Policies.Sensors.WindowsLocationProvider' is already defined" error when you edit a policy in Windows](https://support.microsoft.com/help/3077013)
- [ADMX Version History](/archive/blogs/grouppolicy/admx-version-history)
- The content differences between ADMX/L files, within an Excel spreadsheet are available here: [https://go.microsoft.com/fwlink/?linkid=829685](https://go.microsoft.com/fwlink/?linkid=829685).

## Appendix

### Appendix 1 Windows Defender

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-defender-1.png" alt-text="Windows Defender setting 1":::

The same setting (without editing the policy) after an ADMX upgrade to 1607d

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-defender-2.png" alt-text="Windows Defender setting 2":::

### Appendix 2 Windows Explorer

If the SmartScreen setting is enabled, and the **Require approval from an administrator before running downloaded unknown software** option is selected, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-1.png" alt-text="Windows Explorer setting 1":::

After you upgrade the templates directly without changing the policy, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-2.png" alt-text="Windows Explorer setting 2":::

If you select the second option ("Give a warning"), you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-3.png" alt-text="Windows Explorer setting 3":::

However, in the settings tab of GPMC, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-4.png" alt-text="Windows Explorer setting 4":::

> [!NOTE]
> No items are listed under **Pick one of the following settings**.

After the templates are upgraded, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-5.png" alt-text="Windows Explorer setting 5":::

You now enable the policy and select to disable the smart screen, as shown:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-6.png" alt-text="Windows Explorer setting 6":::

After you make this setting, you see the following in the report:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-7.png" alt-text="Windows Explorer setting 7":::

After you upgrade the templates to build 1607, the settings report reads as follows:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-8.png" alt-text="Windows Explorer setting 8":::

If you now edit the setting, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-explorer-9.png" alt-text="Windows Explorer setting 9":::

### Appendix 3 Windows Update

After the policy definitions are upgraded to at least the Windows 10 RTM build, and you configure the Windows Update settings to defer upgrades, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-update-1.png" alt-text="Windows Update 1":::

After the PolicyDefinitions folder is upgraded to build 1611, the settings become extra registry settings, as shown:

:::image type="content" source="media/known-issues-for-group-policy-clients/windows-update-2.png" alt-text="Windows Update 2":::

### Appendix 4 WinStoreUI upgrade to WindowsStore

Enabling the Microsoft Store options by using the Windows Server 2012 R2 build of ADMX provides the report:

:::image type="content" source="media/known-issues-for-group-policy-clients/winstoreui-upgrade-to-windowsstore-1.png" alt-text="WinStoreUI upgrade to WindowsStore 1":::

After the ADMX files are replaced in the central store by build 1511, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/winstoreui-upgrade-to-windowsstore-2.png" alt-text="WinStoreUI upgrade to WindowsStore 2":::

### Appendix 5 Error reporting

In Windows Server 2012 R2, you receive the following report if you enable **Configure Default consent**:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-1.png" alt-text="Error reporting 1":::

If errorreporting.admx is replaced, the report becomes as follows:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-2.png" alt-text="Error reporting 2":::

You can also see the image:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-3.png" alt-text="Error reporting 3":::

After WinStoreUI is removed and WindowsStore is added, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-4.png" alt-text="Error reporting 4":::

After both ADMX/L templates are present in the policy definitions folder, you see:

:::image type="content" source="media/known-issues-for-group-policy-clients/error-reporting-5.png" alt-text="Error reporting 5":::
