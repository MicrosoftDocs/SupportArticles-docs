---
title: Auto-apply retention label doesn't apply to messages 
description: Fixes an issue in which an auto-apply retention label that you have configured doesn't apply to items in a mailbox.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Retention
  - CI 163457
  - CSSTroubleshoot
ms.reviewer: cabailey, vipg, roygles, lindabr
appliesto: 
  - Exchange Online via Office 365 E Plans 
search.appverid: MET150
ms.date: 05/05/2025
---
# Auto-apply retention label doesn't apply to items in a mailbox

## Symptoms

You configure an [auto-apply retention label](/microsoft-365/compliance/apply-retention-labels-automatically) by using a query that contains specific words, phrases, or values of searchable properties. However, the label doesn't automatically apply to the items in a user's mailbox in your organization.

## Cause

This issue occurs for one or both of the following reasons:

- The user applied a personal tag to the items that should be auto-labeled or to folders that contain the items that should be auto-labeled.
- A messaging records management (MRM) policy applied a retention policy tag to folders that contain the items to be auto-labeled.

## Resolution

If the user applied a personal tag to the items or to folders that contain the items, remove the personal tag.

If an MRM policy applied a retention policy tag to folders that contain the items, [remove the retention policy tag](/exchange/security-and-compliance/messaging-records-management/add-or-remove-retention-tags) from the MRM retention policy.
