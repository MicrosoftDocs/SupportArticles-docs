---
title: Prevent KCC from creating replication topology
description: Describes how to disable the Knowledge Consistency Checker functions that generate replication topology information for Active Directory Domain Services.
ms.date: 5/22/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:Active Directory\Active Directory replication and topology, csstroubleshoot
---
# Prevent the Knowledge Consistency Checker from creating replication topology

This article describes how to disable the Knowledge Consistency Checker to prevent it from automatically creating replication topology.

_Applies to:_ &nbsp; Windows Server (All supported versions)  
_Original KB number:_ &nbsp; 242780

## Summary

Knowledge Consistency Checker (KCC) is a component that automatically generates and maintains the intra-site and inter-site replication topology. For more information about the role and function of KCC, see [Active Directory Replication Concepts: KCC](/windows-server/identity/ad-ds/get-started/replication/active-directory-replication-concepts#BKMK_2).

You can disable the KCC's ability to generate either the intra-site topology management or the inter-site topology management, or both. 

## More information

KCC runs at regular intervals to adjust the replication topology information. In some situations, you might want to tailor the replication topology by manually creating replication connections. In that case, you have to turn off the corresponding KCC functions to prevent KCC from overwriting your manual changes. The control settings for KCC are part of the Active Directory Domain Services (AD DS) site configuration. The settings are in the **options** attribute of the site's **NTDS Settings** object. The following table lists the relevant values for **options**.

| Setting | Binary value | Decimal value | Description |
| --- | --- | --- | --- |
| NTDSSETTINGS_OPT_IS_AUTO_TOPOLOGY_DISABLED | 0x00000001 | 1 |Automatic topology generation is disabled. |
| NTDSSETTINGS_OPT_IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED | 0x00000010 |16 | Automatic inter-site topology generation is disabled. |
| NTDSSETTINGS_OPT_IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED<br/>and<br/>NTDSSETTINGS_OPT_IS_AUTO_TOPOLOGY_DISABLED | 0x00000011 | 17 | All automatic topology generation is disabled. |

For a full list of the flags and their bit values, see [6.1.1.2.2.1.1 NTDS Site Settings Object](/openspecs/windows_protocols/ms-adts/d300c652-8873-41a4-a50c-90cc89d5bdd8).

> [!NOTE]  
> When you disable the replication topology management function of KCC, you also disable the failure detection and rerouting function.

> [!IMPORTANT]  
> If you disable one or more of the KCC functions, you have to find alternative methods to perform the following tasks:
>
> - Monitor the network topology for changes that affect the topology information that's recorded in AD DS. Such changes include adding or removing sites or domain controllers. If such changes occur, update the AD DS topology information.
> - Monitor the replication status of existing connections between domain controllers to detect replication failures. If a connection is not working, and a threshold is reached, build temporary connections to other replication partners (if available) to make sure that replication isn't blocked.

To disable or re-enable one or more of the KCC functions, follow these steps:

1. Open Active Directory Sites and Services (*dssite.msc*, also available on the **Tools** menu in Server Manager).

1. Expand **Sites**, and then expand the site that you want to modify.

1. In the right-hand pane, right-click **NTDS Site Settings**, and then select **Properties**.

1. Select the **Attribute Editor** tab. In the **Attributes** list, select **options** and then select **Edit**.

1. In the **Value** box, enter the new value (*1*, *16*, or *17*).

   > [!NOTE]  
   > The new value overwrites the previous value. To preserve a previous setting, adjust the value that you enter accordingly. If you want to remove the previous setting and re-enable KCC, select **Clear**.

1. Select **OK**, and then select **Apply**.

   The **Attributes** list displays the new value of **options** in both text and binary format.

To quickly check the KCC configuration from the command line, open a Command Prompt window, and then run the following command:

```console
repadmin /showrepl <DomainControllerName> | find /i "site options"
```

> [!NOTE]  
> In this command, \<*DomainControllerName*> represents name of the domain controller that you want to query.

For more information about how to use `repadmin /showrepl`, see [Repadmin /showrepl](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc742066(v=ws.11)).

## Collecting data for Microsoft Support

If you need assistance from Microsoft support, we recommend that you collect the information by following the steps that are mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
