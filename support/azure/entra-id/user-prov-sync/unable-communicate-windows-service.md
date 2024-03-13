---
title: Error (Unable to communicate with the Windows Azure Active Directory service) when Microsoft Entra Connect cannot authenticate to Microsoft Entra ID
description: Provides information about troubleshooting a problem in which your identity sync client cannot authenticate to Microsoft Entra ID if there is an unauthenticated proxy server.
ms.date: 05/11/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: enterprise-users
---
# Error when Microsoft Entra Connect cannot authenticate to Microsoft Entra ID: Unable to communicate with the Windows Azure Active Directory service

This article provides information about troubleshooting a problem in which your identity sync client cannot authenticate to Microsoft Entra ID if there is an unauthenticated proxy server.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 3013032

## Symptoms

If your environment includes an unauthenticated proxy server, your identity sync client may not authenticate to Microsoft Entra ID.

For example, you experience this issue when you use an identity sync client such as Microsoft Entra Connect, Azure Active Directory Sync Services (Azure AD Sync), or the Azure Active Directory Sync Tool.

If you're using Microsoft Entra Connect or Azure AD Sync:

The wizard displays the following configuration error message:

> Ready to configure.  
We have gathered enough information to configure Azure AD Sync and will now create a default configuration.  
Failed even after 5 retries. Action: PingProvisioningServiceEndPoint, Exception: Unable to communicate with the Windows Azure Active Directory service. Tracking ID: 01601250-7951-469c-8973-34e2a8e1ca10 See the event log for more details.

When this problem occurs, an "Error 906" entry that resembles the following is logged in the Microsoft Entra Connect or Azure AD Sync log. This entry indicates that the identity sync appliance tries to make a direct connection to the Internet.

> AzureActiveDirectoryDirectorySyncTool Error: 906 : System.Management.Automation.CmdletInvocationException: Failed even after 5 retries. Action: PingProvisioningServiceEndPoint, Exception: Unable to communicate with the Windows Azure Active Directory service. Tracking ID: 90edf657-f63e-46cc-94ec-df88817f4c73 See the event log for more details.. ---> Microsoft.IdentityManagement.PowerShell.ObjectModel.SynchronizationConfigurationValidationException: Failed even after 5 retries. Action: PingProvisioningServiceEndPoint, Exception: Unable to communicate with the Windows Azure Active Directory service. Tracking ID: 90edf657-f63e-46cc-94ec-df88817f4c73 See the event log for more details..

If you're using the Azure Active Directory Sync Tool:

The following Directory Synchronization event ID 0 is logged in the Application log of the identify sync client computer:

> Log name: Application  
 Source: Directory Synchronization  
 Event ID: 0  
 Task Category: None  
 Level: Error  
 Description:  
 Unable to establish a connection to the authentication service. Contact Technical Support.0 GetAuthState() failed with -2147186688 state. HResult:0. Contact Technical Support. (0x80048862)

Additionally, a Network Monitor (Netmon.exe) trace indicates that the Microsoft Online Services Sign-in Assistant uses the proxy and accesses `login.microsoftonline.com`.

## Cause

This problem occurs because the Microsoft .NET Framework on which your identity sync appliance is based doesn't recognize your proxy settings.

## Resolution

To fix this issue, follow these steps:

1. Open the following file: `C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Config\machine.config`.

2. Add the following text to the end of the file:

    `<system.net> <defaultProxy> <proxy usesystemdefault="true" proxyaddress="http://<PROXYIP>:80" bypassonlocal="true" /> </defaultProxy> </system.net>`

    > [!NOTE]
    > In this text, the placeholder \<PROXYIP> represents the actual proxy IP address. For more information about the proxy settings in this context, see [Element (Network Settings)](/dotnet/framework/configure-apps/file-schema/network/proxy-element-network-settings).

## More information

For more information, see [Error on .NET client that consumes a web service through an HTTP proxy server](https://support.microsoft.com/help/318140).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
