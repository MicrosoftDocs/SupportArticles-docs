---
title: You don't have sufficient permissions when remove or change distribution group
description: Describes an issue that triggers an error when you try to remove a distribution group or make a change to the group in Exchange Online or in on-premises Exchange Server. Provides two methods of resolution.
author: simonxjx
audience: ITPro
ms.service: exchange-online
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Exchange Server 2016 Enterprise Edition
- Exchange Server 2016 Standard Edition
- Exchange Server 2013 Enterprise
- Exchange Server 2013 Standard Edition
---

# "You don't have sufficient permissions" error when you try to remove or make a change to a distribution group

## Problem 

You try to remove or make a change to a distribution group by using the Exchange admin center in Microsoft Exchange Online for Microsoft Office 365 or in on-premises Microsoft Exchange Server. In this situation, you receive the following error message: You don't have sufficient permissions. This operation can only be performed by a manager of the group.

## Cause 

This issue occurs if you're not a manager of the group. In this situation, you're not listed in the ManagedBy attribute.

## Solution 

Use one of the following methods.

### Method 1: Use Exchange Online PowerShell or the Exchange Management ShellImportantYou have to be an Exchange Online admin, an Exchange admin, or a member of the "Security Group Creation and Membership" role in the Exchange admin center to perform this procedure. 

1. Take one of the following actions, as appropriate for your situation:
   - Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online using Remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.160%29.aspx).   
   - On Exchange Server in your on-premises environment, open the Exchange Management Shell.   
   
2. Make the change that you want to the distribution group by using the appropriate Windows PowerShell cmdlet.

   For example, to remove the distribution group, use the Remove-DistributionGroupcmdlet together with the BypassSecurityGroupManagerCheck parameter. Here's an example:Remove-DistributionGroup <NameOfGroup> -BypassSecurityGroupManagerCheck Note In this cmdlet and in other cmdlets in the "Examples" section, the distribution group is represented by the placeholder **<NameOfGroup>**.   

#### Examples

Here are some more examples of other Windows PowerShell cmdlets that you can use to manage distribution groups: 

- To assign ownership of a group, use the Set-DistributionGroupcmdlet, as in the following example:

    ```powershell
    Set-DistributionGroup <NameOfGroup> -ManagedBy "Admin@contoso.com" -BypassSecurityGroupManagerCheck
    ```    
- To add a user to a group, use the Add-DistributionGroupcmdlet, as in the following example:

    ```powershell
    Add-DistributionGroupMember -Identity <NameOfGroup> -Member user@contoso.com
    ```    
- To remove a user from a group, use the Remove-DistributionGroup cmdlet, as in the following example:

    ```powershell
    Remove-DistributionGroupMember -Identity <NameOfGroup> -Member user@contoso.com
    ```    
- To check the members list for a group, use the Get-DistributionGroupMember cmdlet, as in the following example:

    ```powershell
    Get-DistributionGroupMember -identity <NameOfGroup>|fl DisplayName,WindowsLiveID,RecipientType    
    ```

### Method 2: Add yourself to the "ManagedBy" attributeTo add yourself to the ManagedBy attribute, follow these steps:

1. Take one of the following actions, as appropriate for your situation:  
   - Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online using Remote PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.160%29.aspx).   
   - On Exchange Server in your on-premises environment, open the Exchange Management Shell.   
   
2. Run the following command:

    ```powershell
    Set-DistributionGroup <group> -ManagedBy @{Add="<value1>", "<value2>", …} -BypassSecurityGroupManagerCheck 
    ```
    For example, if you're an Exchange Online admin or an Exchange admin who isn't listed in the ManagedBy attribute and you want to make  changes to a distribution group that's named Accounting, run the following command to add yourself to the ManagedBy attribute:

    ```powershell
    Set-DistributionGroup Accounting -ManagedBy @{Add="<Alias>"} -BypassSecurityGroupManagerCheck
    ```

    After you do this, you'll be able to change the distribution group.

For more information about the Set-DistributionGroup cmdlet, see [Set-DistributionGroup](https://technet.microsoft.com/library/bb124955%28v=exchg.160%29.aspx).

## References 

To learn about managing distribution groups that are synced to Office 365 from the on-premises environment, see the following Microsoft Knowledge Base article:

[2417592](https://support.microsoft.com/help/2417592) Owners of an on-premises distribution group that's synced to Office 365 can't manage the distribution group in Exchange Online

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).