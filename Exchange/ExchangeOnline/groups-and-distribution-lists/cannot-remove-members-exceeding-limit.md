---
title: Can't use the Exchange admin center to remove members from a distribution group
description: Provides a workaround for when you're unable to remove a member of a distribution group by using the Exchange admin center. 
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: batre; ninob; vivepai
appliesto: 
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 11/08/2024
---
# Can't use the Exchange admin center to remove members from a distribution group

_Original KB number:_ &nbsp; 3031293

## Symptoms

When you use the Exchange admin center (EAC) to delete a member from a distribution group, you can't find the member in the list.

## Cause

The cause of the issue varies depending on whether you're using on-premises EAC or the EAC in Exchange Online.0

- In the EAC in Exchange Online, only a maximum of 1,000 members are displayed. If the distribution group contains more than 1,000 members, some members won't appear in the displayed list.
- In on-premises EAC, only a maximum of 3,000 members are displayed. If the distribution group contains more than 3,000 members, then not all members are displayed. In this scenario, you can't use the on-premises EAC to remove members who aren't displayed.

## Workaround

Use the workaround that's appropriate for your scenario.

**EAC in Exchange Online**:

If the member you want to remove isn't in the displayed list of 1,000 members, you can search for the member and then remove them.

**On-premises EAC**:

Use the [Remove-DistributionGroupMember](/powershell/module/exchange/remove-distributiongroupmember) cmdlet to remove members from a distribution group instead of the on-premises EAC.

For example, to remove *roger@contoso.com* from a distribution group that's named Customer Service, follow these steps:

1. Use one of the following options:

   - [Connect to Exchange Online by using remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   - Open the Exchange Management Shell on an Exchange server in your on-premises environment.

2. Run the following command:

    ```powershell
    Remove-DistributionGroupMember -Identity "Customer Service" -Member roger@contoso.com
    ```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
