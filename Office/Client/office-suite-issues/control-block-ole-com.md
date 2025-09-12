---
title: How to control the blocking of OLE/COM components in Microsoft 365
description: Describes how to control the blocking of OLE/COM components in Microsoft 365 Subscription.
author: Cloud-Writer
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
manager: dcscontentpm
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365
ms.date: 05/29/2025
---

# How to control the blocking of OLE/COM components in Microsoft 365 Subscription

## Introduction 

After you install the March 2017 updates for Microsoft 365 Subscription Version 1703 (Build 7967.2139), you gain the ability to block activation of OLE/COM components. In this update, we are blocking activation of components that are listed under the following registry key:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\Common\COM Compatibility`

In this update, we have added the following components to the blocked list:

- {3050F4D8-98B5-11CF-BB82-00AA00BDCE0B} - ProgId: htafile, "CLSID_HTML Application"
- {06290BD3-48AA-11D2-8432-006008C3FBFC} - ProgId: script, "CLSID_Moniker to a Windows Script Component"

In this update, we are allowing the following components to be activated:

- {8856F961-340A-11D0-A96B-00C04FD705A2} - ProgId: shell.explorer, "CLSID_Microsoft Web Browser"
- {25336920-03F9-11CF-8FD0-00AA00686F13} - ProgId: htmlfile, "CLSID_Microsoft HTML Document 6.0"

## More information

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

### How to control the blocking of OLE/COM components in Microsoft 365 Subscription

To override and allow a specific component, follow these steps:

1. Locate the **ActivationFilterOverride** value under the following registry subkey:
 
    - For 64-bit Office installations, and for 32-bit Office installations on 32-bit Windows:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\Common\COM Compatibility\{CLSID}`
    - For 32-bit Office installations on 64-bit Windows:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\Common\COM Compatibility\{CLSID}`
1. Make sure that the value is set to **1** (one). If the value is set to 0, or the value is missing, we will block that component.

To disable filtering per individual Office application, follow these steps:

1. Locate the **ActivationFilter** value under the following registry subkey:

    - For 64-bit Office installations, and 32-bit Office installations on 32-bit Windows:

      `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\{APP}\Security`
    - For 32-bit Office installations on 64-bit Windows:
    
      `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Office\ClickToRun\REGISTRY\MACHINE\Software\Microsoft\Office\16.0\{APP}\Security`
1. Make sure that the value is set to **0** (zero). If the value is set to 1, or the value is missing, filtering is enabled.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
