---
title: NDR 550 5.7.193 when external users send email to Microsoft 365 group
description: Provides a resolution for an issue in which external senders receive NDR 550 5.7.193 when they send an email message to a Microsoft 365 group.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 183937
ms.reviewer: batre, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# NDR 550 5.7.193 when external users send email to a Microsoft 365 group

## Symptoms

An external sender receives the following nondelivery report (NDR) when they send an email message to a group in Microsoft 365 Groups:

> The group \<group name\> isn't set up to receive messages from \<sender name\>.  
> More Info for Email Admins  
> Status code: 550 5.7.193  
> 550 5.7.193 UnifiedGroupAgent; Delivery failed because the sender isn't a group member  
> or external senders aren't permitted to send to this group.

## Cause

The Microsoft 365 group isn't configured to accept email messages from external senders.

## Resolution

To configure a group in Microsoft 365 Groups to accept email messages from external senders, use either of the following methods. The method that you choose depends on whether you're an administrator or the group owner.

### Method for group owner

1. Open the [Microsoft Outlook Groups hub](https://outlook.office.com/people/group/owner).

2. Select the group and then select **Edit** from the menu bar to open the **Edit group** dialog box.

3. In the **Edit group** dialog box, select **Let people outside the organization email the groups**.

4. Select **Save**.

### Method for administrator

Use either the Exchange admin center (EAC) or Exchange Online PowerShell.

#### EAC

1. Navigate to **Recipients** \> **Groups**, and then select the relevant group to open the group details pane.

2. In the details pane, select **Settings**.

3. On the **Settings** tab, select **Allow external senders to email this group**.

4. Select **Save**.

**Note**: Exchange Online can take up to one hour to apply the new setting.

#### PowerShell

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell) by running the following command:

   ```PowerShell
   Connect-ExchangeOnline
   ```

2. Configure the group to receive mail from unauthenticated (external) senders by running the following command:

   ```PowerShell
   Set-UnifiedGroup -Identity <group name or SMTP address> -RequireSenderAuthenticationEnabled $False
   ```
