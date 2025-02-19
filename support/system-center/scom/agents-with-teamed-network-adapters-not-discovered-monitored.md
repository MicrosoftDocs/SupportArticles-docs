---
title: Agents using NIC teaming aren't discovered or monitored
description: Fixes an issue in which Operations Manager agents that use NIC teaming are not discovered or monitored.
ms.date: 04/15/2024
ms.reviewer: ainslebl
---
# Operations Manager agents with teamed network adapters fail to be discovered and monitored

This article helps you fix an issue in which Operations Manager agents that use NIC teaming are not discovered or monitored.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2847767

## Symptoms

System Center Operations Manager agent computers that utilize NIC teaming are not discovered or monitored, and you see the following errors:

> Log Name:       Operations Manager  
> Source:            Health Service Script  
> Date:               \<date>  
> Event ID:          4001  
> Task Category: None  
> Level:              Error  
> Keywords:       Classic  
> User:              N/A  
> Computer:      \<computerName>  
> Description: Microsoft.Windows.Server.NetwokAdapter.BandwidthUsed.ModuleType.vbs : The class name 'Win32_PerfFormattedData_Tcpip_NetworkInterface Where Name ='VLAN100:HP Network Team _1'' did not return any valid instances.  Please check to see if this is a valid WMI class name.. Invalid class

You may also see the following alert:

> The process started at 09:44:43 failed to create System.PropertyBagData, no errors detected in the output. The process exited with 0  
> Command executed: "C:\Windows\system32\cscript.exe" /nologo "Microsoft.Windows.Server.NetwokAdapter.BandwidthUsed.ModuleType.vbs"  
> Working Directory: C:\Program Files\System Center Operations Manager 2007\Health Service State\Monitoring Host Temporary Files 23\\\\  
> One or more workflows were affected by this.  
> Workflow name: Microsoft.Windows.Server.2008.NetworkAdapter.PercentBandwidthUsedTotal.Collection  
> Instance name: Local Area Connection  
> Instance ID: {}

## Cause

This can occur if the drivers being used for NIC teaming on the agent don't properly register in WMI.

The Windows Server Operating System management pack (version 6.0.6958.0) contains a script that's responsible for discovering teamed adapters named **Microsoft.Windows.Server.NetwokAdapter.BandwidthUsed.ModuleType.vbs**. If the NIC teaming driver being used fails to properly register in WMI, when the script runs and fails to find the registered classes, the script will fail and log the errors above.

Many teaming NIC drivers also fail to register performance counters that can also be a reason why the required WMI registration is not created.

## Resolution

If you experience script failures such as these, disabling NIC teaming on the agent computer will resolve the issue. The problem with the NIC registration in WMI needs to be addressed by the NIC manufacturer so that the driver correctly registers itself in WMI when installed. Contact the adapter manufacturer for more information.

## More information

Microsoft now offers NIC teaming as part of Windows Server 2012.
