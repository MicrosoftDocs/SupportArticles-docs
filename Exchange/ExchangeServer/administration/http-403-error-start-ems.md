---
title: HTTP 403 when you start Exchange Management Shell
description: Provides a resolution to fix an issue in which you receive an HTTP status code of 403 when you start Exchange Management Shell on an Exchange Server 2010 Client Access server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: wduff, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010
ms.date: 01/24/2024
---
# HTTP error 403 when you start Exchange Management Shell on an Exchange Server 2010 Client Access server

_Original KB number:_ &nbsp; 2276957

## Symptoms

When you try to open EMS on an Exchange Server 2010 Client Access server, you receive the following error message in EMS:

> VERBOSE: Connecting to \<server name>  
>
> [\<server name>] Connecting to remote server failed with the following error message: The WinRM client received an HTTP status code of 403 from the remote WS-Management service. For more information, see the about_Remote_Troubleshooting Help topic.
>
> \+ CategoryInfo : OpenError: (System.Manageme....RemoteRunspace:RemoteRunspace) [], PSRemotingTransportException
>
> \+ FullyQualifiedErrorId : PSSessionOpenFailed
>
> Failed to connect to any Exchange Server in the current site.
>
> Please enter the Server FQDN where you want to connect:

## Cause

This problem occurs because the Require SSL option on the PowerShell  virtual directory in Internet Information Services (IIS) Manager is enabled. However, this option setting is not needed because Exchange Server 2010 uses Kerberos authentication.

## Resolution

To resolve this problem, follow these steps:

1. On the Exchange Server 2010 Client Access server, open IIS Manager.
2. Locate the PowerShell virtual directory under **Default Web Site**, and then click **SSL Settings** in the details pane.
3. Double-click **SSL Settings** and then clear the **Require SSL** option.
4. In the details pane, click **Apply** to save the settings in IIS Manager.
5. Restart IIS.
6. Close EMS, and then reopen it.

## Status

Microsoft has confirmed that this is a problem.
