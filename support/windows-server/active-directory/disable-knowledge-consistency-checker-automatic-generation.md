---
title: Disable KCC from creating replication topology
description: Describes how to disable the Knowledge Consistency Checker from automatically creating replication topology.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# How to disable the Knowledge Consistency Checker from automatically creating replication topology

This article describes how to disable the Knowledge Consistency Checker from automatically creating replication topology.

_Applies to:_ &nbsp; Windows Server (All supported versions)  
_Original KB number:_ &nbsp; 242780

## Summary

The Knowledge Consistency Checker (KCC) is a component that automatically generates and maintains the intra-site and inter-site replication topology. You can disable the KCC's automatic generation of intra-site or inter-site topology management, or both.

For additional information see: [KCC](https://learn.microsoft.com/windows-server/identity/ad-ds/get-started/replication/active-directory-replication-concepts#BKMK_2)

## More information

In some situations you may want to manually create replication connections to tailor the replication topology, but this increases the workload for monitoring for changes in the network topology described in Active Directory or replication failures occurring on domain controllers.

The KCC runs at regular intervals to adjust the replication topology for changes that occur in Active Directory, such as adding new domain controllers and new sites that are created. At the same time, the KCC reviews the replication status of existing connections to determine if any connections are not working. If a connection is not working, after a threshold is reached, KCC automatically builds temporary connections to other replication partners (if available) to insure that replication is not blocked.

> [!NOTE]
> When automatic replication topology management is disabled, the failover detection mentioned above is also disabled.
> ### How to Modify Active Directory to Disable KCC for a Site
> 1. Open Active Directory Sites and Services (*dssite.msc*)

1. Expand *sites*

1. Expand the site you wish to modify

1. In the right-hand pane, right click > *properties* on *NTDS Site Settings*

1. At the top select *Attribute Editor* tab, scroll and look and select the "options" attribute.

   > [!NOTE]
   > If the "options" attribute is present and the value is not 0, you need to determine the current flags that are set and use the values below to construct the new value before continuing to the next step.
1. Double click on the attribute or press the *Edit* button on the bottom left.

1. In the Values box, type the appropriate value:

  - To disable automatic intra-site topology generation, use value 1 (decimal).
  - To disable automatic inter-site topology generation, use value 16 (decimal).
  - To disable both intra-site and inter-site topology generation, use value 17 (decimal).
    
1. Click *Ok*, and then *Apply.*

> [!NOTE]
> To re-enable KCC generation, in the section above, in step 7 click on *Clear*.
To determine if these values are set correctly, you can use the same steps in the section above until reach step 5 (including).

Inspec the value to ensure the correct values were set previously.

> [!NOTE]
> NTDSSETTINGS_OPT_IS_AUTO_TOPOLOGY_DISABLED means that intra-site topology management is disabled, and NTDSSETTINGS_OPT_IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED means that inter-site topology management is disabled.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
