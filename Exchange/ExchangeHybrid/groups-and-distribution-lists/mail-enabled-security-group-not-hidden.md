---
title: Can't hide a mail-enabled security group
description: Fixes an issue in an Exchange hybrid deployment in which a mail-enabled security group isn't hidden from the GAL after directory synchronization.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: travr, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Mail-enabled security group isn't hidden from GAL after directory synchronization in a hybrid deployment

_Original KB number:_ &nbsp; 3205648

## Problem

You have an Exchange Online hybrid deployment. You want to hide a mail-enabled security group that was created in the on-premises Active Directory so that it's not available to Microsoft 365 users. However, after a directory synchronization, the security group is listed in the global address list (GAL) and visible to Microsoft 365 users.

## Cause

This problem occurs because the `msExchHideFromAddressLists` attribute of the security group is not set.

## Solution

To resolve this problem, follow these steps:

1. Set the `msExchHideFromAddressLists` attribute of the security group to **True**. To do this, follow these steps:

   1. Open **Active Directory Users and Computers**.
   2. Locate and then right-click the group object, select **Properties**, and then select the **Attribute Editor** tab.
   3. Locate the `msExchHideFromAddressLists` attribute, click **Edit**, and then change the value from **\<Not set>** to **True**.

2. Wait for directory synchronization to occur. Or, force directory synchronization.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
