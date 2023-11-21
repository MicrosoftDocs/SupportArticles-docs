---
title: Unknown Actors in Audit Reports
description: Describes common examples of Microsoft first party service principal actors that may be found in Microsoft Entra audit logs.
ms.date: 07/20/2023
ms.reviewer: 
ms.service: active-directory
ms.subservice: compliance
---

# Unknown Actors in Audit Reports

The following are common examples of Microsoft first party service principal actors that may be found in Microsoft Entra audit logs including a description of actions these actors may take on Microsoft Entra objects in your tenant. 

For more commonly used first-party Microsoft applications, see [Application IDs of commonly used Microsoft applications](verify-first-party-apps-sign-in.md#application-ids-of-commonly-used-microsoft-applications).

## Unknown actors

|Actor Name|Service(s)|Description|
|---|---|---|
|Microsoft Substrate Management|Exchange|Used by Exchange Online during dual write operations to Microsoft Entra ID. When an object in Exchange Online is written to Microsoft Entra ID, this principal will show up as the actor in Microsoft Entra audit logs. For more information about dual write operations, see [Exchange Online Improvements to Accelerate Replication of Changes to Microsoft Entra ID](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-online-improvements-to-accelerate-replication-of/ba-p/837218).|
|Windows Azure Service Management API|Azure Resource Manager|Used by Azure Resource Manager (ARM) service ". This service principal may be used for any Microsoft Entra operations needed to maintain proper access for Azure subscription and resources such as ensuring the subscription’s Service Administrator has a Microsoft Entra account in your tenant.|
|5MS-CE-CXG-MAC-AadShadowRoleWriter|License Manager Service, Purchase Service, Marketplace|Used by commerce platform to assign Microsoft 365 commerce role permissions to Microsoft Entra ID. An example of a role this service would add is Modern Commerce Administrator <br>- [Reference 1 - Microsoft Entra built-in roles](/azure/active-directory/roles/permissions-reference#modern-commerce-administrator)<br>- [Reference 2 - Who can buy through self-service purchase?](/microsoft-365/commerce/subscriptions/self-service-purchase-faq#who-can-buy-through-self-service-purchase)|
|Microsoft Exchange Online Protection|Security and Compliance Center|Used by Exchange Online Protection to write changes to Microsoft Entra ID. As an example, MIP labels can only be modified in Security and Compliance Center (SCC). SCC logs contain the user actor. SCC then pushes these labels to Microsoft Entra offline, so there's no user context.|
|Microsoft Entra Subscription Lifecycle Process|License Manager Service|Used by the license manager service to remove licenses and subscriptions from Microsoft Entra ID when a subscription has expired or when the subscription state changes.|
| fim_password_service@support.onmicrosoft.com | Self-Service Password Reset |Used to perform the Self Service Password Reset operation for end users.|
|Signup|Commerce Licensing (LMS)|Used by commerce licensing service during self-service subscription signup. For more information on self-service subscriptions, see [Manage self-service sign-up subscriptions](/microsoft-365/commerce/subscriptions/manage-self-service-signup-subscriptions).|
|Microsoft Approval Management|Self-Service Group Management Service|Used by self-service group management service (SSGM) for Microsoft Entra ID [dynamic groups](/azure/active-directory/enterprise-users/groups-create-rule), and Office 365 Group expiration policy operations|
|spo_service@support.onmicrosoft.com|SharePoint Online|This account is used to create Azure Access Control Service (ACS) principles, which are required for the installation of the SharePoint app (add-in).|
[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
