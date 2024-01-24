---
title: Use Ntdsutil to find and clean up
description: Discusses how to use Ntdsutil to find and clean up duplicate security identifiers.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-replication, csstroubleshoot
ms.subservice: active-directory
---
# Use Ntdsutil to find and clean up duplicate security identifiers

This article discusses how to use Ntdsutil to find and clean up duplicate security identifiers.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 816099

## Summary

This article describes how to check for and clean up or remove duplicate security identifiers (SIDs) in the SAM database.
Every security account, such as a user, group, or computer, has a unique SID. Access permissions are granted or denied to SIDs for resources, such as files, folders, printers, Microsoft Exchange mailboxes, Microsoft SQL Server databases, objects that are stored in Active Directory, and any data that is protected by the Windows Server security model.

A SID contains header information and a set of relative identifiers that identify the domain and the security account. In a domain, each domain controller can create accounts and issue a unique SID to every account. Every domain controller maintains a pool of relative IDs that is used to create SIDs. After 80 percent of the relative ID pool is consumed, the domain controller requests a new pool of relative identifiers from the relative ID operations master. Make sure the same pool of relative IDs is never allocated to different domain controllers, and prevents the allocation of duplicate SIDs. However, because it is possible (but rare) for a duplicate relative ID pool to be allocated, you have to identify those accounts that have been issued duplicate SIDs to prevent incorrect security from being applied.

Duplicate relative ID pools may occur if the administrator seizes the relative ID master role (RID master), while the original RID master is operational but temporarily disconnected from the network. In typical practice, the RID master role is assumed by just one domain controller after one replication cycle. However, before the role ownership is resolved, two different domain controllers might each request a new relative ID pool and be allocated the same relative ID pool.

### Start Ntdsutil

To start Ntdsutil, follow these steps:  

1. Select **Start** > **Run**.
2. In the **Open** box, type **ntdsutil**, and then press Enter. To access Help at any time, type `?` at the command prompt, and then press Enter.

### Look for a duplicate SID

To look for a duplicate SID, follow these steps:  

1. At the Ntdsutil command prompt, type **security account management**, and then press Enter.
2. To connect to the server that stores your Security Account Maintenance (SAM) database, type `connect to serverDNSNameOfServer`  at the SAM command prompt, and then press Enter.
3. At the SAM command prompt, type **check duplicate sid**, and then press Enter.

    > [!Note]
    > A display of duplicates appears.

### Clean up a duplicate SID

1. At the Ntdsutil command prompt, type **security account management**, and then press Enter.
2. Connect to the server that stores your Security Account Maintenance (SAM) database. At the SAM command prompt, type 'connect to serverDNSNameOfServer' and then press Enter.
3. At the SAM command prompt, type **cleanup duplicate sid**, and then press Enter.

    > [!Note]
    > Ntdsutil confirms the removal of the duplicate.
4. At the SAM command prompt, type **q**, and then press Enter.
5. After finished using Ntdsutil, type **q**, and then press Enter.  

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for Active Directory replication issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-ad-replication.md).
