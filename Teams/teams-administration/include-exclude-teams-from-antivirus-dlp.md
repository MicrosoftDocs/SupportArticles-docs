---
title: Prevent Antivirus and DLP Tools from Blocking or Crashing Microsoft Teams
manager: dcscontentpm
ms.date: 06/06/2025
audience: Admin
ms.topic: troubleshooting
search.appverid:
  - SPO160
  - MET150
ms.assetid:
appliesto:
  - New Microsoft Teams
  - Classic Microsoft Teams
ms.custom:
  - sap:Teams Clients\Windows Desktop
  - CI 106370
  - CI 4441
  - CSSTroubleshoot
ms.reviewer: davidsle, dpollicino
description: Provides instructions to prevent antivirus and DLP applications from blocking the Microsoft Teams app or causing the app to fail.
---

# Prevent antivirus and DLP tools from blocking or crashing Microsoft Teams

Third-party applications for antivirus, reliability monitoring, and data loss prevention (DLP) can interfere with the Microsoft Teams app and [Edge WebView2](https://developer.microsoft.com/microsoft-edge/webview2/?form=MA13LH). These tools can degrade Teams client performance and also cause the app to exit unexpectedly. To improve application stability and efficency when you use non-Microsoft antivirus or DLP applications on desktops, you can include or approve the use of the Teams app, the executable that automatically updates the Teams app, and Edge Webview2.

## New Teams

To prevent issues from occurring when you start or use the new Teams app, add all the following processes to the exclusion list in the antivirus software that you use:

- `msedgewebview2.exe`
- `ms-teams.exe`
- `ms-teamsupdate.exe`
- `msteams_autostarter.exe`

Alternatively, you can add the processes to the allowlist for programs in your DLP application. The method to accomplish this addition varies. For specific instructions, contact your DLP application manufacturer.

The MSIX installer installs the new Teams app in the `WindowsApps` folder instead of the user profile folder in which the classic Teams app is installed. Because users can't write to the `WindowsApps` folder, this location adds better protection against attacks that are intended to alter the installation of the Teams app.

**Note**: The MSIX installer and all files in the same directory are signed by using a Microsoft certificate.

The name of the folder in which the new Teams app is installed is dynamic and it changes when the app version is updated. The folder name begins in `MSTeams_`, ends in `_8wekyb3d8bbwe`, and includes the app's version number in between. For example, `MSTeams_23247.1112.2396.409_x64_8wekyb3d8bbwe`.

### Location of the Teams installation folder

To add the Teams processes to either the exclusion list or the allow list, you can find their location by using the following steps:

1. Open Windows PowerShell and run the following cmdlet to determine the location of the installation files:

   ```powershell
   Get-AppPackage -name "msteams"
   ```

   The results include the value of the **InstallLocation** parameter, such as `C:\Program Files\WindowsApps\MSTeams_23247.1112.2396.409_x64_8wekyb3d8bbwe`.
1. To view the individual files, open **Task Manager**, and select **Details**.
1. On the **Details** tab, locate and right-click **ms-teams.exe**, and then select **Open file location**.

## Classic Teams

To prevent issues from starting the classic Teams app, add the following processes to the exclusion list in the antivirus software that you're using:

- `C:\Users\*\AppData\Local\Microsoft\Teams\current\teams.exe`
- `C:\Users\*\AppData\Local\Microsoft\Teams\update.exe`
- `C:\Users\*\AppData\Local\Microsoft\Teams\current\squirrel.exe`
- `C:\Users\*\AppData\Local\Microsoft\TeamsMeetingAddin`

Alternatively, you can add the processes to the allowlist for programs in your DLP application. The method to accomplish this addition varies. For specific instructions, contact your DLP application's manufacturer.

## Applications that might block Teams or cause it to fail

The following table lists applications and their associated DLLs that are known to potentially block or cause Teams to stop responding.

| Application | Associated DLLs |
| --- | --- |
| 360 Safe Security| `safewrapper.dll`|
| ASUS Sonic Suite 3| `ss3devprops.dll`|
| Aternity||
| Avast Antivirus| `aswhook.dll`|
| Avecto (now BeyondTrust)| `PGHook.dll`|
| BeyondTrust||
| Citrix App Protection| `ctxapclient64.dll`|
| Citrix ICA Client| `epclient64.dll`|
| Citrix ICA Service| `ctxdodhook64.dll`|
| ControlUp||
| CrowdStrike Falcon Sensor| `Umppc*.dll`|
| Cylance Desktop Security| `cymemdef64.dll`|
| DataClasys User Client| `CLSCBase.dll`, `CLSUInject.dll`|
| Encourage Technologies ESS Rec Agent| `etraldr.dll`|
| Esafenet Cobra DocGuard| `dynamicdll64.dll`|
| Fasoo DRM| `f_nxa.dll`|
| Frontier Technology DRM Agent| `ftagtctr.dll`, `detoured.dll`|
| Keyman Engine| `keyman64.dll`|
| Konica Minolta copier explorer plugin| `PSDPUIHandler.dll`|
| ManageEngine Unified Endpoint Management and Security (UEMS) Agent| `DragDrophook.dll`|
| Manufacturer Endpoint Agent| `clpbm64.dll`, `prntm64.dll`|
| Max Software Keylogger| `skgsec64.dll`|
| McAfee||
| Nahimic| `NahimicOSD.dll`, `Nahimic2OSD.dll`, `AudioDevProps2.dll`, `NahimicVRDevProps.dll`<br/><br/> [Modify the Nahimic exclusion list](../meetings/new-teams-desktop-app-fail-render-video.md#workaround)|
| NetRatings NetSight| `n64hooks.dll`|
| Netrix Agent| `nxgrdh64.dll`, `nxipc64.dll`|
| Nuance NaturallySpeaking| `nlutmgrhook_x64.dll`|
| NVIDIA ShadowPlay| `nvspcap64.dll`|
| Ocular Agent| `winhafnt64.dll`|
| PC Matic SuperShield| `SuperShieldHookCpy64.dll`|
| QiAnXin Tianqing DLP| `qmdlphook64.dll`|
| QiAnXin Tianqing HookBase| `ghijt64*.dll`|
| QiAnXin Tianqing Watermark| `watermarkhook64.dll`|
| Quality ISMC Client| `ismcfilehook64.dll`|
| SkyGuard Endpoint Security| `sgephook.dll`|
| Symantec Endpoint Protection (SEP) | `sysfer.dll`<br/><br/> [Create an Application Control exception in SEP](https://knowledge.broadcom.com/external/article/181736/how-to-create-an-application-control-exc.html)|
| Thycotic Application Control| `ArelliaACActioni64.dll`|
| TightVNC| `screenhooks64.dll`|
| Trellix Drive Encryption||
| Zscaler||
| Ztsment Data Protection| `injumon64.dll`|
| Forcepoint DLP||

## Other DLLs that might affect Teams desktop client and Edge WebView2

The following DLLs are known to affect the Teams desktop client and Edge WebView2. You should verify the presence of the DLLs, and also verify the ownership and integrity of the DLLs.

- `bsijt64.dll`
- `core64.dll`
- `cptlwa64.dll`
- `cryptacl.dll`
- `csprnthk.dll`
- `cssguard64.dll`
- `ctiuser.dll`
- `dgapia64.dll`
- `dsefilesystemext64.dll`
- `dsloaderinj.x64.dll`
- `emcnt64.dll`
- `encappctrl64.dll`
- `estoutgo64.dll`
- `f_lph.dll`
- `guard64.dll`
- `hkapi.x64.dll`
- `hookcreateprocessinternal64.dll`
- `imfph64.dll`
- `ldgetprintcontent64.dll`
- `ldprintmonitor64.dll`
- `ldsmartenc64.dll`
- `ldwatermarkhook64.dll`
- `ldxghijt64.dll`
- `libwire_api_monitor_4.4.0.9.1662362401.dll`
- `lpghijt64.dll`
- `monfileop64.dll`
- `mozartbreathprotect.dll`
- `oeareader64.dll`
- `printhk64.dll`
- `sbieoutside.dll`
- `sdckern.dll`
- `sdwhf2130.dll`
- `tmailhook64.dll`
- `tsafedoc64.dll`
- `uhk64.dll`
- `vozokopot.dll`
- `winahframe64.dll`
- `wincept64.dll`  
- `winncap364.dll`
- `xpspntdll64_6016.dll`  
  
[!INCLUDE [Third-party information disclaimer](../../includes/third-party-information-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../includes/third-party-contact-disclaimer.md)]

[!INCLUDE [Third-party information and solution disclaimer](../../includes/third-party-information-solution-disclaimer.md)]

Still need help? Go to [Microsoft Support Community](https://answers.microsoft.com).
