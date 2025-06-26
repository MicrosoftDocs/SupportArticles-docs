---
title: Newly created users can't sign in to a Lync client
description: Describes an issue that prevents newly created users from signing in to a Lync client. Provides a resolution.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: v-six
ms.reviewer: lynccic, corbinm, abgm
appliesto: 
  - Lync Server 2010 Enterprise Edition
  - Lync Server 2013
ms.date: 03/31/2022
---

# Newly created users can't sign in to a Lync client

## Symptoms

New users who were created in an existing Lync Server 2010 or 2013 environment can't sign in. In this situation, the following error message is logged in the UCCAPI logs:

```adoc
ms-diagnostics: 4005;reason="Destination URI either not enabled for SIP or does not exist";source="Lyncpool.domainname.com"
```

Additionally, the following event ID is logged:

```adoc
Log Name: Lync Server
Source: LS User Replicator
Event ID: 30061
Task Category: LS User Replicator
Level: Warning
Keywords: Classic
User: N/A
Computer: Description:
Failed to synchronize remote domain contoso.com due to missing data privacy boundary for local or remote domain. Source of replication is: AddressBookReplication.
Resolution:
This is usually caused when privacy boundary is not associated with local or remote site.
Event Xml:
<Event xmlns="http://schemas.microsoft.com/win/2004/08/events/event">
 <System>
 <Provider Name="LS User Replicator" />
 <EventID Qualifiers="33777">30061</EventID>
 <Level>3</Level>
 <Task>1009</Task>
 <Keywords>0x80000000000000</Keywords>
 <EventRecordID>1729319</EventRecordID>
 <Channel>Lync Server</Channel>
 <Security />
 </System>
 <EventData>
 <Data>AddressBookReplication</Data>
 </EventData>
</Event>
Cause
Lync Server is deployed in Child domain or server / pool name naming convention has child and parent domain relationship.
```

## Cause

This issue occurs when the user replicator does not query all the available domains.

## Resolution

To resolve this issue, run the following command:

```powershell
Set-CsUserReplicatorConfiguration -Identity global -ADDomainNamingContextList $Null
```

This forces the user replicator to query all the available domains.

## References

For information about User Replicator configuration settings, see [Set-CsUserReplicatorConfiguration](/powershell/module/skype/Set-CsUserReplicatorConfiguration).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
