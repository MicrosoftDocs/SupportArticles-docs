---
title: Activation failures and 
description: Describes activation failures and .
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Activation failures and "not genuine" notifications around January 8, 2019, on volume-licensed Windows 7 KMS clients

_Original product version:_ &nbsp; Windows 7 Professional, Windows 7 Enterprise  
_Original KB number:_ &nbsp; 4487266

## Summary

This article applies to volume-licensed Windows 7 devices that use Key Management Service (KMS) activation and have the [KB 971033]()  update installed. Some users may receive the Windows Activation or "Windows is not genuine" notifications starting at or after 10:00 UTC, January 8, 2019. 
On January 9, 2019, we reverted a change that was made to Microsoft Activation and Validation  servers. For devices that continue to report activation and "not genuine" notifications, you should remove [KB 971033]()  by following the steps in the "Resolution" section.
 Windows editions that support volume-licensing activation include the following: 
- Windows 7 Professional 
- Windows 7 Professional N 
- Windows 7 Professional E 
- Windows 7 Enterprise 
- Windows 7 Enterprise N 
- Windows 7 Enterprise E 
For Windows editions that experience activation and "not genuine" errors that are not caused by the Microsoft Activation and Validation server change around January 8, 2019, we recommend that you follow standard activation troubleshooting.

## Symptoms


1. You receive a **Windows is not genuine**  error message after you log on.

| **Screenshot**| **Text description** |
|---|---|
|![Error](/media/activation-failures-not-genuine-notifications-volume-licensed-kms-client/4487268_en_1.jpg)<br/>|Dialog Title: Windows Activation<br/>Windows is not genuine<br/>Your computer might be running a counterfeit copy of Windows<br/>Get genuine now<br/>Ask me later<br/>0xC004F200|
|||

2. A **This copy of windows is not genuine**  watermark appears on the Windows desktop on a black background.

| **Screenshot**| **Textual description** |
|---|---|
|![Error](/media/activation-failures-not-genuine-notifications-volume-licensed-kms-client/4487270_en_1.jpg)<br/>|"This copy of Windows is not genuine" watermark appears in the bottom-right corner of the Windows desktop on a black background.|
|||

3. 
The
```
slmgr /dlv
```

output reports error 0xC004F200.

| **Screenshot**| **Textual description** |
|---|---|
|![Error](/media/activation-failures-not-genuine-notifications-volume-licensed-kms-client/4487271_en_1.png)<br/>| **Note** Select fields cleared to remove PII.<br/><br/>Name: Windows(R) 7, Enterprise edition<br/>Description: Windows Operating System - Windows(R) 7, VOLUME_KMSCLIENT channel<br/>Activation ID: ae2ee509-1b34-41c0-acb7-6d4650168915<br/>Application ID: 55c92734-d682-4d71-983e-d6ec3f16059f<br/>Extended PID: <removed><br/>Installation ID: <removed><br/>Partial Product Key: HVTHH<br/>License Status: Notification<br/>Notification Reason: 0xC004F200 (non-genuine).<br/>Remaining Windows rearm count: 2<br/>Trusted time: <removed><br/>Please use slmgr.vbs /ato to activate and update KMS client information in order to update values.|
|||

4. Activations that are made by using the 
```
slmgr /ato
```

command fails and return the following message: "Windows is running within the non-genuine notification period. Run 'slui.exe' to go online and validate Windows."

| **Screenshot**| **Textual description** |
|---|---|
|![Error](/media/activation-failures-not-genuine-notifications-volume-licensed-kms-client/4487272_en_1.jpg)<br/>|Activating Windows(R) 7, Enterprise edition (ae2ee509-1b34-41c0-acb7-6d4650168915) ...<br/>Error: Windows is running within the non-genuine notification period. Run 'slui.exe' to go online and validate Windows.|
|||

5. The following events are logged in the event log.

| **Event log**| **Event source**| **Event ID**| **Description** |
|---|---|---|---|
|Application|Microsoft-Windows-Security-SPP|8209|Genuine state set to non-genuine (0x00000000) for application Id 55c92734-d682-4d71-983e-d6ec3f16059f|
|Application|Microsoft-Windows-Security-SPP|8208|Acquisition of genuine ticket failed (hr=0xC004C4A2) for template Id 66c92734-d682-4d71-983e-d6ec3f16059f|
|Application|Windows Activation Technologies|13|Genuine validation result: hrOffline = 0x00000000, hrOnline =0xC004C4A2|
|Application|Microsoft-Windows-Security-SPP|8196|License Activation Scheduler (sppuinotify.dll) was not able to automatically activate. Error code:  0xC004F200:|
|||||

## Cause

