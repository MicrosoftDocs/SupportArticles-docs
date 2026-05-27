---
title: HTTP 403 error when you start Exchange Management Shell
description: This article shows how to fix an HTTP 403 error that occurs when you start Exchange Management Shell on Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:OWA And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11505
ms.reviewer: wduff, v-six, v-kccross
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
ms.date: 05/27/2026
---

# HTTP error 403 when you start Exchange Management Shell (EMS) on Exchange Server

_Original KB number:_ &nbsp; 2276957

## Summary

This article describes an issue where Exchange Management Shell (EMS) fails to connect and returns an HTTP 403 error. The problem occurs when the Require SSL setting is enabled on the PowerShell virtual directory in IIS. To fix the issue, disable the Require SSL option in IIS, restart IIS, and then reopen EMS.

## Symptoms

When you try to open EMS on an Exchange Server, you receive the following error message:

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

This problem occurs because the "Require SSL" option on the PowerShell virtual directory in Internet Information Services (IIS) Manager is enabled. However, this option isn't needed because Exchange Server uses Kerberos authentication.

## Resolution

To resolve this problem, follow these steps:

1. On the Exchange Server, open IIS Manager.
   To open IIS Manager, press **Windows key + R**, type `inetmgr`, and then press **Enter**.
1. Locate the PowerShell virtual directory under **Default Web Site**, and then select **SSL Settings** in the **Details** pane.
1. Double-click **SSL Settings** and then clear the **Require SSL** option.
1. In the **Details** pane, select **Apply** to save the settings in IIS Manager.
1. Restart IIS.
   To restart IIS, open an elevated command prompt, type `iisreset`, and then press **Enter**.
1. Close EMS, and then reopen it.

## Status

Microsoft confirms that this issue is still a problem.
