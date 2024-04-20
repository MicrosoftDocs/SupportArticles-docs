---
title: Configuration Manager console shows out-of-date values
description: Describes an issue in which Configuration Manager console displays out-of-date Endpoint Protection Definition version and last update time while the clients have the latest version of definition installed.
ms.date: 12/05/2023
ms.custom: sap:Endpoint Protection\Antimalware Policies
ms.reviewer: kaushika
---
# Configuration Manager console displays out-of-date Endpoint Protection Definition version and last update time

This article provides a solution for the issue that Configuration Manager console displays out-of-date Endpoint Protection Definition version and last update time while the clients have the latest version of definition installed.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4528414

## Symptoms

When you use Endpoint Protection together with Configuration Manager, you experience the following issues:

- In the Configuration Manager console, you open the **Assets and Compliance** workspace under the **Devices** node. In that workspace, you notice that the **Endpoint Protection Definition Last Version** and **Endpoint Protection Last Update Time** columns display out-of-date values for some devices. However, the clients show that they have the latest versions applied.
- Topic type 1901 (State_Topictype_Ep_Am_Health) isn't logged in StateMessage.log on the clients.
- The following error messages are logged in ExternalEventAgent.log on the clients:

> PARSE XML to get the query String SELECT * FROM MSFT_MPComputerStatus  
> ...  
> Execute all initialization actions for policy change from CCM_ExternalEventConfig.  
> **Could not open the registry key SOFTWARE\Microsoft\CCM\ExternalEventAgent\Criterias\Differentiation\ComputerStatusStateMessage\SyncStatus with error 0x80070002**.​  
> **Could not open the registry key SOFTWARE\Microsoft\CCM\ExternalEventAgent\Criterias\Differentiation\ComputerStatusStateMessage with error 0x80070002**.​  
Failed to load previous values of Differentiation criteria ComputerStatusStateMessage with error 0x80070002.​  
> **Could not open the registry key SOFTWARE\Microsoft\CCM\ExternalEventAgent\Criterias\Differentiation\InfectionStatusStateMessage\SyncStatus with error 0x80070002**.​  
> **Could not open the registry key SOFTWARE\Microsoft\CCM\ExternalEventAgent\Criterias\Differentiation\InfectionStatusStateMessage with error 0x80070002**.​  
> Failed to load previous values of Differentiation criteria InfectionStatusStateMessage with error 0x80070002.​

Additionally, the following registry keys don't exist on the client:

- `HKLM\SOFTWARE\Microsoft\CCM\ExternalEventAgent\Criterias\Differentiation\ComputerStatusStateMessage`
- `HKLM\SOFTWARE\Microsoft\CCM\ExternalEventAgent\Criterias\Differentiation\InfectionStatusStateMessage`

## Cause

This issue occurs because the instance of the `MSFT_MpComputerStatus` class doesn't exist in the `root\Microsoft\ProtectionManagement` namespace. The client queries this instance to populate the related registry keys.

## Resolution

To fix the issue, run the following command on the affected client computers to re-register the `ProtectionManagement` provider:

```console
Register-CimProvider -ProviderName ProtectionManagement -Namespace root\Microsoft\protectionmanagement -Path <path of ProtectionManagement.dll> -Impersonation True -HostingModel LocalServiceHost -SupportWQL -ForceUpdate
```

> [!NOTE]
> In this command, \<_path of ProtectionManagement.dll_> is the placeholder for the path of ProtectionManagement.dll. For example:  
C:\ProgramData\Microsoft\Windows Defender\Platform\4.18.1907.4-0\ProtectionManagement.dll

After you run this command, the following conditions are true:

- The instance of `MSFT_MpComputerStatus` is populated in the `root\Microsoft\ProtectionManagement` namespace.
- Topic type 1901 is logged in StateMessage.log.
- The affected values in the Configuration Manager console are updated.

## More information

Windows Defender logs can help you identify the root cause of this issue. For example, the following log snippet indicates the presence of a different antivirus solution:

> 2019-09-04T08:00:11.166Z [Mini-filter] Denied access to file: \ProgramData\Microsoft\Windows Defender\Platform\4.18.1907.4-0\Powershell\\**MSFT_MpComputerStatus.cdxml**, from process '\Device\HarddiskVolume2\Program Files (x86)\Symantec\\**Symantec Endpoint Protection**\14.0.3929.1200.105\Bin\ccSvcHst.exe' (PID: 3408)

To collect diagnostic logs for Windows Defender, follow the steps in [Collect Update Compliance diagnostic data for Windows Defender AV Assessment](/windows/security/threat-protection/windows-defender-antivirus/collect-diagnostic-data-update-compliance).

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
