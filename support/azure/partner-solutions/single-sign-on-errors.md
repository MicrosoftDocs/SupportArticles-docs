---
title: Single sign-on errors for Azure Native Integrations partner services.
description: "Troubleshoot common single sign-on (SSO) errors when integrating Azure Native Integrations with Azure AD."
author: ProfessorKendrick
ms.author: kkendrick
ms.service: partner-services
ms.topic: error-reference 
ms.date: 08/04/2025
ai-usage: ai-assisted
---

# Error codes: Azure Native Integrations single sign-on integration

This article lists common error scenarios and troubleshooting steps for single sign-on (SSO) integration between Azure Native Integrations partner services and Azure Active Directory (Azure AD). Use this information to identify and resolve issues that may occur during SSO configuration or sign-in.

| Error message | Details |
| --- | --- |
| Single sign-on configuration indicates lack of permissions | The user configuring SSO doesn't have "Manage users" permissions for the Dynatrace account. |
| Unable to save single sign-on settings | Another Enterprise app is using the Dynatrace SAML identifier. In Azure AD, select **Edit** on the Basic SAML configuration section to find the conflicting app. Disable the other app or use it to set up SAML SSO. |
| App not showing in Single sign-on settings page | Search for the application ID. If not found, check the app's SAML settings. Only apps with correct SAML configuration appear in the grid. |