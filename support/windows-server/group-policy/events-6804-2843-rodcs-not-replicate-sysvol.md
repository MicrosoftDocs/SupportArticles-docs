---
title: RODCs don't replicate SYSVOL shared directory
description: Discusses an issue in which Events 6804 and 2843 are logged and RODCs do not replicate SYSVOL when DFSR is used. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:Group Policy\Sysvol access or replication issues, csstroubleshoot
---
# Events 6804 and 2843 are logged and RODCs do not replicate SYSVOL

This article provides a solution to an issue where events 6804 and 2843 are logged when read-only domain controllers (RODC) don't replicate inbound the system volume (SYSVOL) shared directory.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 3212965

## Symptoms

One or more read-only domain controllers (RODC) do not replicate inbound the system volume (SYSVOL) shared directory. This issue occurs even though multiple inbound Active Directory connections are listed when Active Directory Sites and Services (Dssite.msc) is pointed at an affected RODC.

When this issue occurs, the following entry is logged in the DFSR event log:

> Log Name: DFS Replication  
Source: DFSR  
Event ID: 6804  
Level: Warning  
Keywords: Classic  
Description:  
The DFS Replication service has detected that no connections are configured for replication group Domain System Volume. No data is being replicated for this replication group.

Additionally, the following entry is logged in the Directory Service event log:

> Log Name: Directory Service  
Source: Microsoft-Windows-ActiveDirectory_DomainService  
Event ID: 2843  
Task Category: Knowledge Consistency Checker  
Level: Error  
Description:  
The Knowledge Consistency Checker was unable to locate a replication connection for the read-only local directory service. A replication connection with the following option must exist in the forest for correct FRS system behavior.
>
> Additional Data  
Option: 64  
User Action  
Restore the original replication connection for the local directory service instance on a writable directory service instance.

When this issue occurs, new RODCs that are promoted work correctly. Also, demoting and promoting an affected RODC fixes the issue.

> [!NOTE]
> Outbound replication also does not occur. However, this behavior is by design on an RODC.

## Cause

This issue occurs because an administrator has deleted the automatically generated "RODC Connection (FRS)" objects for these affected RODCs. This action may have been done for one of the following reasons:

- A customer notices that the connections are named "FRS" and, therefore, believes that the connections are no longer required because DFSR is replicating SYSVOL.
- The administrator created manual connection objects per local processes.RODCs require a special flag on their connection objects in order for SYSVOL replication to work. If the flag is not present, SYSVOL does not work for FRS or DFSR.

## Resolution

To resolve this issue, follow these steps:

1. Log on to a writeable DC in the affected forest as an enterprise administrator.
2. Start Dssite.msc.
3. Navigate to an affected RODC within its site, and scroll down to the **NTDS Settings** object.

    > [!NOTE]
    > There may be no connections listed here, or there may be manually created connections.

    :::image type="content" source="media/events-6804-2843-rodcs-not-replicate-sysvol/ntds-settings.png" alt-text="Find the NTDS Settings object in the Servers folder by expanding the Default-first-site-name folder under the Sites folder.":::

4. Create a connection object, and give it the same name as the default object. For example, name the object **RODC Connection (FRS)**.

    :::image type="content" source="media/events-6804-2843-rodcs-not-replicate-sysvol/create-connection-object.png" alt-text="Create a connection object together with the same name as the default object.":::

5. Edit the new connection in Adsiedit .msc or by using the Dssite.msc **Attribute Editor** tab. Navigate to the **options** attribute, and then enter **0x40** in the **Value** field.

    :::image type="content" source="media/events-6804-2843-rodcs-not-replicate-sysvol/edit-options-attribute.png" alt-text="Edit the Options' attribute in the Attribute Editor tab.":::

    :::image type="content" source="media/events-6804-2843-rodcs-not-replicate-sysvol/options-attribute-in-frs-properties.png" alt-text="Options' attribute shown in the Attribute Editor tab of the F R S properties dialog box." border="false":::

6. Repeat steps 4 and 5 to create more connections, as necessary.
7. Force Active Directory replication outbound from this DC to the RODCs, or wait for convergence to occur. When the DFSR service on the RODC sees these connections, SYSVOL begins to replicate again.

## About RT (NTDSCONN_OPT_RODC_TOPOLOGY, 0x00000040)

The NTDSCONN_OPT_RODC_TOPOLOGY bit in the options attribute indicates whether the connection can be used for DRS replication (MS-DRDM). When the connection is set, it should be ignored by DRS replication and used only by FRS replication.

> [!NOTE]
> The **0x40** value is required for both DFSR and FRS. Other connections for Active Directory replication are still required separately, and they exist on the RODC locally.

## References

[7.1.1.2.2.1.2.1.3 RODC NTFRS Connection Object](/openspecs/windows_protocols/ms-adts/6c846dd8-cbaf-43bb-8354-44cfd2195c4c)
