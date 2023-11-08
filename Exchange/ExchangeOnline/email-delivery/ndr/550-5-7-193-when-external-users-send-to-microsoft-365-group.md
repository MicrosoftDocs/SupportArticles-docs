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
ms.date: 11/08/2023
---

# NDR 550 5.7.193 when external users send email to Microsoft 365 group

## Symptoms

An external sender receives the following non-delivery report (NDR) when they send an email message to a Microsoft 365 group:

> The group \<group name\> isn't set up to receive messages from \<sender name\>.
> More Info for Email Admins
> Status code: 550 5.7.193
> 550 5.7.193 UnifiedGroupAgent; Delivery failed because the sender isn't a group member or external senders aren't permitted to send to this group.

## Cause

The Microsoft 365 group isn't configured to accept email messages from external senders.

## Resolution

To configure a group to accept email messages from external senders, use either of the following procedures. The procedure you choose depends on whether you are an administrator or the group owner.

### Method for group owner

1. Open the [Microsoft Outlook Groups hub](https://outlook.office.com/people/group/owner).

2. Select the group and then select **Edit** from the menu bar to open the **Edit group** dialog.

3. In the **Edit group** dialog, select **Let people outside the organization email the groups**.

4. Select **Save**.

### Method for administrator

Use either the Exchange admin center (EAC) or Exchange Online PowerShell.

**EAC**

1. Navigate to **Recipients** \> **Groups** and then select the relevant group to open the group details pane.

2. In the details pane, select **Settings**.

3. On the **Settings** tab, select **Allow external senders to email this group**.

4. Select **Save**.

**Note**: Exchange Online can take up to one hour to apply the new setting.

**PowerShell**

1. Run the following command to connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell):

```PowerShell
Connect-ExchangeOnline
```

2. Run the following command to configure the group to receive mail from unauthenticated (external) senders:

```PowerShell
Set-UnifiedGroup -Identity <group name or SMTP address> -RequireSenderAuthenticationEnabled $False
```
