---
title: Error AADSTS900439 - USGClientNotSupportedOnPublicEndpoint
description: Describes a problem in which you receive the error AADSTS900439 when signing in to an application registered in Azure Government cloud using a public endpoint. 
ms.date: 03/17/2025
ms.reviewer: bernawy
ms.service: entra-id
ms.custom: sap:Issues Signing In to Applications
---
# Error AADSTS900439 - USGClientNotSupportedOnPublicEndpoint

This article provides a solution to the error AADSTS900439 (USGClientNotSupportedOnPublicEndpoint) that occurs when you try to sign in to an application registered in the Azure Government cloud using a public cloud endpoint.

## Symptoms

When trying to sign in to an application registered in Azure Government cloud using a public endpoint, the sign-in fails and you receive the AADSTS900439 (USGClientNotSupportedOnPublicEndpoint) error.

## Cause

Microsoft Entra authority for Azure Government has been updated to from `https://login-us.microsoftonline.com` to `https://login.microsoftonline.us`. This change also applies to Microsoft 365 GCC High and M365 DoD environments, which Microsoft Entra authority for Azure Government also services. Microsoft Entra ID enforces the correct endpoint for sign-in operations. You can no longer sign in to an application registered in the Azure Government cloud using the public `https://login-us.microsoftonline.com` endpoint.

For more information, see [Endpoint Update - Microsoft Entra Authority for Azure Government](https://devblogs.microsoft.com/azuregov/azure-government-aad-authority-endpoint-update)

## Solution

To resolve this issue, ensure you use the correct Azure Government endpoint for sign-in operations. Here are the mappings between Azure services and Azure Government endpoints:

| Name | Azure Government Endpoint |
| --- | --- |
| Portal | `https://portal.azure.us` |
| Microsoft Graph API | `https://graph.microsoft.us` |
| Active Directory Endpoint and Authority | `https://login.microsoftonline.us` |

For more information, see [Azure Government endpoint mappings](/azure/azure-government/documentation-government-developer-guide#endpoint-mapping).

## More information

Each national cloud environment differs from the global Microsoft environment. When you develop applications for these environments, it's important to understand key differences. For example, registering applications, acquiring tokens and calling the Microsoft Graph API can be different.

For more information about registering applications in a national cloud, see [App registration endpoints](/entra/identity-platform/authentication-national-cloud#app-registration-endpoints).

For more information about acquire tokens in a national cloud, see [Microsoft Entra authentication endpoints](/entra/identity-platform/authentication-national-cloud#azure-ad-authentication-endpoints).

For more information about the different Microsoft Graph national cloud deployments and the capabilities that are available to developers within each, see [Microsoft Graph national cloud deployments](/graph/deployments). Here is a sample for implementation: [Configure .Net Application to call Microsoft Graph in a National Cloud Tenant](https://blogs.aaddevsup.xyz/2020/06/configure-net-application-to-call-microsoft-graph-in-a-national-cloud-tenant).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]