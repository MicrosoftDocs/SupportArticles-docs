---
title: Domains can only exist in one organization relationship
description: Describes an issue in which you receive a Domains can only exist in one organization relationship error message when you run the Hybrid Configuration wizard.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: scotro, v-six
appliesto: 
  - Exchange Online
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# (The domains already exist in another organization relationship) error when running Hybrid Configuration wizard

_Original KB number:_ &nbsp; 3067526

## Symptoms

You want to set up a hybrid deployment between your on-premises Microsoft Exchange Server organization and Exchange Online in Microsoft 365. However, when you run the Hybrid Configuration wizard, the wizard doesn't complete successfully, and you receive a **The domains already exist in another organization relationship** error message. The full text of this message resembles the following:

> ERROR : Subtask Configure execution failed: Configure Organization Relationship
Execution of the New-OrganizationRelationship cmdlet has thrown an exception. This may indicate invalid parameters in your hybrid configuration settings.
>
> The domains '\<vanitydomain1>', '\<vanitydomain2>', '\<vanitydomain3>' already exist in another organization relationship. Domains can only exist in one organization relationship. To create an organization relationship with this domain, remove the domain from the other organization relationship.
>
> at Microsoft.Exchange.Management.Hybrid.RemotePowershellSession.RunCommand(String cmdlet, SessionParameters parameters, Boolean ignoreNotFoundErrors)

If you connect to Exchange Online by using remote PowerShell and then run the `Get-OrganizationRelationship` cmdlet, you receive a message that resembles the following:

> Get-OrganizationRelationship  
Couldn't find object "\<GUID>". Please make sure that it was spelled correctly or specify a different object.  
\+ CategoryInfo : NotSpecified: (:) [Get-OrganizationRelationship], ManagementObjectNotFoundException  
\+ FullyQualifiedErrorId : [Server=*ServerName*,RequestId=*RequestId*,TimeStamp=*TimeStamp*] [FailureCategory=Cmdlet-ManagementObjectNotFoundException]
EF6F1393,Microsoft.Exchange.Management.SystemConfigurationTasks.GetOrganizationRelationship  
\+ PSComputerName : outlook.office365.com

## Resolution

Contact [Microsoft Support](https://support.microsoft.com/contactus/), and reference this article.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Q&A](/answers/products/?WT.mc_id=msdnredirect-web-msdn).
