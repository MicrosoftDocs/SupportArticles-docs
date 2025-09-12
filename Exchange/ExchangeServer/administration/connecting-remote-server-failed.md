---
title: Connecting to the remote server failed when start Management Shell or Console
description: Connecting to the remote server failed with the following error message when you start the Exchange Management Shell or the Exchange Management Console.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
ms.custom: 
  - sap:OWA  And Exchange Admin Center\Issues connecting to Exchange Management Shell
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2010 Service Pack 3
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
ms.date: 01/24/2024
ms.reviewer: v-six
---

# "Connecting to the remote server failed with the following error message" error when you start the Exchange Management Shell or the Exchange Management Console

## Symptoms

When you try to start the Microsoft Exchange Management Shell (EMS) or the Microsoft Exchange Management Console (EMC) on a server that is running Microsoft Exchange Server, you receive one of the following error messages:

- Error message 1

    **Connecting to remote server failed with the following error message: The WinRM client cannot process the request. It cannot determine the content type of the HTTP response from the destination computer. The content type is absent or invalid. For more information, see the about_Remote_Troubleshooting Help topic.**

- Error message 2

    **Connecting to remote server failed with the following error message: The WinRM client sent a request to an HTTP server and got a response saying the requested HTTP URL was not available. This is usually returned by a HTTP server that does not support the WS-Management protocol. For more information, see the about_Remote_Troubleshooting Help topic.**

- Error message 3

    **Connecting to remote server failed with the following error message: The WinRM client received an HTTP server error status (500), but the remote service did not include any other information about the cause of the failure. For more information, see the about_Remote_Troubleshooting Help topic. It was running the command 'Discover-ExchangeServer -UseWIA $true -SuppressError $true'.**

- Error message 4

    **Connecting to remote server failed with the following error message: The connection to the specified remote host was refused. Verify that the WS-Management service is running on the remote host and configured to listen for requests on the correct port and HTTP URL. For more information, see the about_Remote_Troubleshooting Help topic.**

- Error message 5

    **Connecting to remote server failed with the following error message: The WinRM client received an HTTP status code of 403 from the remote WS-Management service.**

- Error message 6

    **Connecting to the remote server failed with the following error message: The WinRM client sent a request to an HTTP server and got a response saying the requested HTTP URL was not available. This is usually returned by a HTTP server that does not support the WS-Management protocol.**

- Error message 7

    **Connecting to remote server failed with the following error message: The client cannot connect to the destination specified in the request. Verify that the service on the destination is running and is accepting requests. Consult the logs and documentation for the WS-Management service running on the destination, most commonly IIS or WinRM. If the destination is the WinRM service, run the following command on the destination to analyze and configure the WinRM service:**

- Error message 8

    **Connecting to remote server failed with the following error message: The WS-Management service does not support the request.**

- Error message 9

    **Connecting to remote server failed with the following error message: The WinRM client cannot process the request. The WinRM client tried to use Kerberos authentication mechanism, but the destination computer.**

## Resolution

To resolve these problems, run the "Exchange Management Troubleshooter" (EMTshooter).

### About the EMT shooter

The EMTshooter runs on the local (target) Exchange server and tries to identify potential problems that affect the management tools that are connected to it.

The troubleshooter runs in two stages. First, it examines the IIS Default Web Site, the PowerShell vdir, and other critical areas to identify known causes of connection problems. If the tool identifies a problem that affects one of the pre-check processes, it makes a recommendation to resolve the problem. If the pre-checks pass, the troubleshooter tries to connect to the server exactly like the management tools would connect. If that connection attempt still causes a WinRM-style error, the troubleshooter tries compare that error to a list of stored strings that are collected from related support cases. If a match is found, the troubleshooter displays the known causes of that error in the CMD window.

The following screen shot shows how this display might appear.

:::image type="content" source="media/connecting-remote-server-failed/emt-shooter.png" alt-text="Screenshot of how this display might appear.":::

The EMTshooter logs events in the "Microsoft-Exchange-Troubleshooters/Operational" event log. All results that are displayed in the CMD window are also logged in the event log to create a record.

### Things to remember

- Depending on your current settings, you may have to adjust the execution policy on your computer to run the troubleshooter by using one of the following commands:
  - Set-ExecutionPolicy RemoteSigned
  - Set-ExecutionPolicy Unrestricted

    > [!IMPORTANT]
    > Remember to revert to the usual settings after you run the troubleshooter.

- You must run this version of the troubleshooter on the server that is running Exchange Server that the management tools do not connect to.
- In order to run the troubleshooter, you must have the user rights to log on locally to the Exchange server. This is a current requirement of the tool. Additionally, you must have the user rights to run Windows PowerShell.

### How to install EMTshooter

To install the EMT shooter, follow these steps:

1. Download the troubleshooter compressed file that has a .zip filename extension from [here](https://techcommunity.microsoft.com/gxcuf89792/attachments/gxcuf89792/Exchange/4274/1/EMTshooter.zip).
2. Extract the four files that are included in the .zip file into a folder, and then rename the file extensions to .ps1.
3. Run EMTshooter.ps1 from a standard (and local) Windows PowerShell window.

## References

For more information about the problems that are processed by EMTshooter and the causes of some of those problems, see the following Exchange Team Blog articles:

[Troubleshooting Exchange 2010 Management Tools startup issues](https://techcommunity.microsoft.com/t5/exchange-team-blog/troubleshooting-exchange-2010-management-tools-startup-issues/ba-p/595608)

[Resolving WinRM errors and Exchange 2010 Management tools startup failures](https://techcommunity.microsoft.com/t5/exchange-team-blog/resolving-winrm-errors-and-exchange-2010-management-tools/ba-p/588661)
