---
title: You don't have sufficient permissions when remove or change distribution group
description: Describes an issue that triggers an error when you try to remove a distribution group or make a change to the group in Exchange Online or in on-premises Exchange Server. Provides two methods of resolution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - Exchange Online
  - CSSTroubleshoot
manager: dcscontentpm
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
ms.date: 01/24/2024
ms.reviewer: v-six
---
# (You don't have sufficient permissions) error when you try to remove or make a change to a distribution group

## Problem

You try to remove or make a change to a distribution group by using the Exchange admin center in Microsoft Exchange Online for Microsoft 365 or in on-premises Microsoft Exchange Server. In this situation, you receive the following error message: You don't have sufficient permissions. This operation can only be performed by a manager of the group.

## Cause

This issue occurs if you're not a manager of the group. In this situation, you're not listed in the ManagedBy attribute.

## Solution 1: Use Exchange Online PowerShell or the Exchange Management Shell

> [!IMPORTANT]
> You have to be an Exchange Online admin, an Exchange admin, or a member of the "Security Group Creation and Membership" role in the Exchange admin center to perform this procedure.

1. Take one of the following actions, as appropriate for your situation:
   - Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   - On Exchange Server in your on-premises environment, open the Exchange Management Shell.

2. Make the change that you want to the distribution group by using the appropriate Windows PowerShell cmdlet.

   For example, to remove the distribution group, use the `Remove-DistributionGroup` cmdlet together with the `BypassSecurityGroupManagerCheck` parameter. Here's an example:

   ```powershell
   Remove-DistributionGroup <NameOfGroup> -BypassSecurityGroupManagerCheck
   ```

   > [!NOTE]
   > In this cmdlet and in other cmdlets in the [Examples](#examples) section, the distribution group is represented by the placeholder <*NameOfGroup*>.

### Examples

Here are some more examples of other Windows PowerShell cmdlets that you can use to manage distribution groups:

- To assign ownership of a group, use the `Set-DistributionGroup` cmdlet, as in the following example:

    ```powershell
    Set-DistributionGroup <NameOfGroup> -ManagedBy "Admin@contoso.com" -BypassSecurityGroupManagerCheck
    ```

- To add a user to a group, use the `Add-DistributionGroup` cmdlet, as in the following example:

    ```powershell
    Add-DistributionGroupMember -Identity <NameOfGroup> -Member user@contoso.com
    ```

- To remove a user from a group, use the `Remove-DistributionGroup` cmdlet, as in the following example:

    ```powershell
    Remove-DistributionGroupMember -Identity <NameOfGroup> -Member user@contoso.com
    ```

- To check the members list for a group, use the `Get-DistributionGroupMember` cmdlet, as in the following example:

    ```powershell
    Get-DistributionGroupMember -identity <NameOfGroup>|fl DisplayName,WindowsLiveID,RecipientType
    ```

## Solution 2: Add yourself to the `ManagedBy` attribute

To add yourself to the `ManagedBy` attribute, follow these steps:

1. Take one of the following actions, as appropriate for your situation:
   - Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online using Remote PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
   - On Exchange Server in your on-premises environment, open the Exchange Management Shell.

2. Run the following command:

    ```powershell
    Set-DistributionGroup <group> -ManagedBy @{Add="<value1>", "<value2>", …} -BypassSecurityGroupManagerCheck
    ```

    For example, if you're an Exchange Online admin or an Exchange admin who isn't listed in the `ManagedBy` attribute and you want to make changes to a distribution group that's named Accounting, run the following command to add yourself to the `ManagedBy` attribute:

    ```powershell
    Set-DistributionGroup Accounting -ManagedBy @{Add="<Alias>"} -BypassSecurityGroupManagerCheck
    ```

    After you do this, you'll be able to change the distribution group.

For more information about the `Set-DistributionGroup` cmdlet, see [Set-DistributionGroup](/powershell/module/exchange/set-distributiongroup).

## References

To learn about managing distribution groups that are synced to Microsoft 365 from the on-premises environment, see [Owners of an on-premises distribution group synced to O365 can't manage the distribution group in Exchange Online](../../ExchangeHybrid/groups-and-distribution-lists/cannot-manage-dg.md).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).
