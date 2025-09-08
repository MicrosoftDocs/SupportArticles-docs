---
title: Cannot view free/busy information for a remote user
description: Describes an issue in which a user can't view the free/busy information for a remote user in a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Calendaring
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jmartin, rayfong, austinmc, wduff, jhayes, timothyh, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# User can't view free/busy information for a remote user in a hybrid deployment of Exchange Server

_Original KB number:_ &nbsp; 2667844

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

## Symptoms

You have a hybrid deployment of on-premises Microsoft Exchange Server and Microsoft Exchange Online in Microsoft 365 in which your hybrid server is running Exchange Server 2010. However, users can't view free/busy information for a remote user. When a user tries to view free/busy information for a remote user, the free/busy information isn't displayed. Instead, the user may experience one or more of the following symptoms:

- The free/busy information for the remote user is displayed as number sign (#) characters in the Calendar.
- In Outlook Web App, "error 5037" is displayed.
- The Microsoft Outlook \<FileName>-fb.log and \<FileName>-as.log files contain an error message that resembles the following:

  > \<FreeBusyResponse>\<ResponseMessage ResponseClass="Error">\<MessageText>The caller does not have access to free/busy data.\</MessageText>\<ResponseCode>ErrorNoFreeBusyAccess\</ResponseCode>\<DescriptiveLinkKey>0\</DescriptiveLinkKey>\<MessageXml>\<ExceptionType
xmlns="`http://schemas.microsoft.com/exchange/services/2006/errors`">Microsoft.Exchange.InfoWorker.Common.Availability.NoFreeBusyAccessException\</ExceptionType>\<ExceptionCode
xmlns="`http://schemas.microsoft.com/exchange/services/2006/errors`">5037\</ExceptionCode>\<ExceptionServerName
xmlns="`http://schemas.microsoft.com/exchange/services/2006/errors`"> *ServerName*\</ExceptionServerName>\<ResponseSource
xmlns="`http://schemas.microsoft.com/exchange/services/2006/errors`">`https://\<Server>.outlook.com/EWS/Exchange.asmx/WSSecurity`\</ResponseSource>\</MessageXml>\</ResponseMessage>\<FreeBusyView>\<FreeBusyViewType
xmlns="`http://schemas.microsoft.com/exchange/services/2006/types`">None\</FreeBusyViewType>\</FreeBusyView>\</FreeBusyResponse>

For example, a Microsoft 365 user can't view free/busy information for an on-premises user. However, other users can view free/busy information for that same on-premises user.

## Cause

This issue occurs if the domain name for the Simple Mail Transfer Protocol (SMTP) address of the user who is trying to view the free/busy information isn't included among the domain names in the organization relationship. For example, when you run the Test-OrganizationRelationship cmdlet, the following output is displayed:

> RunspaceId : a6c3799f-2ecd-4d79-ae4b-6c470ddd1dee  
Identity :  
Id : LocalFederatedDomainsAreMissingFromTheRemoteOrganizationRelationsipDomains  
Status : Warning  
Description : There are locally federated domains that aren't present in the list of domains for the remote organization relationship object.  
IsValid : True

This occurs if the SMTP domain wasn't manually added to the organization relationship. This may also occur if the following conditions are true:

- The Microsoft 365 user account was created before you upgraded the on-premises environment to Exchange Server 2010.
- You used the Hybrid Configuration wizard in Exchange Server 2010 in the on-premises environment to set up the federation trust. For example, the domain name of the Microsoft 365 user is `contoso.com`.

In this scenario, the Microsoft 365 user account doesn't have `@contoso.mail.onmicrosoft.com` as one of its proxy addresses. The request to the on-premises environment uses `@contoso.com` instead of `@contoso.mail.onmicrosoft.com` for the Microsoft 365 user account. The request is rejected because the organization relationship in the on-premises environment doesn't have `contoso.com` added to it.

## Resolution

To resolve this issue, edit the organization relationship in the on-premises environment to include the SMTP domain of the user who is experiencing the issue. To do this, use one of the following methods.

### Method 1: Use Exchange Management Console

1. On the on-premises Exchange server, open Exchange Management Console, and then select **Organization Configuration** under **Microsoft Exchange On-Premises**.
2. Select the **Organization Relationships** tab, and then view the properties of the organization relationship.
3. Select the **External Organization** tab, type the federated domain name in the **Federated domains of the external Exchange organization** box, and then select **Add**.
4. Repeat step 3 for each domain that you want to add.
5. Select **OK**.

### Method 2: Use Exchange Management Shell

1. On the on-premises server, open Exchange Management Shell.
2. Set up the organization relationship as a variable. For example, run the following command:

    ```console
    $OrgRel = Get-OrganizationRelationship Contoso
    ```

3. Add the additional domain names that you want to the variable. For example, run the following command:

    ```console
    $OrgRel.DomainNames += "contoso.com"
    ```

4. Update the organization relationship by using the new domain names value. For example, run the following command:

    ```powershell
    Set-OrganizationRelationship $OrgRel.Name -DomainName $OrgRel.DomainNames
    ```

## More information

To help identify the issue in Microsoft 365, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Compare the SMTP address of the user with the organization relationship. To do this, run the following command:

    ```console
    if ( (Get-OrganizationRelationship).DomainNames -contains (Get-Mailbox user).PrimarySmtpAddress.Split("@")[1]) { write-host "The domain was found" -ForegroundColor Green } else { write-host (Get-Mailbox user).PrimarySmtpAddress.Split("@")[1] "was not found" -ForegroundColor Yellow}
    ```

    > [!NOTE]
    > You can also compare each domain that is listed in the accepted domains with the domain names that are in the organization relationship. To do this, run the following command:

    ```powershell
    Get-AcceptedDomain | ForEach-Object { if ( (Get-OrganizationRelationship).DomainNames -contains $_.DomainName) { write-host $_.DomainName "was found" -ForegroundColor Green } else { write-host $_.DomainName "was not found" -ForegroundColor Yellow} }
    ```

Still need help? Go to [Microsoft Community](https://answers.microsoft.com) or the [Exchange TechNet Forums](/answers/topics/office-exchange-server-itpro.html).

[Start the guide to troubleshoot this issue](https://support.microsoft.com/help/10092).
