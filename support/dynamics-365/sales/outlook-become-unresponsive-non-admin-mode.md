---
title: Outlook may become unresponsive in non-admin mode
description: This article provides two workarounds for the problem that occurs when you try to open Microsoft Dynamics CRM Client for Outlook or when you try the offline synchronization process in the Microsoft Dynamics CRM client for Outlook with offline access.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM Outlook Client may become unresponsive in non-admin mode

This article helps you work around the problem that occurs when you try to open Microsoft Dynamics CRM Client for Outlook or when you try the offline synchronization process in the Microsoft Dynamics CRM client for Outlook with offline access.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2013 Service Pack 1, Microsoft Dynamics CRM 2015, Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 3106337  

## Symptoms

When trying to open Microsoft Dynamics CRM Client for Outlook or when you try the offline synchronization process in the Microsoft Dynamics CRM client for Outlook with offline access, you might experience errors like the following:

> Outlook becomes unresponsive (flashing) and you have to terminate the process

Outlook will show an Error: There was no endpoint listening at `net.pipe://localhost/WebFormService/{random-guid-number}` that could accept the message. This is often caused by an incorrect address or SOAP action. See InnerException, if present, for more details.

## Cause

CRM client for Outlook leverages Windows Communication Foundation (WCF) to communicate with an off-process service to interface with CRM server. The WCF binding used is net.pipe that has a particular way of naming the underlying named pipe. Starting with WCF 4.0, The process of naming and registering the URI of the net.pipe endpoint is hierarchical and in two levels: non-administrative mode and administrative mode. If a process register the URI `net.pipe://localhost`, all non-administrative processes will not be able to access any other service with net.pipe binding including  that is the CRM local Web Form Service signature.

## Resolution

There is no solution as this is by design. WCF Services should not have a listener URI at `net.pipe://localhost/`. However there are two workarounds if the situation is true.

To find out which process is holding the listener at `net.pipe://localhost/`, follow the steps below:

- Load Sysinternals tool Handle ([Handle v4.22](/sysinternals/downloads/handle))
- Unzip Handle.zip into a folder (e.g: `c:\sysinternals`)
- Open cmd.exe as Administrator
- Move to the folder where you unzipped Handle.exe (for example, cd `c:\sysinternals`)
- Run this command:

    ```console
    handle "net.pipe:EbmV0LnBpcGU6Ly8rLw=="
    ```

- If there is a match, it will tell the executable name and PID as the sample output below:

    ```console
    StandAloneService.exe pid: 10724 type: Section 318: \BaseNamedObjects\net.pipe:EbmV0LnBpcGU6Ly8rLw==
    ```

## Workaround

- Workaround 1

  Find the file (or service) listening to `net.pipe://localhost` as specified earlier and stop it while you run Outlook.

- Workaround 2 (less recommended)

  If you launch Microsoft Dynamics CRM Clients for Outlook with local admin rights (right-click on **Outlook** and select **Run as Administrator**), the Microsoft Dynamics CRM Client for Outlook works as design and you can use the offline synchronization process with no errors.
