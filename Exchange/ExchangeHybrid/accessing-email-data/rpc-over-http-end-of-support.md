---
title: RPC over HTTP reaches end of support in Office 365 on October 31, 2017
description: Explains that RPC over HTTP in Office 365 will be deprecated on October 31, 2017. Contains information about why RPC over HTTP is being replaced by MAPI over HTTP and describes actions that Office 365 customers may have to take.
author: simonxjx
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
appliesto:
- Exchange Online
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
- Microsoft Office Outlook 2007
---

# RPC over HTTP reaches end of support in Office 365 on October 31, 2017

## Introduction 

As of Oct 31, 2017, RPC over HTTP will no longer be a supported protocol for accessing mail data from Exchange Online. Microsoft will no longer provide support or updates for Outlook clients that connect through RPC over HTTP, and the quality of the mail experience will decrease over time. 

RPC over HTTP is being replaced by MAPI over HTTP, a modern protocol that was launched in May 2014. This change affects you if you're running Outlook 2007 because Outlook 2007 won't work with MAPI over HTTP. To avoid being in an unsupported state, Outlook 2007 customers have to update to a newer version of Outlook or use Outlook on the web. 

This change may also affect you if you're running Outlook 2016, Outlook 2013, or Outlook 2010 because you must regularly check that the latest cumulative update for the version of Office that you have is installed. 

## More information

### What is RPC over HTTP? What happens on October 31, 2017?

RPC over HTTP, also known as Outlook Anywhere, is a legacy method of connectivity and transport between Outlook for Windows and Exchange. In May 2014, Microsoft introduced MAPI over HTTP as a replacement for RPC over HTTP.

Starting on October 31, 2017, RPC over HTTP will no longer be a supported protocol for accessing mail data from Exchange Online. Starting on this date, the following conditions will apply: 
 
1. Microsoft will not provide support for RPC over HTTP issues (regular or custom).    
2. No code fixes or updates to resolve problems that are unrelated to security will be released.    
 
Additionally, for Office versions that support MAPI over HTTP, Microsoft may elect to ignore existing registry keys that customer are using in order to force RPC over HTTP use. 

### Why is RPC over HTTP being replaced by MAPI over HTTP?

MAPI over HTTP offers the following benefits:

