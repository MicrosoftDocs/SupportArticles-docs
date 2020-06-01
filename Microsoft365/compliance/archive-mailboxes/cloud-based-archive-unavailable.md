---
title: (Your archive appears to be unavailable) in a hybrid deployment.
description: Describes a scenario in which users can't access a cloud-based archive mailbox by using Outlook Web App and can't update the archive mailbox in Outlook in a hybrid deployment. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: Office 365
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: chrisbur, jhayes
appliesto: 
- Exchange Online Archiving
- Exchange Online
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
- Exchange Server 2010 Enterprise
- Exchange Server 2010 Standard
search.appverid: MET150
---

# Error (Your archive appears to be unavailable) when you try to access a cloud-based archive mailbox in a hybrid deployment

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Office 365 Hybrid Configuration wizard that's available at [http://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 2860302

## Problem

A user experiences the following symptoms in a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Office 365:

- When the user tries to access a cloud-based archive mailbox by using Outlook Web App, the user receives the following error message:

   > Your archive appears to be unavailable. Try to access it again in 10 seconds. If you see this error again, contact your Help Desk.

- When the user tries to access the cloud-based archive mailbox by using Microsoft Outlook, the archive mailbox may be present in his or her profile. However, the user can't update the archive mailbox.

## Cause

This issue may occur if the root certificates on the Exchange hybrid server are missing or corrupted. These certificates are used to validate your on-premises Exchange environment.

## Solution

To resolve this issue, update the root certificates, and then rerun the Hybrid Configuration Wizard on the hybrid server. To do this, follow these steps.

These steps must be completed by an Office 365 administrator. If you are a user who is experiencing this issue, contact your administrator to resolve this issue.

### Step 1: Update the root certificates

To update the root certificates, run Windows Update on the Exchange hybrid server.

For more information about how to update root certificates for a particular version of Windows or about how to use Group Policy to distribute updates, see the following Microsoft Knowledge Base article:

> [931125](https://support.microsoft.com/help/931125) Windows Root Certificate Program members

### Step 2: Rerun the Hybrid Configuration Wizard

Rerun the Hybrid Configuration Wizard to update the deployment and resolve the issue. For more information about how to run the Hybrid Configuration Wizard, go to the following Microsoft websites:

- Exchange 2013: [Manage a Hybrid Deployment](https://technet.microsoft.com/library/jj200791%28v=exchg.150%29.aspx)
- Exchange 2010: [Manage a Hybrid Deployment](https://technet.microsoft.com/library/hh529933%28v=exchg.141%29.aspx)

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
