---
title: Dynamics CRM for Outlook support with multiple deployments
description: Describes an issue in which synchronized items may become untracked when you configure Microsoft Dynamics CRM for Outlook client by using different CRM deployments.
ms.reviewer: aaronric
ms.topic: article
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM for Outlook client support with multiple Microsoft Dynamics CRM deployments

This article describes a by design behavior that synchronized items may become untracked when you configure Microsoft Dynamics CRM for Outlook client by using different CRM deployments.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft Dynamics CRM 2013  
_Original KB number:_ &nbsp; 2939349

## Symptoms

If you have an email address that is configured on multiple clients and each client is configured for the Microsoft Dynamics CRM for Outlook client by using different CRM deployments, synchronized items may become untracked.

## Cause

This issue occurs because of each Microsoft Dynamics CRM deployment will try to synchronize their synchronized items and settings to the same mailbox. Each deployment will compete with one another to update their information on this mailbox. For example, if you have multiple tracked email messages from Microsoft Dynamics CRM deployment A, when Microsoft Dynamics CRM deployment B synchronizes with the same mailbox by using the settings from deployment B, it may untrack these email messages.

A scenario such as this might have occurred by using the same mailbox for a production Microsoft Dynamics CRM deployment and a development deployment. In this case, you would have to remove the configuration for one of the deployments or use a separate mailbox for one of the deployments.

## More information

This would be expected and is an unsupported configuration for the Outlook client.
