---
title: Can't remove members that exceed the limit
description: Describes a problem that prevents you from using the Exchange admin center to remove members from a distribution group. Occurs because some members of that distribution group aren't listed when the group has more than 3000 members.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Can't use the Exchange admin center to remove members from a distribution group that has more than 3,000 members

_Original KB number:_ &nbsp; 3031293

## Problem

When you view a distribution group in the Exchange admin center, not all members are listed if that distribution group contains a large number of members. The Exchange admin center can display up to 3,000 members per distribution group.

If a distribution group contains more than 3,000 members, you can't use the Exchange admin center to remove members who aren't listed.

## Workaround

Use the `Remove-DistributionGroupMember` cmdlet instead of the Exchange admin center to remove members from a distribution group.

For example, to remove *roger@contoso.com* from a distribution group that's named Customer Service, follow these steps:

1. Do one of the following:

   - Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   - Open the Exchange Management Shell on an Exchange server in your on-premises environment.

2. Run the following command:

    ```powershell
    Remove-DistributionGroupMember -Identity "Customer Service" -Member roger@contoso.com
    ```

## More information

For more information about this cmdlet, see [Remove-DistributionGroupMember](/powershell/module/exchange/remove-distributiongroupmember).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
