---
title: UM-enabled mailbox migration to Exchange Online fails
description: Resolves an issue in which you cannot migrate a UM-enabled mailbox from on-premises Exchange Server to Exchange Online.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
appliesto:
- Exchange Online
- Microsoft Lync Online
- Skype for Business Online
---

# UM-enabled mailbox migration to Exchange Online fails

## Symptoms

When you try to migrate a Unified Messaging (UM)-enabled mailbox from on-premises Microsoft Exchange Server to Microsoft Exchange Online, the migration fails and returns an error message that resembles the following: 

```AsciiDoc
Mailbox '**USER**' in the source forest is currently enabled for Unified Messaging but it can't be enabled for Unified Messaging in the target forest for the following reason: Unified Messaging isn't available in the target forest. Please fix the problem or disable the mailbox for Unified Messaging before you try the operation again.
     + CategoryInfo          : InvalidArgument: (**USER**:MailboxOrMailUserIdParameter) [New-MoveRequest], RecipientTask
    Exception
     + FullyQualifiedErrorId : [Server=**Server**,RequestId=**RequestId**,TimeStamp=**TimeStamp**] [FailureCategory=Cmdlet-RecipientTaskException] xxxxxxxx,Microsoft.Exchange.Management.RecipientTasks.
   NewMoveRequest  
```

## Cause

This issue occurs because Exchange Online cannot find a valid target forest that you are trying to migrate to，or the user that you are trying to migrate does not have an Exchange Online Plan 2, Office 365 Enterprise E3, or Office 365 Enterprise E5 license assigned.

## Resolution

To resolve this issue, follow these steps:

1. Make sure that the user has an Exchange Online license. 

    > [!NOTE]
    > [Exchange Online Service Description](/office365/servicedescriptions/exchange-online-service-description/exchange-online-service-description) indicates that some mailbox plans don't include Voice Message Services (formerly known as UM). To resolve this issue, a license must be applied for a mailbox plan that includes Voice Message Services (Exchange Online Plan 2, Office 365 Enterprise E3 or Office 365 Enterprise E5 license).    
2. Verify that the value of the **LicenseReconciliationNeeded** property is **False**. To do this, run the following Microsoft Online Services Module for Windows PowerShell cmdlets in the given order:  
   - Connect-MsolService    
   - Get-MsolUser -UserPrincipalName**UPN** |fl LicenseReconciliationNeeded    

    > [!NOTE]
    > If the value is **True**, assign an Exchange Online license to the user account. Doing this operation resets the **LicenseReconciliationNeeded** property to **False** and enables the migration to continue.    
3. Map the UM mailbox policy on the cloud and on the on-premises Exchange-based server. To do this, follow these steps:  
   1. Run the following command in Exchange Online PowerShell:

        ```powershell
        Set-UMMailboxPolicy -identity "Office365UMPolicy" -SourceForestPolicyNames "OnPremisesUMPolicy"
        ```

    2. Run the following command in the on-premises Exchange Management Shell: 

        ```powershell
        Set-UMMailboxPolicy -identity "OnPremisesUMPolicy" -SourceForestPolicyNames "Office365UMPolicy"
        ```

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).