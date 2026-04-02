---
title: Assigned access kiosk users can't use the Japanese User Dictionary Tool
description: Discusses an issue in which assigned access kiosk users can't use the Japanese User Dictionary Tool because the tool is not on the list of allowed applications. 
ms.date: 04/03/2026
manager: dcscontentpm
ms.topic: troubleshooting
ms.custom:
- sap:windows desktop and shell experience\kiosk mode
- pcy:WinComm User Experience
ms.reviewer: kaushika, warrenw, v-appelgatet
audience: itpro
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Assigned access kiosk users can't use the Japanese User Dictionary Tool in a Windows 11 multi-app kiosk

## Summary

When you configure a Windows 11 multi-app kiosk for assigned access users, by default the allowed applications list doesn't include the Japanese User Dictionary Tool. This article describes the issue and explains how to to enable the tool for assigned access users by adding the tool's files to your assigned access configuration XML file.

## Symptoms

In a Windows 11 multi-app kiosk environment (also referred to as a restricted user experience), an assigned access user tries to open the Japanese User Dictionary Tool. The tool doesn't open, and the user receives the following message:

> This operation has been cancelled due to restrictions in effect on this computer. Please contact your system administrator.

## Cause

AppLocker generates this message because the Japanese User Dictionary Tool is not one of the allowed applications for the multi-app kiosk.

## Resolution

To include the Japanese User Dictionary Tool as one of the kiosk apps, add the following XML elements to the `<AllowedApps>` section of the assigned access configuration XML file:

```xml
<App DesktopAppPath="C:\Windows\System32\IME\IMEJP\IMJPDCT.EXE"/>
<App DesktopAppPath="C:\Windows\System32\IME\IMEJP\IMJPSET.EXE"/>
<App DesktopAppPath="C:\Windows\System32\IME\IMEJP\IMJPUEX.EXE"/>
<App DesktopAppPath="C:\Windows\System32\IME\IMEJP\IMJPUEXC.EXE"/>
```

For more information, see the [AllAppList](/windows/configuration/assigned-access/configuration-file?pivots=windows-11#allapplist) section of "Create an Assigned Access configuration XML file."

## References

- [Create an Assigned Access configuration XML file](/windows/configuration/assigned-access/configuration-file)
- [Configure a restricted user experience (multi-app kiosk) with Assigned Access](/windows/configuration/assigned-access/configure-multi-app-kiosk)
- [Assigned Access examples](/windows/configuration/assigned-access/examples)
- [Assigned Access policy settings](/windows/configuration/assigned-access/policy-settings)
