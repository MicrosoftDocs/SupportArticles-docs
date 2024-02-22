---
title: Unsecure redirect warning
description: Describes an issue that triggers an unsecure redirect warning message when you run the Get-FederationInformation cmdlet. Then, the Hybrid Configuration wizard doesn't finish successfully.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: rayfong, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Unsecure redirect warning when you run the Get-FederationInformation cmdlet

_Original KB number:_ &nbsp; 3115825

## Problem

When you run the `Get-FederationInformation` cmdlet for a particular domain, you receive an "unsecure redirect" warning message. For example, when you run the `Get-FederationInformation -DomainName contoso.mail.onmicrosoft.com` command, you receive the following warning:

> The autodiscovery request for federation information sent to
'`http://autodiscover.contoso.mail.onmicrosoft.com/autodiscover/autodiscover.xml`' returned an unsecure redirect to '`https://autodiscover-s.outlook.com/autodiscover/autodiscover.xml`'. If you trust `autodiscover-s.outlook.com` host name, you can continue to get the federation information. Do you want to continue?"
>
> [Y] Yes [A] Yes to All [N] No [L] No to All [?] Help (default is "Y"): y

If you select **Yes** or **Yes to All**, you see the rest of the message:

> RunspaceId : *RunspaceId*  
> TargetApplicationUri : outlook.com  
> DomainNames : {contoso.mail.onmicrosoft.com}  
> TargetAutodiscoverEpr : `https://autodiscover-s.outlook.com/autodiscover/autodiscover.svc/WSSecurity`  
> TokenIssuerUris : {urn:federation:MicrosoftOnline}  
> IsValid : True

Additionally, you can't successfully run and complete the Hybrid Configuration wizard to set up a hybrid deployment of on-premises Exchange Server and Exchange Online in Microsoft 365. The wizard cannot create the organization relationship.

## Cause

This issue occurs if one of the following conditions is true:

- The Autodiscover service connection point (SCP) object, **CN=Microsoft Exchange Online**, is missing.
- The Autodiscover SCP object, **CN=Microsoft Exchange Online**, exists, but its `serviceBindingInformation` property is missing the **\*.outlook.com** value.

## Solution

To resolve this issue, follow these steps.

> [!WARNING]
> These steps require Active Directory Service Interfaces Editor (ADSI Edit). Using ADSI Edit incorrectly can cause serious problems that may require you to reinstall your operating system. We can't guarantee that problems that result from the incorrect use of ADSI Edit can be resolved. Use ADSI Edit at your own risk.

1. Open ADSI Edit, and then connect to the Configuration container.
2. Determine whether the Autodiscover SCP object exists. It should be in the following location:

    CN=Microsoft Exchange Online,CN=Microsoft Exchange Autodiscover,CN=Services,CN=Configuration,DC=Contoso,DC=com

3. Do one of the following:
   - If the object exists, locate the `serviceBindingInformation` attribute, click **Edit**, and then add **\*.outlook.com**.
   - If the object doesn't exist, run Exchange Setup together with the `/prepareAD` parameter to re-create it, and then edit the `serviceBindingInformation` attribute. To do this, follow these steps:
     1. On the Exchange server, open a command prompt as an administrator, navigate to the folder where the installation files are stored, and then run the following command:

        ```console
        setup /prepareAD
        ```

        This step re-creates the SCP object. For more information, see [Prepare Active Directory and domains](/exchange/prepare-active-directory-and-domains-exchange-2013-help).

     2. Locate the serviceBindingInformation attribute, click **Edit**, and then add **\*.outlook.com**.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
