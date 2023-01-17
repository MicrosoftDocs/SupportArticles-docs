---
title: IIS can't start when re-enabling shared configuration
description: This article provides workarounds for the IIS problem where re-enabling shared configuration after making changes to applicationHost.config causes IIS to fail to start.
ms.date: 04/16/2020
ms.custom: sap:WWW authentication and authorization
ms.technology: iis-www-authentication-authorization
---
# Re-enabling shared configuration after making changes to applicationHost.config causes IIS to fail to start

This article helps you resolve the problem where re-enabling shared configuration after making changes to *applicationHost.config* causes Microsoft Internet Information Services (IIS) can't start.

_Original product version:_ &nbsp; Internet Information Services 7.0, 7.5  
_Original KB number:_ &nbsp; 2565028

## Symptoms

Consider the following scenario:

- You have enabled shared configuration on an IIS 7.0 or 7.5 server.
- You disable shared configuration to make changes to your IIS configuration, such as to uninstall a module or disable an IIS feature.
- You then re-enable shared configuration and export the new configuration file (applicationHost.config) to the centralized location.

After taking these steps, the Windows Process Activation Service and the WWW service fail to start. Errors similar to the following are written to the event logs:

```console
Log Name: System
Source: Microsoft-Windows-WAS
Date: 1/1/2011 1:11:11 AM
Event ID: 5005
Task Category: None
Level: Error
Keywords: Classic
User: N/A
Computer: MYCOMPUTER
Description:
Windows Process Activation Service (WAS) is stopping because it encountered an error.  
The data field contains the error number.
Event Xml:
<Event xmlns="`https://schemas.microsoft.com/win/2004/08/events/event`">
<System>
<Provider Name="Microsoft-Windows-WAS" Guid="{524B5D04-133C-4A62-8362-64E8EDB9CE40}"
EventSourceName="WAS" />
<EventID Qualifiers="49152">5005</EventID>
<Version>0</Version>
<Level>2</Level>
<Task>0</Task>
<Opcode>0</Opcode>
<Keywords>0x80000000000000</Keywords>
<TimeCreated SystemTime="2011-1-1T1:11:11.000000000Z" />
<EventRecordID>22211</EventRecordID>
<Correlation />
<Execution ProcessID="0" ThreadID="0" />
<Channel>System</Channel>
<Computer>MYCOMPUTER</Computer>
<Security />
</System>
<EventData>
<Binary>0D000780</Binary>
</EventData>
</Event>
```

```console
Log Name: System
Source: Microsoft-Windows-WAS
Date: 1/1/2011 1:11:11 AM
Event ID: 5189
Task Category: None
Level: Error
Keywords: Classic
User: N/A
Computer: MYCOMPUTER
Description:
The Windows Process Activation Service failed to generate an application pool config file
for application pool "*". The error type is "0".
To resolve this issue, please ensure that the applicationhost.config file is correct
and recommit the last configuration changes made.
The data field contains the error number.
Event Xml:
<Event xmlns="`https://schemas.microsoft.com/win/2004/08/events/event`">
<System>
<Provider Name="Microsoft-Windows-WAS" Guid="
{524B5D04-133C-4A62-8362-64E8EDB9CE40}" EventSourceName="WAS" />
<EventID Qualifiers="49152">5189</EventID>
<Version>0</Version>
<Level>2</Level>
<Task>0</Task>
<Opcode>0</Opcode>
<Keywords>0x80000000000000</Keywords>
<TimeCreated SystemTime="2011-1-1T1:11:11.000000000Z" />
<EventRecordID>22209</EventRecordID>
<Correlation />
<Execution ProcessID="0" ThreadID="0" />
<Channel>System</Channel>
<Computer>MYCOMPUTER</Computer>
<Security />
</System>
<EventData>
<Data Name="AppPoolID">*</Data>
<Data Name="ErrorType">0</Data>
<Binary>0D000780</Binary>
</EventData>
</Event>
```

## Cause

This problem is a bug in IIS 7.0 and 7.5. There's a problem in the process of replacing the pre-existing configuration files on the UNC when you re-export the configuration file to a centralized location. This ends up leaving the *applicationHost.config* file on the centralized server in an invalid state.

## Resolution

This problem is fixed in a next version of IIS. To work around the issue, make sure to delete the previous configuration files on the centralized server before exporting the new configuration file when re-enabling the Shared Configuration.

## More information

You can learn more about shared configuration in [Shared Configuration](/iis/manage/managing-your-configuration-settings/shared-configuration_264)