A recent update to the Microsoft Activation and Validation unintentionally c a us ed a "not genuine" error on volume-licensed Windows 7 clients that had [KB971033]() installed. The change was introduced at 10:00:00 UTC on January 8, 2019, and was reverted at 4:30:00 UTC on January 9, 2019. 
 **Note** This timing coincides with the release of the "1B" January 2019 updates ([KB 4480960]() and [KB 4480970]()) that were released on Tuesday, January 8, 2019. These events are not related.
 Windows 7 devices that have [KB971033]() installed but did not experience this issue between the time of the change ( 10:00:00 UTC, January 8, 2019) and the time of the reversion of that change ( 4:30:00 UTC, January 9, 2019)  should not experience the issue that is described in this article. 
 [KB 971033]() ("Description of the up date for Windows Activation Technologies") contains the following text :
"Note For an Enterprise customer who uses Key Management Service (KMS) or Multiple Activation Key (MAK) volume activation, we generally recommend to NOT install this update in their reference image or already deployed computers. This update is targeted at consumer installs of Windows using RETAIL activation."
We strongly recommend that you uninstall [KB971033]() from all volume-licensed Windows 7-based devices. This includes devices that are not currently affected by the issue that is mentioned in the "Symptoms" section.

## Resolution

To determine whether [KB 971033]() is installed, useoneof the following methods. 
- Open the **Installed Updates** item in Control Panel (**Control Panel** > **Windows Update** > **View update history** > **Installed Updates**), and then look for **Update for Microsoft Windows (KB971033)** in the list.

- Run the following command in a Command Prompt window as administrator, and then look for **Microsoft-Windows-Security-WindowsActivationTechnologies-package~31bf3856ad364e35~amd64~~7.1.7600.16395**  in the results:
 **
```
dism /online /get-packages
```**  

- Run the following command at a command prompt, and then look in the results for an indication that [KB 971033]() is installed:
 **
```
wmic qfe where HotFixID="KB971033"
```**  

- Run the following command in Windows PowerShell, and then look in the results for an indication that [KB 971033]() is installed:
 **
```
Get-Hotfix -id KB971033
```**  



If [KB 971033]() is currently installed, useoneof the following methods to remove the update. We recommend that you restart the system after the update is removed.
- In the **Installed Updates** item in Control Panel (**Control Panel**  > **Windows Update**  > **View update history**  > **Installed Updates**), right-click **Update for Microsoft Windows (KB971033)**, and then select **Uninstall**.

- Run the following command in a Command Prompt window as administrator:
 **
```
wusa /uninstall /kb:971033
```**  

- Run the following command in a Command Prompt window as administrator:
 **
```
dism /online /Remove-Package /PackageName:Microsoft-Windows-Security-WindowsActivationTechnologies-Package~31bf3856ad364e35~amd64~~7.1.7600.16395
```**  



After [KB 971033]() is uninstalled, or after it no longer appears as installed, rebuild the activation-related files and then reactivate the system by running the following commands in a Command Prompt window as administrator: **net stop sppuinotify sc config sppuinotify start= disabled net stop sppsvc del %windir%\system32\7B296FB0-376B-497e-B012-9C450E1B7327-5P-0.C7483456-A289-439d-8115-601632D005A0 /ah del %windir%\system32\7B296FB0-376B-497e-B012-9C450E1B7327-5P-1.C7483456-A289-439d-8115-601632D005A0 /ah del %windir%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform\tokens.dat del %windir%\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform\cache\cache.dat net start sppsvc cscript c:\windows\system32\slmgr.vbs /ipk <edition-specific KMS client key> cscript c:\windows\system32\slmgr.vbs /ato sc config sppuinotify start= demand**  
 **Note** In the first "cscript" command, replace <edition-specific KMS client key> with the actual key. For more information, see the following Microsoft Docs article:
 [KMS Client Setup Keys](https://docs.microsoft.com/windows-server/get-started/kmsclientkeys) 
The following table lists the KMS client keys for each edition of Windows 7.

| **Operating system edition**| **KMS Client Setup Key** |
|---|---|
|Windows 7 Professional|FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4|
|Windows 7 Professional N|MRPKT-YTG23-K7D7T-X2JMM-QY7MG|
|Windows 7 Professional E|W82YF-2Q76Y-63HXB-FGJG9-GF7QX|
|Windows 7 Enterprise|33PXH-7Y6KF-2VJC9-XBBR8-HVTHH|
|Windows 7 Enterprise N|YDRBP-3D83W-TY26F-D46B2-XCKRJ|
|Windows 7 Enterprise E|C29WB-22CC8-VJ326-GHFJW-H9DH4|
|||

**Notes** 
- Scripts that contain the KMS client setup key must target the corresponding operating system edition.
- For services that do not have [KB 971033]() installed but experience the issue that is mentioned in the "Symptoms" section, you can also rebuild activation-related files and reactivate the system by using the script that is mentioned in the list of reactivation commands.
