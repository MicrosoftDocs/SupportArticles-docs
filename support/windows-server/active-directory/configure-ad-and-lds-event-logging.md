---
title: AD and LDS diagnostic event logging
description: This article discusses the level of Active Directory diagnostic event logging and provides solutions for configuring Active Directory diagnostic event logging.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-lightweight-directory-services-ad-lds-and-active-directory-application-mode-adam, csstroubleshoot
---
# How to configure Active Directory and LDS diagnostic event logging

This step-by-step article describes how to configure Active Directory diagnostic event logging in Microsoft Windows Server operating systems.

_Applies to:_ &nbsp; Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
_Original KB number:_ &nbsp; 314980

## Summary

Active Directory records events to the Directory Services or LDS Instance log in Event Viewer. You can use the information that is collected in the log to help you diagnose and resolve possible problems or monitor the activity of Active Directory-related events on your server.

By default, Active Directory records only critical events and error events in the Directory Service log. To configure Active Directory to record other events, you must increase the logging level by editing the registry.

## Active Directory diagnostic event logging

The registry entries that manage diagnostic logging for Active Directory are stored in the following registry subkeys.

Domain controller: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`  
LDS: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<LDS instance name>\Diagnostics`

Each of the following **REG_DWORD** values under the `Diagnostics` subkey represents a type of event that can be written to the event log:

1. Knowledge Consistency Checker (KCC)
2. Security Events
3. ExDS Interface Events
4. MAPI Interface Events
5. Replication Events
6. Garbage Collection
7. Internal Configuration
8. Directory Access
9. Internal Processing
10. Performance Counters
11. Initialization/Termination
12. Service Control
13. Name Resolution
14. Backup
15. Field Engineering
16. LDAP Interface Events
17. Setup
18. Global Catalog
19. Inter-site Messaging
20. Group Caching
21. Linked-Value Replication
22. DS RPC Client
23. DS RPC Server
24. DS Schema
25. Transformation Engine
26. Claims-Based Access Control
27. PDC Password Update Notifications

## Logging levels

Each entry can be assigned a value from 0 through 5, and this value determines the level of detail of the events that are logged. The logging levels are described as:

- 0 (None): Only critical events and error events are logged at this level. This is the default setting for all entries, and it should be modified only if a problem occurs that you want to investigate.
- 1 (Minimal): High-level events are recorded in the event log at this setting. Events may include one message for each major task that is performed by the service. Use this setting to start an investigation when you do not know the location of the problem.
- 2 (Basic)
- 3 (Extensive): This level records more detailed information than the lower levels, such as steps that are performed to complete a task. Use this setting when you have narrowed the problem to a service or a group of categories.
- 4 (Verbose)
- 5 (Internal): This level logs all events, including debug strings and configuration changes. A complete log of the service is recorded. Use this setting when you have traced the problem to a particular category of a small set of categories.

## How to configure Active Directory diagnostic event logging

To configure Active Directory diagnostic event logging, follow these steps.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

1. Select **Start**, and then select **Run**.
2. In the Open box, type *regedit*, and then select **OK**.
3. Locate and select the following registry keys.

    Domain controller: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics`  
    LDS: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\<LDS instance name>\Diagnostics`

    Each entry that's displayed in the right pane of the Registry Editor window represents a type of event that Active Directory can log. All entries are set to the default value of **0** (None).

4. Configure event logging for the appropriate component:
    1. In the right pane of Registry Editor, double-click the entry that represents the type of event for which you want to log. For example, Security Events.
    2. Type the logging level that you want (for example, 2) in the **Value data** box, and then select **OK**.

5. Repeat step 4 for each component that you want to log.
6. On the Registry menu, select **Exit** to quit Registry Editor.

    > [!NOTE]
    >
    > - Logging levels should be set to the default value of 0 (None) unless you are investigating an issue.
    > - When you increase the logging level, the detail of each message and the number of messages that are written to the event log also increase. A diagnostic level of 3 or greater is not recommended, because logging at these levels requires more system resources and can degrade the performance of your server. Make sure that you reset the entries to 0 after you finish investigating the problem.

### Enable Field Engineering diagnostic event logging

This logging isn't enabled by default and should only be enabled during active troubleshooting. You can enable the logging by using the following steps:

1. Increase the size of Directory Services event logs to 200 MB.
2. Enable the Field Engineering diagnostics registry key, and set the value to _5_.

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics\15 Field Engineering`

3. Create the following registry keys to configure registry-based filters for expensive, inefficient, and long-running searches:

    |Registry path  |Data type  |Default value  |
    |---------|---------|---------|
    |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters\Expensive Search Results Threshold`     |REG_DWORD         |1         |
    |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters\Inefficient Search Results Threshold`     |REG_DWORD         |1         |
    |`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters\Search Time Threshold (msecs)`     |REG_DWORD         |1         |
