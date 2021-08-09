---
title: Contacts are duplicated if you recreate a deleted contact
description: This article provides a resolution for the problem where contacts are duplicated in Microsoft Dynamics CRM if you recreate a deleted contact in Outlook. 
ms.topic: troubleshooting
ms.reviewer: mmaasjo
ms.date: 3/31/2021
---
# Contacts are duplicated in Microsoft Dynamics CRM if you recreate a deleted contact in Outlook

This article helps you resolve the problem where contacts are duplicated in Microsoft Dynamics CRM if you recreate a deleted contact in Outlook.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2508013

## Symptoms

You accidentally delete a tracked contact in Outlook and empty your deleted items folder.

You try to recreate the contact and relink it to the contact in Microsoft Dynamics CRM, but it creates a duplicate contact.

## Cause

The contact still exists in the `IDMappingTable` and is marked as `IsDeletedlocally = True`.

## Resolution

Reconfigure Microsoft Dynamics CRM for Microsoft Office Outlook and sync with Microsoft Dynamics CRM again. Contacts that were deleted in Outlook will be added back to the Outlook contact list.
