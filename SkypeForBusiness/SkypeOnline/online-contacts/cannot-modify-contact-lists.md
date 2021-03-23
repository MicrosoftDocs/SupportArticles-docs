---
title: Users can't modify contact lists in Lync 2010 and Lync for Mac 2011
description: Describes the condition where you cannot add, remove, or change contacts in Microsoft Lync 2010 and Lync for Mac 2011 after you upgrade to Microsoft Lync Server 2013. Provides a resolution and a workaround.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
- Lync for Mac 2011
- Lync 2010
---

# Users are unable to modify their contact lists in Lync 2010 and Lync for Mac 2011

## Problem

When you try to edit your contacts in Lync 2010 or Lync for Mac 2011, you receive one of the following error messages:

```adoc
Cannot add, move, or remove contacts or groups at this time. Please try again later.
```

```adoc
Your contact list cannot be edited in UCS mode using Microsoft Lync for Mac. Please contact your system administrator.
```

## Solution

To resolve this issue, the Lync admin should use the **Invoke-CsUcsRollback** cmdlet to roll the user back from Unified Contact Store (UCS) mode.

Notes

- If your users will be using Lync 2010 or Lync for Mac 2011 as their primary client, then run the cmdlet.   
- If you use this cmdlet with the **-force** switch, you run the risk of disconnecting your users from their contacts.   

For more information about the **Invoke-CsUcsRollback** cmdlet, see [Roll back migrated users in Lync Server 2013](/previous-versions/office/lync-server-2013/lync-server-2013-roll-back-migrated-users).

## Workaround

To work around this issue, use Lync 2013, Outlook Web Access 2013, or Outlook to change your contact list.

Or, you can roll back the user's contacts to Lync Server and users will then be able to change their contact list. To do this, see [Lync contact list is empty or read-only after a user's Exchange mailbox is disconnected, unlicensed, or moved](https://support.microsoft.com/help/2811654). 

## More Information

On Windows, to confirm if a user is enabled for the UCS, right-click the Lync icon in the notification area to open the **Lync Configuration Information** screen. Look for the **Contact List Provider** line. Either **UCS** or **Lync Server** appears.

This issue occurs because the user's contact list was migrated to the Exchange UCS. This is a new integration feature of Exchange Server 2013 and Lync Server 2013. After the migration, the user's contact list provider changes from **Lync Server** to **UCS**.

Even though Lync 2010 and Lync for Mac 2011 can read the UCS contact list, they can't change contacts or groups in the UCS. Therefore, users who are enabled for the UCS can't change their contacts list from Lync 2010 and Lync for Mac 2011.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).