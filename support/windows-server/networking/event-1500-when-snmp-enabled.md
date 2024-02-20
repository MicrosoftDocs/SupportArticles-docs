---
title: Event 1500 when SNMP is enabled
description: Works around an issue where event ID 1500 is logged when SNMP is enabled.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Event 1500 logged when SNMP is enabled on Windows Server

This article provides a workaround for an issue where event ID 1500 is logged when Simple Management Network Protocol (SNMP) is enabled.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2002303

## Symptoms

After the SNMP Feature is installed in Windows Server, the following event ID 1500 source SNMP is logged in the System Event Log and one further event is logged for every start of the SNMP Service.

> Log Name: System  
Source: SNMP  
Date: \<Date> \<Time>  
Event ID: 1500  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: \<Computer Name>  
Description:  
The description for Event ID 1500 from source SNMP cannot be found. Either the component that raises this event is not installed on your local computer or the installation is corrupted. You can install or repair the component on the local computer. If the event originated on another computer, the display information had to be saved with the event. The following information was included with the event: SYSTEM\CurrentControlSet\Services\SNMP\Parameters\TrapConfiguration.

> [!NOTE]
> Once SNMP Traps are configured, the event is not logged anymore.

## Cause

This error is logged because the SNMP Service checks if the registry path mentioned in the Event Description is present and determines that it is not.

This registry path is needed for the SNMP trap configuration and is created once traps are set up.

## Workaround

This has been determined not to have any influence to the operation of SNMP or the system and should be ignored.

While the event will be logged after the SNMP Feature is initially installed and started, further reoccurrences of the Event can be avoided by creating the registry path in question listed below.

To work around this issue by the following operation:

1. Click **Start**, point to **Control Panel**, point to **Administrative Tools**, and then click **Computer Management**.
2. In the console tree, expand **Services and Applications**, and then click **Services**.
3. In the right pane, double-click **SNMP Service**.
4. Click the **Traps** tab.
5. Click **OK**.

You will notice, **TrapConfiguration** key is created under `HKEY_LOCAL_MACHINE\SYSTEM\CCS\Services\SNMP` by that operation.

## More information

The SNMP Service encountered an error while accessing the registry key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\SNMP\Parameters\TrapConfiguration`.
