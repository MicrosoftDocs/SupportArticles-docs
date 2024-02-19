---
title: Can't install the SNMP and WMI SNMP Provider features
description: Works around the issue in which the SNMP and WMI SNMP Provider features can't be installed using the DISM.exe tool in Windows 10 or Windows 11.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, anupamk, thyog
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Can't install the SNMP and WMI SNMP Provider features in Windows 10 or Windows 11

This article provides workarounds to install the Simple Network Management Protocol (SNMP) and Windows Management Instrumentation (WMI) SNMP Provider features in Windows 10 or Windows 11.

## Error when installing the SNMP and WMI SNMP Provider features

You try to install the SNMP and WMI SNMP Provider features in Windows 10 or Windows 11 by using the [Deployment Image Servicing and Management (DISM.exe)](/windows-hardware/manufacture/desktop/what-is-dism) tool as follows:

```console
dism /online /enable-feature /featureName:SNMP /featureName:WMISnmpProvider
```

Then, you receive this error message:

> Error: 0x800f080c  
> Feature name SNMP is unknown.  
> Feature name WMISnmpProvider is unknown.  
> A Windows feature name was not recognized.  
> Use the /Get-Features option to find the name of the feature in the image and try the command again.

> [!IMPORTANT]
> This issue occurs because the SNMP and WMI SNMP Provider features are deprecated.

To work around this issue, use one of the following methods.

## Install the SNMP and WMI SNMP Provider features from the Settings page

1. Go to Start, select **Settings** > **Apps**.
2. Under **Apps & features**, select **Optional features** > **Add a feature**.
    - To install the SNMP feature, select **Simple Network Management Protocol (SNMP)** > **Install**.
    - To install the WMI SNMP Provider feature, select **WMI SNMP Provider** > **Install**.

To verify the installation state, select **See optional features history**.

## Install the SNMP and WMI SNMP Provider features by using Windows PowerShell

1. Start Windows PowerShell as an administrator.
2. Run the following [Add-WindowsCapability](/powershell/module/dism/add-windowscapability) cmdlets to install the SNMP and WMI SNMP Provider features.

    ```powershell
    Add-WindowsCapability -Online -Name "SNMP.Client~~~~0.0.1.0"
    ```

    ```powershell
    Add-WindowsCapability -Online -Name "WMI-SNMP-Provider.Client~~~~0.0.1.0"
    ```

To verify the installation state, run the following [Get-WindowsCapability](/powershell/module/dism/get-windowscapability) cmdlets.

```powershell
Get-WindowsCapability -Online -Name "SNMP.Client~~~~0.0.1.0"
```

```powershell
Get-WindowsCapability -Online -Name "WMI-SNMP-Provider.Client~~~~0.0.1.0"
```

The state is **Installed** if these features are installed correctly.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).
