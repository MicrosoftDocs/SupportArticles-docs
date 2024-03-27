---
title: Warnings logged installing the Configuration Manager client
description: Describes a problem in which many warning messages for PolicyAgentInstanceProvider are logged in the Application log when you install the Configuration Manager client.
ms.date: 12/05/2023
ms.reviewer: kaushika, brshaw, keiththo, prakask, ErinWi
ms.custom: sap:Client Installation, Registration and Assignment\Client Installation
---
# Warnings for PolicyAgentInstanceProvider are logged when installing the Configuration Manager client

This article describes a by design behavior that many warning messages are logged for `PolicyAgentInstanceProvider` when you install the Configuration Manager client.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager, Microsoft System Center 2012 R2 Configuration Manager  
_Original KB number:_ &nbsp; 2688239

## Symptoms

When you install the Configuration Manager client, you may find that many warning messages for `PolicyAgentInstanceProvider` are logged in the Application log. Those messages resemble the following:

> Log Name: Application  
> Source: Microsoft-Windows-WMI  
> Date: *datetime*  
> Event ID: 63  
> Task Category: None  
> Level: Warning  
> Keywords: Classic  
> User: SYSTEM  
> Computer: *computer_name*  
> Description:  
> A provider, PolicyAgentInstanceProvider, has been registered in the Windows Management Instrumentation namespace root\ccm\Policy\\\<SID> to use the LocalSystem account. This account is privileged and the provider may cause a security violation if it does not correctly impersonate user requests.

Event Xml:

```xml
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
    <System>
        <Provider Name="Microsoft-Windows-WMI" Guid="{GUID}"
        EventSourceName="WinMgmt"/>
        <EventID Qualifiers="32768">63</EventID>
        <Version>0</Version>
        <Level>3</Level>
        <Task>0</Task>
        <Opcode>0</Opcode>
        <Keywords>0x80000000000000</Keywords>
        <TimeCreated SystemTime="datetime" />
        <EventRecordID>1470</EventRecordID>
        <Correlation />
        <Execution ProcessID="0" ThreadID="0" />
        <Channel>Application</Channel>
        <Computer>computer_name</Computer>
        <Security UserID="UserID" />
    </System>
    <EventData>
        <Data>PolicyAgentInstanceProvider</Data>
        <Data>root\ccm\Policy\<SID></Data>
    </EventData>
</Event>
```

## Cause

These warning messages are expected. They occur because Configuration Manager is not included in the Windows Management Instrumentation (WMI) exclusion list of providers that can run under the local system account at the time of installation.

## More information

These warning messages are expected during the installation of the Configuration Manager client and can be safely ignored. `PolicyAgentInstanceProvider` is registered as safe with WMI during installation so the warning messages should stop being logged as soon as the setup program is finished.

If the warning messages continue to be logged after the installation of the Configuration Manager client is complete, it may be because the **Configuration Manager Client Retry Task** in scheduled tasks was not removed after the successful installation. If you continue to experience these warning messages after the Configuration Manager client is successfully installed, deleting or disabling this task in scheduled tasks will stop the numerous WMI warning messages from being generated.
