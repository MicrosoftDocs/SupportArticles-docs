---
title: Modify the default intra-site DC replication interval
description: Describes how to modify the default intra-site domain controller replication interval.
ms.date: 05/31/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, sagiv
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# How to Modify the Default Intra-Site Domain Controller Replication Interval

This article describes how to modify the default intra-site domain controller replication interval.

_Original KB number:_ &nbsp; 214678

When a domain controller writes a change to its local copy of Active Directory, a timer is started that determines when the domain controller's replication partners should be notified of the change. By default, this interval is 15 seconds. When this interval elapses, the domain controller initiates a notification to each intra-site replication partner that it has changes that need to be propagated. Another configurable parameter determines the number of seconds to pause between notifications. This parameter prevents simultaneous replies by the replication partners. By default, this interval is three seconds. Both of these intervals can be modified.

To change the delay between the change to Active Directory and the first replication partner notification, open the **Configuration** partition in the ADSIEdit tool and go to **CN=Partitions,CN=Configuration,DC=\<Forest Root Domain\>**. In the container, right-click the crossRef object of the directory partition you want to modify the replication settings.

**msDS-Replication-Notify-First-DSA-Delay** - The attribute controls the delay between changes to the Directory Services (DS) and the notification of the first replica partner for a naming context (NC). The interval is 15 seconds if the attribute isn't set.

**msDS-Replication-Notify-Subsequent-DSA-Delay** - The attribute specifies the delay between notifications of each subsequent replica partner for an NC. The interval is three seconds if the attribute isn't set.  
  
Alternatively, you can view and modify the notification timing settings of a specified directory partition using `Repadmin`.

To view the settings of the Contoso.com directory partition:

```console
repadmin /notifyopt <DomainControllerName> dc=contoso,dc=com
```

```output
Current Notification Options:
Replication-Notify-First-DSA-Delay is not set.
Replication-Notify-Subsequent-DSA-Delay is not set.
```

To update the settings of the Contoso.com directory partition:

```console
repadmin /notifyopt <DomainControllerName> dc=contoso,dc=com /first:<interval in seconds> /sub:<interval in seconds>
```

```output
Current Notification Options:
Replication-Notify-First-DSA-Delay is not set.
Replication-Notify-Subsequent-DSA-Delay is not set.
New Notification Options:
Replication-Notify-First-DSA-Delay: <interval in seconds>
Replication-Notify-Subsequent-DSA-Delay: <interval in seconds>
```
