---
title: RemoteWipe CSP fails to send a doWipe command
description: Fixes an issue in which RemoteWipe fails to execute on Windows 10 client and an Event ID 400 error is generated.
ms.date: 05/11/2020
ms.prod-support-area-path: Device management
---
# The request is not supported when RemoteWipe fails to execute on Windows 10 client

This article fixes an issue in which RemoteWipe fails to execute on Windows 10 client and an Event ID 400 error is generated.

_Original product version:_ &nbsp; Microsoft Intune  
_Original KB number:_ &nbsp; 4034985

## Symptoms

When using the RemoteWipe CSP to send a `doWipe` command to a Windows 10 computer, the Windows computer shows no sign of wiping the device and an Event ID 400 error is generated in the `Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin` event log with **The request is not supported**:

> Log Name: Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin  
> Source: DeviceManagement-Enterprise-Diagnostics-Provider  
> Event ID: 400  
> Computer: DESKTOP PC  
> User: System  
> Details: MDM ConfigurationManager: Command failure status. Configuration Source ID: (9B5DC01F-D64E-488A-BB24-F0E9DA4FBF47), Enrollment Name: (MDMFull), Provider Name: (RemoteWipe), Command Type: (CmdType_Execute), CSP URI: (./Vendor/MSFT/RemoteWipe/doWipe), Result: (The request is not supported.).  
> XML:  
> \- \<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">  
> \- \<System>  
> \<Provider Name="Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider" Guid="{3DA494E4-0FE2-415C-B895-FB5265C5C83B}" />  
> \<EventID>400\</EventID>  
> \<Version>0\</Version>  
> \<Level>2\</Level>  
> \<Task>0\</Task>  
> \<Opcode>0\</Opcode>  
> \<Keywords>0x8000000000000000\</Keywords>  
> \<TimeCreated SystemTime="2017-06-29T13:18:40.644619600Z" />  
> \<EventRecordID>17327\</EventRecordID>  
> \<Correlation />  
> \<Execution ProcessID="2560" ThreadID="8612" />  
> \<Channel>Microsoft-Windows-DeviceManagement-Enterprise-Diagnostics-Provider/Admin\</Channel>  
> \<Computer>DESKTOP PC\</Computer>  
> \<Security UserID="S-1-5-18" />  
> \</System>  
> \- \<EventData>  
> \<Data Name="Message1">9B5DC01F-D64E-488A-BB24-F0E9DA4FBF47\</Data>  
> \<Data Name="Message2">MDMFull\</Data>  
> \<Data Name="Message3">RemoteWipe\</Data>  
> \<Data Name="Message4">CmdType_Execute\</Data>  
> \<Data Name="Message5">./Vendor/MSFT/RemoteWipe/doWipe\</Data>  
> \<Data Name="HexInt1">0x80070032\</Data>  
> \</EventData>  
> \</Event>

## Cause

This can occur if the Windows Recovery Environment (Windows RE) is disabled on the Windows 10 client computer. The RemoteWipe CSP requires Windows RE in order to function.

## Resolution

First check the status of Windows RE. You can do this by running a Command Prompt as an administrator, then executing the following command:

```console
Reagentc /info
```

The command should show a Windows RE status of **Enabled**, like this:

:::image type="content" source="./media/remotewipe-fails-sending-dowipe-command/status.png" alt-text="Screenshot of Windows RE status of Enabled.":::

If the status is **Disabled**, you will need to troubleshoot why Windows RE is disabled.

## More information

For more information on the RemoteWipe CSP and the `doWipe` command, see the following article:

[RemoteWipe CSP](/windows/client-management/mdm/remotewipe-csp)
