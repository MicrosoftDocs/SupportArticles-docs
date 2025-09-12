---
title: Outlook Web App address is out of date error
description: Describes an issue that returns an error message when a user tries to access Outlook Web App by using the on-premises URL in an Exchange hybrid deployment. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Hybrid
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: sathyana, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook Web App address \<URL> is out of date error when users try to access Outlook Web App

> [!NOTE]
> The Hybrid Configuration wizard that's included in the Exchange Management Console in Microsoft Exchange Server 2010 is no longer supported. Therefore, you should no longer use the old Hybrid Configuration wizard. Instead, use the Microsoft 365 Hybrid Configuration wizard that's available at [https://aka.ms/HybridWizard](https://aka.ms/hybridwizard). For more information, see [Microsoft 365 Hybrid Configuration wizard for Exchange 2010](https://techcommunity.microsoft.com/t5/exchange-team-blog/office-365-hybrid-configuration-wizard-for-exchange-2010/ba-p/604541).

_Original KB number:_ &nbsp; 2952804

## Symptoms

When users try to connect to Outlook Web App by using the on-premises URL in a hybrid deployment of on-premises Exchange Server and Exchange Online, they receive the following error message:

> "The Outlook Web App address `https://www.<DomainName>.com/owa` is out of date."

## Cause

This issue occurs if the `TargetOwaURL` parameter for the organization relationship isn't set correctly.

This parameter may not be set correctly for hybrid configurations that were created manually (such as in Exchange 2010 Service Pack 1 and earlier versions). The Hybrid Configuration Wizard sets this parameter correctly.

## Resolution

Make sure that the `TargetOwaURL` parameter is set correctly. To check whether this parameter is set correctly, open the Exchange Management Shell on the on-premises Exchange server, and then run the following command:

```powershell
Get-OrganizationRelationship | Set-OrganizationRelationship -TargetOwaURL http://outlook.com/owa/<domain>.mail.microsoft.com"
```

## More information

The `TargetOwaURL` parameter specifies the Outlook Web App URL of the external organization that's defined in the organization relationship. This parameter is used for Outlook Web App redirection in an Exchange hybrid deployment scenario. When this parameter is set, users in the organization can use their current Outlook Web App URL to access Outlook Web App in the external organization.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
