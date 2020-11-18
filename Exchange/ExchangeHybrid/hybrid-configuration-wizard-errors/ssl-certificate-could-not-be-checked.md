---
title: The SSL certificate could not be checked
description: Fixes an issue in which you receive a "The server used to check for revocation might be unreachable" error message when you run the Hybrid Configuration wizard.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: scotro
appliesto:
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
search.appverid: MET150
---
# The SSL certificate could not be checked for revocation when you run the Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067224

## Problem

When you run the Hybrid Configuration wizard, you receive a "The SSL certificate could not be checked for revocation. The server used to check for revocation might be unreachable" error message. The full text of this message resembles the following:

> ERROR:Updating hybrid configuration failed with error 'System.Management.Automation.Remoting.PSRemotingTransportException: Connecting to remote server failed with the following error message : The server certificate on the destination computer (ps.outlook.com:443) has the following errors: The SSL certificate could not be checked for revocation. The server used to check for revocation might be unreachable. For more information, see the about_Remote_Troubleshooting Help topic.  
> at System.Management.Automation.Runspaces.AsyncResult.EndInvoke()  
> at System.Management.Automation.Runspaces.AsyncResult.EndInvoke()  
> at System.Management.Automation.Runspaces.Internal.RunspacePoolInternal.EndOpen(IAsyncResult asyncResult)  
> at System.Management.Automation.Runspaces.RunspacePool.Open()  
> at System.Management.Automation.RemoteRunspace.Open()  
> at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.Connect(PSCredential credentials, CultureInfo sessionUiCulture)  
> at Microsoft.Exchange.Management.Hybrid.Engine.Execute(ILogger logger, String onPremPowershellHost, PSCredential onPremCredentials, PSCredential tenantCredentials, HybridConfiguration hybridConfiguration)  
> at Microsoft.Exchange.Management.SystemConfigurationTasks.UpdateHybridConfiguration.InternalProcessRecord()'.

## Cause

This problem occurs because Microsoft Exchange Server uses Windows HTTP Services (WinHTTP) to manage all HTTP and HTTPS traffic, and WinHTTP does not use the proxy settings that are set in the web browser.

To view the WinHTTP proxy settings, type the following command at a command prompt, and then press Enter:

```console
netsh winhttp show proxy
```

## Solution

To resolve this issue, use the `netsh` command-line tool to configure the WinHTTP proxy setting and the fully qualified domain name (FQDN) of the server in the WinHTTP bypass list.

For more information about how to set proxy settings for WinHTTP, see the following resources:

- [Netsh Commands for Windows Hypertext Transfer Protocol (WINHTTP)](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731131(v=ws.10))
- [Configure Proxy Settings for WinHTTP](/previous-versions/office/exchange-server-2010/bb430772(v=exchg.141))
- [WinHttpDetectAutoProxyConfigUrl function (winhttp.h)](/windows/win32/api/winhttp/nf-winhttp-winhttpdetectautoproxyconfigurl)

## More information

If you experience issues with the Hybrid Configuration wizard, you can run the [Exchange Hybrid Configuration Diagnostic](https://aka.ms/hcwcheck). This diagnostic is an automated troubleshooting experience. Run it on the same server on which the Hybrid Configuration wizard failed. Doing this collects the Hybrid Configuration wizard logs and parses them for you. If you're experiencing a known issue, a message is displayed that tells you what went wrong. The message includes a link to an article that contains the solution. Currently, the diagnostic is supported only in Internet Explorer.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
