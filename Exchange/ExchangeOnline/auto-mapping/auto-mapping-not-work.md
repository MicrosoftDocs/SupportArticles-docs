---
title: Auto-mapping doesn’t work as expected in an Office 365 hybrid environment
description: Describes an issue in which a mailbox can't map automatically in Office 365 hybrid environment. Provides a resolution.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: exchange-online
ms.topic: article
ms.author: v-six
---

# Auto-mapping doesn’t work as expected in an Office 365 hybrid environment

## Symptoms

In Microsoft Office 365, mailboxes aren’t automatically mapped together with their Microsoft Outlook profile after a mailbox is moved to another forest in a hybrid deployment. 

## Cause

There may be several different causes: 

- User is running an older version of Outlook.    
- Values don’t exist for the Active Directory (AD) attributes to enable auto-mapping.    
  
## Resolution

> [!NOTE]
> The auto-mapping feature is available only for Microsoft Exchange Online users.

### Overview of auto-mapping
 
In a non-hybrid deployment, auto-mapping is automatically enabled when a user is granted Full Access permissions to a mailbox by using the Add-MailboxPermission cmdlet or by using Exchange Admin Center (EAC). When these permissions are added, one value is added to the user and another to the mailbox to link the objects. 
 
- The mailbox that is permissioned: msExchDelegateListLink    
- The user who is being granted permissions: msExchDelegateListBL    
 
These properties can be viewed on-premises by using an Active Directory tool such as LDP or Active Directory Service Interfaces Editor (ADSI Edit). These properties are not displayed as attributes by using Exchange PowerShell cmdlets.

You can disable auto-mapping by using the AutoMapping parameter of Add-MailboxPermission. For more information about the AutoMapping parameter, see [Add-MailboxPermission](https://technet.microsoft.com/library/bb124097%28v=exchg.150%29.aspx).

### Hybrid auto-mapping scenarios
 
In some hybrid scenarios, additional steps are required for auto-mapping to work.

**Scenario 1: Permissions are in place before the user or mailbox is being moved to the cloud**

Example: John has full access permissions to the Sales mailbox. John’s mailbox is moved to the cloud.

Description: The auto-mapping attributes (msExchDelegateListLink/BL) will be synced by Azure Active Directory Sync (AAD Sync) to the cloud before the move. Microsoft Exchange Mailbox Replication Service (MRS) will also transfer any permissions during the move to the cloud.

Requirement: John must be running the May 2015 Public Update (PU) for Outlook 2010 or Outlook 2013 or a later update. Outlook update information is available at [Outlook Updates](https://technet.microsoft.com/library/dn803988%28v=office.14%29.aspx). 

**Scenario 2: Permissions are added after the user or mailbox is moved to the cloud**

Example: John is moved to the cloud. After the move, he requests Full Access permissions to the Sales mailbox on-premises.

Description: Permissions will be added to mailbox on-premises (Sales) by using Add-MailboxPermissions. Because John is a mail user in the on-premises environment, the auto-mapping attributes (msExchDelegateListLink/BL) will not be added. 

Requirement: 
 
1. These attributes have to be manually added to the on-premises mail user object to be synchronized to the cloud by AAD Sync. These attributes can be manually set by using the Add parameter of the Set-ADUser cmdlet in the Active Directory PowerShell module. For more information about these attributes, see [Set-ADUser](https://technet.microsoft.com/library/ee617215.aspx) and [Active Directory Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/ee617195.aspx).    
2. John must be running the May 2015 Public Update (PU) for Outlook 2010 or Outlook 2013 or a later update. Outlook update information is available at [Outlook Updates](https://technet.microsoft.com/library/dn803988%28v=office.14%29.aspx).    
   
### Troubleshooting auto-mapping

1. For a mailbox to be auto-mapped in a profile, the information has to be returned to Outlook in the Autodiscover XML. To check this as an affected user, follow these steps:  
   1. Start Outlook, and then hold down the Ctrl key while you right-click the Microsoft Outlook icon in the notification area.

        ![Screen shot of the Outlook icon ](https://support.microsoft.com/Library/Images/3080558.png)    
   2. Select **Test E-mail AutoConfiguration**.

        ![Screen shot of the Test E-mail AutoCongiguration option ](https://support.microsoft.com/Library/Images/3080559.png)    
   3. Clear the **Use Guessmart **and **Secure Guessmart Authentication** options, and then click **Test**.

       ![Screen shot of the Test E-mail AutoConfiguration page](https://support.microsoft.com/Library/Images/3080560.png)    
   4. When the test is finished, review the contents on the **XML** tab. Notice the values that are contained in the AlternativeMailbox tag.

        ```xml
        <AlternativeMailbox>
         <Type>Delegate</Type>
         <DisplayName>Sales</DisplayName>
         <LegacyDN>/o=contoso/ou=Exchange Administrative Group (FYDIBOHF23SPDLT)/cn=Recipients/cn=Sales</LegacyDN>
         <Server>**ServerName**</Server>
         </AlternativeMailbox>    
        ```
 
        > [!NOTE]
        > Archive mailboxes will be listed as an alternative mailbox of the type **Archive**.    
2. If the mailbox is listed in the AlternativeMailbox tag, make sure that the affected users are running the May 2015 Public Update (PU) for Outlook 2010 or Outlook 2013 or a later update. Outlook update information is available at [Outlook Updates](https://technet.microsoft.com/library/dn803988%28v=office.14%29.aspx).    
3. If the mailbox is not listed in the AlternativeMailbox tag, review the msExchDelegateListLink/BL properties on-premises by using a tool such as LDP or ADSI Edit.    
4. If the properties exist on the on-premises object, escalate to Microsoft for help. Provide the following information in the escalation:  
   - Output from the [Microsoft Support and Recovery Assistant (SaRa)](https://support.microsoft.com/help/4098558/how-to-scan-outlook-by-using-the-sara-tool) from the affected user.    
   - Output from the on-premises Active Directory service that displays the msExchDelegateListLink/BL properties for the user and mailbox.