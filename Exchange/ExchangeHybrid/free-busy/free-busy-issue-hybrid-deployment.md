---
title: Free/busy issues in a hybrid deployment of Exchange Server
description: Describes how to troubleshoot free/busy issues that occur in a hybrid deployment of on-premises Exchange Server and Exchange Online in Office 365.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: exchange-server-it-pro
ms.topic: article
ms.author: v-six
---

# How to troubleshoot free/busy issues in a hybrid deployment of on-premises Exchange Server and Exchange Online in Office 365

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Office 365 Hybrid Configuration wizard. For more information, see [Office 365 Hybrid Configuration wizard for Exchange 2010](https://blogs.technet.com/b/exchange/archive/2016/02/17/office-365-hybrid-configuration-wizard-for-exchange-2010.aspx). 

## Introduction 

This article describes how to troubleshoot free/busy problems that occur in a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Office 365. 

## More information

[Start the guide to troubleshoot the issue](https://support.microsoft.com/help/10092/troubleshooting-free-busy-issues-in-exchange-hybrid-environment).

For more information about how deploy Exchange federation, go to the following Microsoft website:

[Configure federated sharing](https://docs.microsoft.com/exchange/configure-federated-sharing-exchange-2013-help) 
 
After you set up Exchange federation, you may experience one or more of the following issues:

- Free/busy information can't be retrieved from any account in either environment.    
- Free/busy information can't be retrieved from one environment.    
- Free/busy information can't be retrieved from an on-premises account by using a cloud account.    
- Free/busy information can't be retrieved from a cloud account by using an on-premises account.    
- Free/busy information is unavailable in a hybrid deployment scenario between Exchange Online and an on-premises Exchange Server 2003 organization or a mixed on-premises Exchange Server 2003 and Exchange Server 2007 organization.    
- Cloud mailboxes can't see the free/busy information for on-premises mailboxes.     
 
### Free/busy information can't be retrieved from any account in either environment
 
Users in either environment in the Exchange federated organization can't retrieve free/busy information from mailboxes that are located in the other environment.

In this case, the problem may be that Outlook isn't up-to-date or that Exchange federation may not be set up correctly.

To help troubleshoot this issue, ask users to determine whether the issue occurs when they use Microsoft Outlook and when they use Outlook on the web (formerly known as Outlook Web App) for Office 365. If the behavior differs in Outlook and Outlook on the web, the problem may be that the Outlook client doesn't meet the requirements for Exchange federation. Ask the user to follow these steps:

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com/)).    
2. Click **Settings**, and then click **Office 365**.    
3. Click **Software**, and then click **Install**.  

After the user sets up Office 365 desktop applications, the free/busy issue should be resolved.

If this problem occurs identically in Outlook and Outlook on the web, there's probably an issue regarding how Exchange federation is set up in your organization. In this case, see the [Microsoft Exchange Server Deployment Assistant](https://technet.microsoft.com/exchange/jj657516.aspx) to make sure that the environment meets the system requirements. 

### Free/busy information can't be retrieved from one environment
 
Users can't access free/busy information through Exchange federation in one specific direction. For example, on-premises users can't access free/busy information from cloud mailboxes. Or, cloud users can't access free/busy information from on-premises mailboxes.

In this scenario, the problem may be caused by a misconfiguration of the Application Target URI. Or, the sharing policies in the on-premises Exchange Server environment and in Exchange Online may not match.

To help troubleshoot this issue, follow these steps:

1. On an on-premises computer that's running Exchange Server, open the Exchange Management Shell.    
2. At the command line, type the following command, and then press Enter:   

    ```powershell
    Get-FederationInformation -domainname <Office 365 Domain>  
    ```

    In this command, the <Office 365 Domain> placeholder represents the default Office 365 domain (for example, contoso.onmicrosoft.com).
1. In the results, note the **TargetApplicationUri** and **TargetAutodiscoverEpr** values. These are the settings that the target domain must have to make sure that the federation trust is set up correctly. 
1. To display the trust information that is currently set up for the default Office 365 domain, run the following command:

    ```powershell
    Get-OrganizationRelationship | FL
    ```
1. In the **DomainNames** section, make sure that the following items are displayed:
   - The name of the company's service routing domain (for example, mail.contoso.onmicrosoft.com)    
   - The name of the company's federated domain (for example, contoso.com)    
 
    If these names aren't displayed in the **DomainNames** section, there may be a problem that affects the setup of Exchange federation. Review the [Microsoft Exchange Server Deployment Assistant](http://technet.microsoft.com/exchange/jj657516.aspx) to make sure that your configuration aligns to the recommended steps and that the environment meets all the system requirements. If the two domains are displayed correctly in the **DomainNames** section, note the following sections in the results:
    - **Name**    
    - **TargetApplicationUri**    
    - **TargetAutodiscoverEpr**    
 
    The **TargetApplicationUri** and **TargetAutodiscoverEpr** values should match the equivalent values from the Get-FederationInformation cmdlet. If the values don't match, run the following command to correct the difference:   

    ```powershell
    Set-OrganizationRelationship -Identity <Name> -TargetApplicationUri <TargetApplicationUri> -TargetAutodiscoverEpr <TargetAutodiscoverEpr>
    ```

6. If the free/busy problem persists, make sure that the sharing policies in the on-premises Exchange Server environment and in Exchange Online match. To determine this, run the following command in the Exchange Management Shell, and then note the value in the **Domains** field in the results:

    ```powershell
    Get-SharingPolicy | FL
    ```
1. Connect to Exchange Online by using Windows PowerShell to run the same test in the other environment. You do this so that you can determine whether the sharing policies match. For more information about how to connect to Exchange Online by using Windows PowerShell, go to the following Microsoft website: 

    [Connect to Exchange Online using remote PowerShell](https://docs.microsoft.com/exchange/configure-federated-sharing-exchange-2013-help)
1. After you connect to Exchange Online, run the following command in the Windows PowerShell window, as you did for the on-premises environment, and then note the value in the **Domains** field:

    ```powershell
    Get-SharingPolicy
    ```
1. The **Domains** values for the two environments should match. If they don't match, you can use the **Set-SharingPolicy** cmdlet to set up the **Domains** field so that it matches on both sides. For more information about the **Set-SharingPolicy** cmdlet and about how to use this sharing policy setting, go to the following Microsoft TechNet website: 

    [Set-SharingPolicy](https://docs.microsoft.com/powershell/module/exchange/sharing-and-collaboration/Set-SharingPolicy?view=exchange-ps)
 
### Free/busy information can't be retrieved from a cloud account by using an on-premises account
 
This problem is limited to on-premises users who try to retrieve free/busy information for cloud mailboxes.

First, make sure that the latest updates are installed on the server. For more information, see [Exchange Server Updates: build numbers and release dates](https://docs.microsoft.com/Exchange/new-features/build-numbers-and-release-dates?view=exchserver-2019).

If the issue persists, you can use the Test-FederationTrust cmdlet to collect more details about the failure. To do this, follow these steps:

1. In the Exchange Management Shell, run the following command, where the <OnPremisesMailbox> placeholder represents the email address of a user mailbox that's hosted in the on-premises environment:   

    ```powershell
    Test-FederationTrust -UserIdentity <OnPremisesMailbox> -verbose   
    ```
    
    > [!NOTE]
    > This command tests the federation trust token that's used by the on-premises user.
1. Assuming that the results contain at least one section in which the **Type** is **Failed**, copy the results into a text file, and then send the file to Exchange Online Services Support for more help.    
 
### Free/busy information can't be retrieved from an on-premises account by using a cloud account
 
The problem is limited to cloud users who try to retrieve free/busy information for on-premises mailboxes.

In this case, the mailboxes that are involved may be hosted on Exchange Server 2003 instead of on Exchange Server 2007 or Exchange Server 2010. Exchange Server 2003 doesn't support the Exchange Web Services requests that later versions use to obtain free/busy information. Make sure that any free/busy data that is held in Exchange Server 2003 public folders is being replicated to an Exchange Server 2010 mailbox server that can support a public folder database.

1. You can install the mailbox role on the same server on which the Client Access Server (CAS) role that you use to support federation is installed. For more information about how to do this by using the Microsoft Exchange Server Deployment Assistant, go to [Exchange Server Deployment Assistant.](https://technet.microsoft.com/exdeploy2010/default.aspx)    
2. If the cloud users still have problems when they try to retrieve free/busy information for on-premises mailboxes, determine whether there is a problem connecting to the Autodiscover service on-premises. To do this, follow these steps:

   1. Open the Microsoft Remote Connectivity Analyzer at the following Microsoft website: [https://www.testconnectivity.microsoft.com/?testid=OutlookAutoDisc](https://www.testconnectivity.microsoft.com/?testid=outlookautodisc)     
   2. On the Outlook Autodiscover page, complete the form by using the email address and the password of an account in the on-premises environment that has problems. Select the check box to confirm that you have the authority to enter the credentials of a working account.    
   3. To confirm that an automated program is making a request, you must complete a human interface challenge. Type the letters and numbers from the picture into the box, and then click **Perform Test**.    

3. If the test fails, check the settings for the on-premises proxy server and the firewall. Make sure that Exchange Online CAS can be accessed from the Internet over port 443.    
 
### Free/busy information is unavailable in a hybrid deployment between Exchange Online and an on-premises Exchange 2003 organization or a mixed on-premises Exchange 2003 and Exchange 2007 organization

In this scenario, the OU=EXTERNAL (FYDIBOHF25SPDLT) public folder is missing from the public folder hierarchy and must be added.

To add the OU=EXTERNAL (FYDIBOHF25SPDLT) public folder, follow these steps:

1. Connect to the on-premises Exchange 2010 public folder server from the public folder server.    
2. Open Windows PowerShell.    
3. Run the following command:
    
    ```powershell
    Add-PsSnapin Microsoft.Exchange.Management.Powershell.Setup
    ```     
4. Run the following command:

    ```powershell
    Install-FreeBusyFolder     
    ```  

### Cloud mailboxes can't see the free/busy information for on-premises mailboxes

When you run the **Get-OrganizationRelationship | FL** cmdlet in a remote PowerShell window that's connected to Exchange Online, the value of the **TargetSharingEpr** parameter must be set correctly. If this value is blank, null, or incorrect, cloud mailboxes cannot see free/busy information about on-premises mailboxes. 
To set the value, run the following command: 

```powershell
Get-OrganizationRelationship |Set-OrganizationRelationship -TargetSharingEpr "EWS address of organization"
```

For example, run the following command:  

```powershell
Get-OrganizationRelationship |Set-OrganizationRelationship -TargetSharingEpr "Https://mail.contoso.com/ews/exchange.asmx/WSSecurity"
```

## References 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).