---
title: Unknown Actors in Audit Reports
description: Describes common examples of Microsoft 1st party service principal actors that may be found in Azure Active Directory audit logs.
ms.date: 3/29/2021
ms.prod-support-area-path: 
ms.reviewer:
---

# Unknown Actors in Audit Reports

The following are common examples of Microsoft 1st party service principal actors that may be found in Azure Active Directory audit logs including a description of actions these actors may take on Azure Active Directory objects in your tenant.

## Unknown actors

|Actor Name|Service(s)|Description|
|---|---|---|
|Microsoft Substrate Management|Exchange|Used by Exchange Online during dual write operations to Azure Active Directory. If an object is created in Exchange Online first and then written to Azure Active Directory this principal will appear as the actor in Azure Active Directory audit logs. For more information on dual write operations see [Exchange Online Improvements to Accelerate Replication of Changes to Azure Active Directory](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-online-improvements-to-accelerate-replication-of/ba-p/837218)|
|Windows Azure Service Management API|Azure Resource Manager|Used by Azure Resource Manager (ARM) service ". This service principal may be used for any Azure Active Directory operations needed to maintain proper access for Azure subscription and resources such as ensuring the subscription’s Service Administrator has an Azure Active Directory account in your tenant.|
|5MS-CE-CXG-MAC-AadShadowRoleWriter|License Manager Service, Purchase Service, Marketplace|Used by commerce platform to assign M365 commerce role permissions to Azure Active Directory. An example of a role this service would add is Modern Commerce Administrator <br>- [Reference 1 - Azure AD built-in roles](azure/active-directory/roles/permissions-reference#modern-commerce-administrator)<br>- [Reference 2 - Who can buy through self-service purchase?](microsoft-365/commerce/subscriptions/self-service-purchase-faq#who-can-buy-through-self-service-purchase)|
|Microsoft Exchange Online Protection|Security and Compliance Center|Used by Exchange Online Protection to write changes to Azure Active Directory. As an example, MIP labels can only be modified in Security and Compliance Center (SCC). SCC logs will contain the user actor. SCC then pushes these labels to AAD offline so there is no user context.|
|Microsoft Azure AD Subscription Lifecycle Process|License Manager Service|Used by the license manager service to remove licenses and subscriptions from Azure Active Directory when a subscription has expired.|
|Signup|Commerce Licensing (LMS)|Used by commerce licensing service during self-service subscription signup. For more information on self-service subscriptions see [Manage self-service sign-up subscriptions](microsoft-365/commerce/subscriptions/manage-self-service-signup-subscriptions)|
|Microsoft Approval Management|Self-Service Group Management Service|Used by self-service group management service (SSGM) for Azure Active Directory [dynamic groups](azure/active-directory/enterprise-users/groups-create-rule), and Office 365 Group expiration policy operations|
|

## More information

- [Unknown Actors in Audit Reports](https://supportability.visualstudio.com/AzureAD/_wiki/wikis/AzureAD/183979/Azure-AD-Reporting-Workflow?anchor=unknown-actors-in-audit-reports)
