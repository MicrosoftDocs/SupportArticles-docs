---
title: Can't install the SNMP and WMI SNMP Provider features
description: Works around the issue in which the SNMP and WMI SNMP Provider features can't be installed using the DISM.exe tool in Windows 10 or Windows 11.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, anupamk, thyog
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
---
title: Can't install the SNMP and WMI SNMP Provider features
description: Works around the issue in which the SNMP and WMI SNMP Provider features can't be installed using the DISM.exe tool in Windows 10 or Windows 11.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, anupamk, thyog
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Can't add the SNMP and WMI SNMP Provider features in Windows 10 or Windows 11

This article provides workarounds to add the Simple Network Management Protocol (SNMP) and Windows Management Instrumentation (WMI) SNMP Provider features in Windows 10 or Windows 11.

## Error when adding the SNMP and WMI SNMP Provider features

You try to add the SNMP and WMI SNMP Provider features in Windows 10 or Windows 11 by using the [Deployment Image Servicing and Management (DISM.exe)](/windows-hardware/manufacture/desktop/what-is-dism) tool as follows:

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

## Add the SNMP and WMI SNMP Provider features from the Settings page

1. Go to Start, select **Settings** > **System**.
> [!NOTE]
> On versions older than Windows 10 22H2, go to Settings > Apps > Apps & features instead.
2. Select **Optional features** > **Add a feature**.
   - To add the SNMP feature, select **Simple Network Management Protocol (SNMP)** > **Add**.
   - To add the WMI SNMP Provider feature, select **WMI SNMP Provider** > **Add**.
      
To verify the added state, select **See optional features history**.

## Add the SNMP and WMI SNMP Provider features by using Windows PowerShell

1. Start Windows PowerShell as an administrator.
1. Run the following [Add-WindowsCapability](/powershell/module/dism/add-windowscapability) cmdlets to add the SNMP and WMI SNMP Provider features.

       ```powershell
    Add-WindowsCapability -Online -Name "SNMP.Client~~~~0.0.1.0"
    ```

       ```powershell
    Add-WindowsCapability -Online -Name "WMI-SNMP-Provider.Client~~~~0.0.1.0"
    ```

To verify the added state, run the following [Get-WindowsCapability](/powershell/module/dism/get-windowscapability) cmdlets.

```powershell
Get-WindowsCapability -Online -Name "SNMP.Client~~~~0.0.1.0"
```

```powershell
Get-WindowsCapability -Online -Name "WMI-SNMP-Provider.Client~~~~0.0.1.0"
```

The state is **Installed** if these features are added correctly.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#wmi).
