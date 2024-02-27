---
title: Fail to edit a group policy
description: Fixes an issue that triggers an error when the central store contains the .admx files from Windows 10.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Error when you edit a policy in Windows: Microsoft.Policies.Sensors.WindowsLocationProvided is already defined

This article helps fix an issue that triggers an error when the central store contains the .admx files from Windows 10.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2, Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 3077013

## Symptoms

Consider the following scenarios.

Scenario 1:

- You have a domain controller that's running Windows Server.
- You create a central store for Group Policy Administrative Template files (.admx files) on the computer. For more information, see [How to create the Central Store for Group Policy Administrative Template files in Windows Vista](create-central-store-domain-controller.md).
- You join a Windows 10-based computer to the domain.
- On the Windows 10-based computer, you copy the files under the %systemroot%\PolicyDefinitions directory, paste them to the ADMX central store, and overwrite all existing *.admx and *.adml files. Then, you open the Group Policy Management Console (GPMC) to edit a policy.
- You click the **Policies**  node under **Computer Configuration** or **User Configuration**.

Scenario 2:

- You have a computer that's running Windows 10 RTM (Build 10240).
- You upgrade the computer to later builds of Windows 10.

In these scenarios, you receive the following error message:

> Administrative Templates
>
> Dialog Message text
Namespace 'Microsoft.Policies.Sensors.WindowsLocationProvider' is already defined as the target namespace for another file in the store.
>
> File  
\\\\<forest.root>\SysVol\\<forest.root>\Policies\PolicyDefinitions\Microsoft-Windows-Geolocation-WLPAdm.admx, line 5, column 110

> [!NOTE]
> The <**forest.root**> placeholder represents the domain name.

For example, the error message resembles the message in the following screenshot:

:::image type="content" source="media/microsoft-policies-sensors-windowslocationprovider-defined/namespace-already-defined-error.png" alt-text="Screenshot of the Administrative Templates window which shows the error message.":::

> [!NOTE]
> You may not notice this issue if you are upgrading from Windows 7 or Windows 8.1 to Windows 10 version 1511 (skipping Windows 10 RTM).

## Cause

This issue occurs because the LocationProviderADM.admx file was renamed as Microsoft-Windows-Geolocation-WLPAdm.admx in Windows 10 RTM.

- Scenario 1

    After you copy the .admx files from Windows 10 to a central store that contains a LocationProviderADM.ADMX file that's from an earlier release of Windows, there are two .admx files that contain the same settings but that have different names. This triggers the "namespace is already defined" error.

- Scenario 2

    When you upgrade from Windows 10 RTM to Windows 10 version 1511, the new LocationProviderAdm.admx file is copied to the folder while still keeping the old Microsoft-Windows-Geolocation-WLPAdm.admx file. Therefore, there are two ADMX files that address the same policy namespace.

## Workaround

- Method 1

    Click **OK** to ignore the error message. The error message is informational, and the Group Policy setting works as expected.

- Method 2

    Delete the LocationProviderADM.admx and LocationProviderADM.adml files, and change Microsoft-Windows-Geolocation-WLPAdm.admx and Microsoft-Windows-Geolocation-WLPAdm.adml to the correct names.

Scenario 1:

1. Delete the LocationProviderADM.admx and LocationProviderADM.adml files from the central store.
2. Rename Microsoft-Windows-Geolocation-WLPAdm.admx as LocationProviderADM.admx.
3. Rename Microsoft-Windows-Geolocation-WLPAdm.adml as LocationProviderADM.adml.

Scenario 2:

- Delete the Microsoft-Windows-Geolocation-WLPAdm.admx file from the local store. The path to the local policy store is C:\Windows\PolicyDefinitions.

DMX and ADML files are system-protected. To rename or delete these files, you must add NTFS permissions to the files. To do this, use the following commands:

1. Open an elevated command prompt, and then use takeown.exe to grant ownership to local administrators:

    `takeown /F " C:\Windows\PolicyDefinitions\Microsoft-Windows-Geolocation-WLPAdm.admx" /A`

    `takeown /F " C:\Windows\PolicyDefinitions\en-US\Microsoft-Windows-Geolocation-WLPAdm.adml" /A`

2. Grant administrators Full Control permissions to both files.
3. Rename both files with an extension of .old, and you'll no longer receive the Geolocation pop-ups when you open GPEDIT.MSC.

## More information

There's only a single line of difference between the contents of the pre-Windows 10 LocationProviderADM.admx file and the Windows 10 Microsoft-Windows-Geolocation-WLPAdm.admx file.

In the pre-Windows 10 LocationProviderADM.admx file, the \<supportedOn> line appears as follows:

```xml
<supportedOn ref="windows:SUPPORTED_Windows8"/>
```

In the Windows 10 LocationProviderADM.admx, the \<supportedOn> line appears as follows:

```xml
<supportedOn ref="windows:SUPPORTED_Windows8_Or_Windows_6_3_Only"/>
```

This error occurs when you click the **Policy**  node under **Computer Configuration** or **User Configuration**.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Group Policy issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-group-policy.md).
