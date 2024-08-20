---
title: Exchange Frontend Transport service terminated unexpectedly when running Set-ServerComponentState
description: Exchange transport service crashes with event 7031 logged when you run the Set-ServerComponentState cmdlet against the ServerWideOffline component.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Health set unhealthy
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: jaburn, ninob, marcn, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Event 7031 when you run Exchange maintenance scripts or Set-ServerComponentState

_Original KB number:_ &nbsp;4043629

## Symptoms

The Microsoft Exchange Frontend Transport service crashes when you do one of the following things:

- Run the `Set-ServerComponentState` cmdlet against the `ServerWideOffline` component.
- Run [Exchange 2013 DAG Maintenance scripts](https://gallery.technet.microsoft.com/office/Exchange-2013-DAG-3ac89826).

This problem occurs in the following products:

- Microsoft Exchange Server 2016
- Exchange Server 2013 with cumulative update (CU) 6 or a later CU

When the problem occurs, event 7031 is logged:

```console
Log Name: System  
Source: Service Control Manager  
Description:  
The Microsoft Exchange Frontend Transport service terminated unexpectedly. It has done this 1 time(s). The following corrective action will be taken in 5000 milliseconds: Restart the service.
```

## Set-ServerComponentState examples that end the Frontend Transport service

- `Set-ServerComponentState -Identity <ServerName> -Component ServerWideOffline -State Inactive -Requester Maintenance`

- `Set-ServerComponentState -Identity <ServerName> -Component ServerWideOffline -State Active -Requester Maintenance`

- `Set-ServerComponentState -Identity <ServerName> -Component ServerWideOffline -State Inactive -Requester Functional`

The first two commands are included in the [Exchange 2013 DAG Maintenance scripts](https://gallery.technet.microsoft.com/office/Exchange-2013-DAG-3ac89826). So you meet this problem when you run the scripts.

## Resolution

This issue is by design, because of code changes in Exchange Server 2016 and Exchange Server 2013 starting with CU6.
