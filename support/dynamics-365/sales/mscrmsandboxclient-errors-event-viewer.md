---
title: MSCRMSandboxClient errors in the Event Viewer
description: This article provides a resolution for the problem where MSCRMSandboxClient errors occur in the Event Viewer.
ms.reviewer: jowells
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# MSCRMSandboxClient errors in the Event Viewer for Microsoft Dynamics CRM 2011

This article helps you resolve the problem where **MSCRMSandboxClient** errors occur in the Event Viewer.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2785590

## Symptoms

Within the Application Log of the Event Viewer on a Microsoft Dynamics CRM 2011 server, errors are being logged with the following details:

> Log Name: Application  
Source: MSCRMSandboxClient  
Date: MM/DD/YYYY HH:MM:SS  
Event ID: 20242  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: SERVER  
Description:  
The following information was included with the event:  
w3wp.exe (90192)
net.tcp://localhost/CrmSandboxSdkListener-w3wp
System.ServiceModel.AddressAlreadyInUseException: The TransportManager failed to listen on the supplied URI using the NetTcpPortSharing service: the URI is already registered with the service.

## Cause

The services are experiencing an issue due to Loopback Check. Since the connection is using localhost and not the FQDN of the server, it causes issues when registering the service. Loopback check is a security feature that is designed to help prevent reflection attacks on your computer.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

There are two methods to work around this issue, use one of the following methods, as appropriate for your situation.

- **Method 1: Specify host names (Preferred method if NTLM authentication is desired)** To specify the host names that are mapped to the loopback address and can connect to Web sites on your computer, follow these steps:

    1. Click **Start**, click **Run**, type *regedit*, and then click **OK**.
    1. In Registry Editor, locate and then click the following registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0`.
    1. Right-click **MSV1_0**, point to **New**, and then click **Multi-String Value**.
    1. Type *BackConnectionHostNames*, and then press **ENTER**.
    1. Right-click **BackConnectionHostNames**, and then click **Modify**.
    1. In the **Value** data box, type the host name or the host names for the sites that are on the local computer, and then click **OK**. Separate each entry with a new line.
    1. Quit Registry Editor, and then restart the IISAdmin service.

- **Method 2: Disable the loopback check (less-recommended method)** The second method is to disable the loopback check by setting the **DisableLoopbackCheck** registry key.

    To set the **DisableLoopbackCheck** registry key, follow these steps:

    1. lick **Start**, click **Run**, type *regedit*, and then click **OK**.
    1. In Registry Editor, locate and then click the registry key: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`.
    1. Right-click **Lsa**, point to **New**, and then click **DWORD Value**.
    1. Type *DisableLoopbackCheck*, and then press **ENTER**.
    1. Right-click **DisableLoopbackCheck**, and then click **Modify**.
    1. In the **Value** data box, type *1*, and then click **OK**.
    1. Quit Registry Editor, and then restart your computer.
