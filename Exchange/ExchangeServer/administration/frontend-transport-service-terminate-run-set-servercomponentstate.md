---
title: Event 7031 when you run Set-ServerComponentState or the DAG maintenance scripts
description: The Exchange transport service crashes and logs event 7031 if you run the Set-ServerComponentState cmdlet on the ServerWideOffline server component. This issue also occurs if you run the DAG maintenance scripts.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Performance Issues
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11987
ms.reviewer: jaburn, ninob, marcn, v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/03/2026
---

# The Exchange Frontend Transport service terminates unexpectedly when you run Set-ServerComponentState

_Original KB number:_ &nbsp;4043629

## Summary

The Microsoft Exchange Frontend Transport service can terminate unexpectedly and log event 7031. This issue occurs when you run the `Set-ServerComponentState` cmdlet on the `ServerWideOffline` server component or when you run the DAG maintenance scripts.

## Symptoms

The Microsoft Exchange Frontend Transport service crashes when you do one of the following things:

- Run the `Set-ServerComponentState` PowerShell cmdlet on the `ServerWideOffline` server component.
- Run the Exchange Server DAG Maintenance scripts.

When the problem occurs, the Service Control Manager logs event 7031:

```console
Log Name: System  
Source: Service Control Manager  
Description:  
The Microsoft Exchange Frontend Transport service terminated unexpectedly. It has done this 1 time(s). The following corrective action will be taken in 5000 milliseconds: Restart the service.
```

## Set-ServerComponentState examples that cause the Frontend Transport service to quit unexpectedly

```powershell
`Set-ServerComponentState -Identity <ServerName> -Component ServerWideOffline -State Inactive -Requester Maintenance`
```

```powershell
`Set-ServerComponentState -Identity <ServerName> -Component ServerWideOffline -State Active -Requester Maintenance`
```

```powershell
`Set-ServerComponentState -Identity <ServerName> -Component ServerWideOffline -State Inactive -Requester Functional`
```

The first two commands are included in the Exchange DAG Maintenance scripts. You encounter this issue by design when you run the scripts.

## Resolution

This issue occurs by design.

When the server component state returns to `active` the system returns to its original behavior. You can manually restore the component state to `active` to reset the system.
