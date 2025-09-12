---
title: Still can reserve a meeting room even if it's reserved
description: Describes a Microsoft 365 issue in which the Calendar Attendant doesn't decline conflicting meeting requests for a room mailbox. A solution is included.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: sathyana, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Microsoft 365 users can reserve a meeting room even though it's already reserved for another meeting

_Original KB number:_ &nbsp; 3066068

## Symptoms

When a Microsoft 365 user tries to schedule a meeting in a room that's already reserved for another meeting, the Calendar Attendant doesn't automatically decline the conflicting meeting request.

## Cause

This issue occurs if the `AllRequestOutOfPolicy` property of the room mailbox is set to True. This causes the room mailbox to ignore conflicting meeting requests.

## Resolution

To resolve this issue, set the `AllRequestOutOfPolicy` property of the room mailbox to **False**. To do this, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Run the following command:

    ```powershell
    Get-CalendarProcessing -Identity "Meeting Room" | Set-CalendarProcessing -AllRequestOutOfPolicy $False
    ```

## More information

For more information about the Calendar Attendant in Microsoft 365, see:

- [Configure the Automated Booking policies for a resource mailbox](/previous-versions/office/exchange-server-2010/bb124542(v=exchg.141))
- [Enable or disable Automatic Booking on a resource mailbox](/previous-versions/office/exchange-server-2010/bb123495(v=exchg.141))

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
