---
title: Unknown actors in Audit reports
description: Describes common examples of Microsoft first-party service principal actors that may be found in Microsoft Entra audit logs.
ms.date: 11/30/2023
ms.reviewer: bernaw, v-six
ms.service: entra-id
ms.custom: sap:Audit Logs
---

# Unknown actors in Audit reports

The following are common examples of Microsoft first-party service principal actors that may be found in Microsoft Entra audit logs, including a description of actions that these actors may take on Microsoft Entra objects in your tenant.

For more commonly used first-party Microsoft applications, see [Application IDs of commonly used Microsoft applications](verify-first-party-apps-sign-in.md#application-ids-of-commonly-used-microsoft-applications).

## Unknown actors

|Actor Name|Services|Description|
|---|---|---|
|Azure Credential Configuration Endpoint Service|Auth Methods Registration|Used when [authentication methods](/entra/identity/authentication/howto-mfa-userdevicesettings#add-authentication-methods-for-a-user) are registered. It can be displayed as an actor in audit logs when enabling the combined registration.|
|cxpweb_service@support.onmicrosoft.com|CXP|This account is from our internal Microsoft Support tenant. It's used to facilitate the management and maintenance of customers' tenants. Microsoft Support is currently transitioning to a unified platform for customer support and case management. For the change in question, the account sets a flag on the tenant to initiate the migration of support cases to the unified platform. This change doesn't directly affect any settings on your tenant or affect your existing or future support cases.|
|DaRT Team|Partner Center|The Set Partnership operation means that DAP is terminated by Microsoft. This scenario is expected to be part of the Microsoft-led DAP deprecation.|
|fim_password_service@support.onmicrosoft.com | Self-Service Password Reset |Used to perform the Self Service Password Reset operation for end users.|
|Microsoft Approval Management|Self-Service Group Management Service|Used by self-service group management service (SSGM) for Microsoft Entra ID [dynamic groups](/azure/active-directory/enterprise-users/groups-create-rule), and Office 365 Group expiration policy operations.|
|Microsoft Azure AD Internal - Jit Provisioning|Microsoft Entra ID|Used when the service principal for a Microsoft service is automatically created or updated, typically in response to changes that are made in subscriptions. These automatic service principal updates sometimes occur through a background asynchronous process. They do not necessarily occur immediately following a subscription event or change.| 
|Microsoft Azure Management|ARM|If the directory doesn't already have an account for the Service Administrators, the "Windows Azure Service Management API" ARM service principal will send and redeem invitations to the Service Administrators of the Azure subscription list. This process ensures that the Service Administrator of the subscription can access and view the subscription in the portal.|
|Microsoft Entra Subscription Lifecycle Process|License Manager Service|Used by the license manager service to remove licenses and subscriptions from Microsoft Entra ID when a subscription has expired or when the subscription state changes.|
|Microsoft Exchange Online Protection|Security and Compliance Center|Used by Exchange Online Protection to write changes to Microsoft Entra ID. As an example, MIP labels can only be modified in Security and Compliance Center (SCC). SCC logs contain the user actor. SCC then pushes these labels to Microsoft Entra offline, so there's no user context.|
|Microsoft Managed Policy Manager|Microsoft Managed Conditional Access|Used to create and manage [Microsoft-managed Conditional Access policies](/entra/identity/conditional-access/managed-policies).|
|Microsoft Substrate Management|Exchange|Used by Exchange Online during dual write operations to Microsoft Entra ID. When an object in Exchange Online is written to Microsoft Entra ID, this principal will show up as the actor in Microsoft Entra audit logs. For more information about dual write operations, see [Exchange Online Improvements to Accelerate Replication of Changes to Microsoft Entra ID](https://techcommunity.microsoft.com/t5/exchange-team-blog/exchange-online-improvements-to-accelerate-replication-of/ba-p/837218).|
|MS-CE-CXG-MAC-AadShadowRoleWriter|License Manager Service, Purchase Service, Marketplace|Used by commerce platform to assign Microsoft 365 commerce role permissions to Microsoft Entra ID. An example of a role this service would add is Modern Commerce Administrator. <br>- [Reference 1 - Microsoft Entra built-in roles](/azure/active-directory/roles/permissions-reference#modern-commerce-administrator)<br>- [Reference 2 - Who can buy through self-service purchase?](/microsoft-365/commerce/subscriptions/self-service-purchase-faq#who-can-buy-through-self-service-purchase)|
|Signup|Commerce Licensing (LMS)|Used by commerce licensing service during self-service subscription signup. For more information about self-service subscriptions, see [Manage self-service sign-up subscriptions](/microsoft-365/commerce/subscriptions/manage-self-service-signup-subscriptions).|
|spo_service@support.onmicrosoft.com|SharePoint Online|This account is used to create Azure Access Control Service (ACS) principles. These are required for the installation of the SharePoint app (add-in).|
|Windows Azure Service Management API|Azure Resource Manager|Used by the Azure Resource Manager (ARM) service. This service principal may be used for any Microsoft Entra operations needed to maintain proper access to your Azure subscription and resources, such as ensuring the subscription's Service Administrator has a Microsoft Entra account in your tenant. You can see this actor when a customer registers a resource provider in an Azure subscription in their tenant. For more information about how and why this actor appears, see [resource providers and types](/azure/azure-resource-manager/management/resource-providers-and-types). More than 1,000 App IDs are connected to resource providers, and new IDs are added regularly. The REST API can be used to return the App ID dynamically.|

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
