---
title: BizTalk Host instance can't start
description: This article describes the problem that after you change the configuration file in BizTalk Server, a failure might occur and the BizTalk Server host instance can't start.
ms.date: 03/04/2020
ms.prod-support-area-path: BizTalk Server Setup and Configuration
---
# BizTalk Host instance fails to start after a configuration file change

This article explains that after you change the configuration file in BizTalk Server, a failure might occur and the BizTalk Server host instance can't start.

_Original product version:_ &nbsp; BizTalk Server 2009  
_Original KB number:_ &nbsp; 2411668

## Symptoms

The BizTalk Server host instance can't start after you changed the configuration file in BizTalk Server. You might get the following error:

> A failure occurred when executing a Windows service request.  
> Service request: Start  
> BizTalk host name: BizTalkServerApplication  
> Windows service name: BTSSvc$BizTalkServerApplication  
> Additional error information:  
> Error code: 0xc0c0153a  
> Error source: BizTalk Server 2009  
> Error description: A BizTalk subservice has failed while executing a service request.  
> Subservice: Tracking  
> Service request: Start  
> Additional error information:  
> Error code: 0x80131534  
> Error source: System.Data  
> Error description: The type initializer for 'System.Data.SqlClient.SqlConnection' threw an exception. For more information, see Help and Support Center at [Microsoft Support](https://support.microsoft.com).

## Cause

The btsntsvc.exe.config or btsntsvc64.exe.config file had been modified with an `xlangs` section. No configuration section handler was present for `xlangs`.

## Resolution

Add a configuration section handler for `xlangs`.

``` xml
<?xml version="1.0"?>
<configuration>
  <configSections>
    <section name="xlangs" type="Microsoft.XLANGs.BizTalk.CrossProcess.XmlSerializationConfigurationSectionHandler, Microsoft.XLANGs.BizTalk.CrossProcess">
    </section>
  </configSections>
```
