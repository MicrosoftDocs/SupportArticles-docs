---
title: DNS management pack discovery fails with event 1155
description: Fixes an issue in which DNS management pack discovery fails and event 1155 is logged in the Operations Manager event log.
ms.date: 07/13/2020
ms.prod-support-area-path:
---
# DNS management pack discovery fails with event ID 1155 in System Center Operations Manager

This article helps you fix an issue in which DNS management pack discovery fails and event 1155 is logged in the Operations Manager event log.

_Original product version:_ &nbsp; System Center Operations Manager  
_Original KB number:_ &nbsp; 2589504

## Symptoms

When using Microsoft System Center Operations Manager, with the DNS management pack, DNS 2008 Component Discovery may fail. The following events are logged in the Operations Manager event log on the DNS server.

Event 1155

> Log Name: Operations Manager  
> Source: Health Service Script  
> Date: \<Event Time>  
> Event ID: 1155  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<Computer Name>  
> Description:  
> DNS2008ComponentDiscovery: Unable to open WMI \root\default:StdRegProv.

Event 21405

> Log Name: Operations Manager  
> Source: Health Service Modules  
> Date: \<Event Time>  
> Event ID: 21405  
> Task Category: None  
> Level: Warning  
> Keywords: Classic  
> User: N/A  
> Computer: \<Computer Name>  
> Description:  
> The process started at \<Time> failed to create System.Discovery.Data, no errors detected in the output. The process exited with 0
>
> Command executed: "C:\Windows\system32\cscript.exe" /nologo "DNS2008ComponentDiscovery.vbs" \<Script Parameters>  
> Working Directory: \<Monitoring Host Temporary Files Location>
>
> One or more workflows were affected by this.
>
> Workflow name: Microsoft.Windows.DNSServer.2008.Discovery.Components  
> Instance name: \<Computer Name>  
> Instance ID: {\<GUID>}  
> Management group: \<Management Group Name>
>
> If you connect to WMI \root\default:StdRegProv directly using Windows Management Instrumentation Tester (Wbemtest.exe) with required privileges you should be able to connect.

## Cause

The `DNS2008ComponentDiscovery.vbs` script could not connect to the WMI class `MicrosoftDNS_Zone` due to an unavailable property value in the class.

## Resolution

To resolve this issue, recreate the WMI values for DNS by recompiling the DNS *.mof* files:

On the DNS server, open a Command Prompt as Administrator and execute the following commands:

```console
mofcomp C:\Windows\System32\wbem\dnsetw.mof
```

and

```console
mofcomp C:\Windows\System32\wbem\dnsprov.mof
```

These commands recreate the DNS information in the WMI repository. Once this is done, the errors should no longer appear.
