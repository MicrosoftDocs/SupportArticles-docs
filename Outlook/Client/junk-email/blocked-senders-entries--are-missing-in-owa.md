---
title: Blocked Senders entries are missing in OWA
description: Describes an issue in which some Blocked Senders entries in your Outlook client aren't listed on your Blocked Senders list in Outlook Web App. This issue concerns the presence of the @ sign in the domain entries for the Blocked Senders list.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tmoore, gregmans
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 01/30/2024
---
# Blocked Senders entries in Outlook are missing in Outlook Web App

_Original KB number:_ &nbsp; 3060496

## Symptoms

In Microsoft Outlook, certain domain entries that appear in the **Blocked Senders** list in the Outlook client may be missing when you view the same **Blocked Senders** list in Outlook Web App. These missing entries have not been moved to the Junk E-mail folder and are not otherwise filtered in Outlook Web App if Outlook is not running.

## Cause

This issue occurs if the **Blocked Senders** list domain entries were created through Outlook, and if they do not begin with the @ sign. For example, the following entries are displayed in the **Blocked Senders** list in both Outlook and Outlook Web App:

`@contoso.com`  
`@wingtiptoys.com`  

However, the following entries are displayed in the **Blocked Senders** list only in the Outlook client, not in Outlook Web App:

`contoso.com`  
`wingtiptoys.com`  

This behavior occurs because Outlook provides additional Blocked Senders functionality for the inclusion of subdomains when the @ sign is not present in the Blocked Senders domain entry. For example, although `@contoso.com` filters all senders who have `@contoso.com` in their email address, `contoso.com` also filters domain entries that resemble the following:

`subdomain1.contoso.com`  
`subdomain2.contoso.com`  
`subdomain3.contoso.com`

This helps prevent spam from being delivered to the Inbox when the subdomain portion of the email address has been randomized.

Subdomain filtering for a Blocked Senders domain is a client-side feature and is available only in Outlook, not through Outlook Web App on Exchange Server. Additionally, you can add a domain entry without an @ sign only in Outlook. Outlook Web App adds an @ sign if you try to create a domain entry without one.

## Resolution

When you add blocked senders through Outlook, include the @ sign at the beginning of the Blocked Senders domain entries that must be honored by Outlook Web App and Exchange Server.

To add a Blocked Senders domain in Outlook, follow these steps:

1. On the **Home** tab on the ribbon, select the Junk drop-down list.
2. Select **Junk E-mail Options**.
3. On the **Blocked Senders** tab, select **Add**.
4. Enter the domain entry that you want, and include an @ sign at the beginning of the entry if you want it to also appear in OWA, as in the following figure.

   :::image type="content" source="media/blocked-senders-entries--are-missing-in-owa/add-address-or-domain.png" alt-text="Screenshot of the Blocked sender Add dialog box." border="false":::

5. Select **OK**, and then select **OK** again to exit the **Junk E-mail Options** dialog box.
