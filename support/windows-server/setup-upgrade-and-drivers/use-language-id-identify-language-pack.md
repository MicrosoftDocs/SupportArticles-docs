---
title: Use language ID to identify language pack
description: Describes how to resolve the language ID to the name of the correct language pack to install.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, BOBQIN, herbertm
ms.custom: sap:installing-or-upgrading-windows, csstroubleshoot
---
# Using language IDs to identify language packs for AD DS and AD LDS domain controllers

This article describes how to resolve the language ID to the name of the correct language pack to install.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 324097

## Summary

You may notice that an event that resembles the following event is recorded on Active Directory Domain Services (AD DS) or Active Directory Lightweight Directory Services (AD LDS) domain controllers:

> Event Type:  
Error  
Event Source: NTDS ISAM  
Event Category: General  
Event ID:604  
Description:  
NTDS (248) Must install language support for language ID 0x411.

## More information

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756) in case problems occur.

You can identify the name of the correct language pack to install by looking up the language ID.

You can find the language ID in the Windows registry. To do it, start Registry Editor, and then look under the following registry subkey:  
    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NTDS\Language`

You can also search for the language ID in the [LCID-Locale Mapping Table](/openspecs/windows_protocols/ms-adts/a29e5c28-9fb9-4c49-8e43-4b9b8e733a05). For the example language ID (411) that is mentioned in the [Summary](#summary) section, the value indicates the Japanese language (listed as **0411** in the mapping table).

For information about which sort object identifiers (OIDs) the sort control uses, see [LDAP_SERVER_SORT_OID and LDAP_SERVER_RESP_SORT_OID](/openspecs/windows_protocols/ms-adts/6b7b93f1-7c1a-45c2-9544-c067b94bba20).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
