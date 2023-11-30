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
|Azure Credential Configuration Endpoint Service|Auth Methods Registration|It's used when [AAD Authentication Methods](/entra/identity/authentication/howto-mfa-userdevicesettings#add-authentication-methods-for-a-user) are registered. It can be displayed as an actor in audit logs when enabling the combined registration.|
|cxpweb_service@support.onmicrosoft.com|CXP|This's an account from our internal Microsoft Support Tenant. This account is used to facilitate management and maintenance of our customer’s tenants. Microsoft support is currently in the middle of a transition to a unified platform for customer support and case management. For the change in question, the account set a flag on the tenant to start to move support cases to that unified platform. This change does not directly impact any settings on your tenant or your existing or future support cases.|
|DaRT Team|Partner Center|The operation "Set Partnership" means DAP is terminated by Microsoft. This's an expected scenario as part of the MS-Led DAP deprecation effort.|
|fim_password_service@support.onmicrosoft.com | Self-Service Password Reset |Used to perform the Self Service Password Reset operation for end users.|
|Microsoft Approval Management|Self-Service Group Management Service|Used by self-service group management service (SSGM) for Microsoft Entra ID [dynamic groups](/azure/active-directory/enterprise-users/groups-create-rule), and Office 365 Group expiration policy operations|
|Microsoft Azure Management|ARM|The ARM service principal "Windows Azure Service Management API" will invite and redeem invitations to the Azure Subscription list of Service Administrator's if the directory does not have an account already for the Service Administrator. This is done to ensure that the subscription's Service Administrator has access to view the subscription in the portal.|
|Microsoft Entra Subscription Lifecycle Process|License Manager Service|Used by the license manager service to remove licenses and subscriptions from Microsoft Entra ID when a subscription has expired or when the subscription state changes.|
|Microsoft Exchange Online Protection|Security and Compliance Center|Used by Exchange Online Protection to write changes to Microsoft Entra ID. As an example, MIP labels can only be modified in Security and Compliance Center (SCC). SCC logs contain the user actor. SCC then pushes these labels to Microsoft Entra offline, so there's no user context.|
|Microsoft Managed Policy Manager|Microsoft Managed Conditional Access|Used to create and manage [Microsoft Managed Conditional Access Policies](/entra/identity/conditional-access/managed-policies).|
|Microsoft Substrate Management|Exchange|Used by Exchange Online during dual write operations to Microsoft Entra ID. When an object in Exchange Online is written to Microsoft Entra ID, this principal will show up as the actor in Microsoft Entra audit logs. For more information about dual write operations, see [Exchange Online Improvements to Accelerate Replication of Changes to Microsoft Entra ID](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-online-improvements-to-accelerate-replication-of/ba-p/837218).|
|MS-CE-CXG-MAC-AadShadowRoleWriter|License Manager Service, Purchase Service, Marketplace|Used by commerce platform to assign Microsoft 365 commerce role permissions to Microsoft Entra ID. An example of a role this service would add is Modern Commerce Administrator <br>- [Reference 1 - Microsoft Entra built-in roles](/azure/active-directory/roles/permissions-reference#modern-commerce-administrator)<br>- [Reference 2 - Who can buy through self-service purchase?](/microsoft-365/commerce/subscriptions/self-service-purchase-faq#who-can-buy-through-self-service-purchase)|
|Signup|Commerce Licensing (LMS)|Used by commerce licensing service during self-service subscription signup. For more information on self-service subscriptions, see [Manage self-service sign-up subscriptions](/microsoft-365/commerce/subscriptions/manage-self-service-signup-subscriptions).|
|spo_service@support.onmicrosoft.com|SharePoint Online|This account is used to create Azure Access Control Service (ACS) principles, which are required for the installation of the SharePoint app (add-in).|
|Windows Azure Service Management API|Azure Resource Manager|Used by Azure Resource Manager (ARM) service ". This service principal may be used for any Microsoft Entra operations needed to maintain proper access for Azure subscription and resources such as ensuring the subscription’s Service Administrator has a Microsoft Entra account in your tenant. You can see this actor when the customer registered a resource provider in an Azure subscription in their tenant. This link [Resource providers and resource types](/azure/azure-resource-manager/management/resource-providers-and-types) shares how/why this happens. There are over 1000 AppIds that are connected to RPs and regularly being added so not something we want to put in the public doc and why we shared the rest API to return it dynamically.|

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]