- Improves the connection resiliency when the network drops packets in transit.    
- Enables more secure sign-in scenarios, such as [multi-factor authentication for Office 365](https://support.office.com/article/set-up-multi-factor-authentication-for-office-365-users-8f0454b2-f51a-4d9c-bcde-2c48e41621c6).    
- Provides the extensibility foundation for third-party identity providers.    
- Removes the complexity of RPC over HTTP dependency on legacy RPC technology.    
 
### I'm using Office 365 with Outlook 2016, Outlook 2013, or Outlook 2010. What actions do I have to take?

Make sure that you use Outlook for Windows clients that are updated to work with MAPI over HTTP.

The best and recommended option is to move to the latest version of Office 2016 as part of Microsoft 365 Apps for enterprise. If you cannot move to Microsoft 365 Apps for enterprise by October 31, 2017, make sure that Office applications in your organization are updated by having the most recent cumulative update.

You should have at least the currently recommended minimum installation of Outlook updates installed for connecting to Exchange Online that uses MAPI over HTTP. To verify the current list, see the following Office article: 

[Outlook Updates](https://support.office.com/article/Outlook-Updates-472c2322-23a4-4014-8f02-bbc09ad62213) 

Additionally, you may have to make sure that Outlook clients aren't using a registry key to disable MAPI over HTTP. For more information, see the following Microsoft Knowledge Base article:
 
[2937684 ](https://support.microsoft.com/help/2937684)Outlook 2013 or 2016 may not connect using MAPI over HTTPs as expected 

### I'm using Office 365 with Outlook 2007 or an earlier version. What actions do I have to take?

MAPI over HTTP was not backported to Outlook 2007 or earlier versions. If you're using Outlook 2007, you will be in an unsupported state on October 31, 2017. If you want to continue to access Exchange Online mailboxes through the Office 365 portal ([portal.office.com](https://portal.office.com/)), we recommend that you move to a current version of Outlook that is under mainstream support,or use Outlook on the web.

Additionally, make sure that you don't have any Outlook add-ins or third-party apps that rely on the RPC over HTTP protocol to connect to Office 365 data. 

### How can I identify which Outlook version and build number my users are connecting with?

To retrieve this information, enable owner access auditing for each mailbox, and then query the audit log for the Outlook version that's used to log on to the mailbox. To do this, follow these steps: 
 
1. Connect to Exchange Online by using remote PowerShell. For more information, see [Connect to Exchange Online PowerShell](https://technet.microsoft.com/library/jj984289%28v=exchg.160%29.aspx).    
2. Enable mailbox auditing for the owner. To do this, run one of the following commands:

    - For one mailbox:   

        **Set-Mailbox -Identity user@contoso.com -AuditOwner MailboxLogin -AuditEnabled $true**      
    - For all mailboxes:    

        **Get-Mailbox | Set-Mailbox -AuditOwner MailboxLogin -AuditEnabled $true**       
     
3. Search the audit log. To do this, run one of the following commands:

   - For one mailbox:  

        **Search-MailboxAuditLog -Identity user@contoso.com -LogonTypes owner -ShowDetails | ? { $_.ClientInfoString -like "*Outlook*" }**      
    - For all mailboxes, and to export results to a .csv file:  

        **Get-Mailbox | Search-MailboxAuditLog -LogonTypes owner -ShowDetails | ? { $_.ClientInfoString -like "*Outlook*" } | select MailboxOwnerUPN,Operation,LogonType,LastAccessed,ClientInfoString | export-csv .\OutlookConnections.csv**      

        > [!NOTE]
        > Mailbox auditing may take up to 24 hours to become enabled. For more information, see [Exchange auditing reports](https://technet.microsoft.com/library/jj150497%28v=exchg.150%29.aspx).    
 
### How can I identify which users in my organization are connecting through RPC over HTTP?

Microsoft provides reporting on email application usage against Exchange Online in the Microsoft 365 admin center, as shown in the following screen shot. This reporting includes an exportable view of connections from clients that use RPC over HTTP.   
![A screenshot of the Email app usage page in Office 365 Admin center](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4046320_en_2) 

### Why is MAPI over HTTP not backported to Outlook 2007?

MAPI over HTTP was released after the end of [Mainstream Support for Office 2007](https://support.microsoft.com/lifecycle/search/?p1=8753). When RPC over HTTP reaches end of support on October 31, 2017, Office 2007 will be out of Extended Support. 

### Does this end of support affect Outlook for Mac, Outlook for iOS and Android, Outlook for Windows 10 Mobile, or Outlook on the web?

No. This change applies only to Outlook for Windows. 

### Does this end of support in Office 365 affect customers using Exchange Server 2007, Exchange Server 2010, Exchange Server 2013, or Exchange Server 2016?

No. Customers who use RPC over HTTP to connect Outlook for Windows and on-premises Exchange Server continue to do so. This change affects only customers who use Outlook for Windows to connect to Exchange Online mailboxes in Office 365.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/). 

## References

For more information about MAPI over HTTP, see the following resources: 
- Microsoft Exchange Team Blog article: [Outlook Connectivity with MAPI over HTTP](https://blogs.technet.microsoft.com/exchange/2014/05/09/outlook-connectivity-with-mapi-over-http/).    
- Microsoft TechNet: [MAPI over HTTP](https://technet.microsoft.com/library/dn635177%28v=exchg.150%29.aspx) and [RPC over HTTP](https://technet.microsoft.com/library/bb123741%28v=exchg.150%29.aspx).    
