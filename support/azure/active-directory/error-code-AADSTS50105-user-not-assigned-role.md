---
title: Error AADSTS50105 - The signed in user is not assigned to a role for the application.
description: Describes a problem in which you receive an error message when signing in to SAML-based single sign-on configured app that has been configured to use Azure Active Directory as an Identity Provider (IdP). The signed in user is not assigned to a role for the application.
ms.date: 09/30/2021
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50105 - The signed in user is not assigned to a role for the application

This article describes a problem in which you receive the error message "Error AADSTS50105 - The signed in user is not assigned to a role for the application." when trying to sign into a SAML-based single sign-on (SSO) configured app that has been integrated with Azure Active Directory (Azure AD).

## Symptoms

You receive error `AADSTS50105` when trying to sign into an application that has been setup to use Azure AD for identity management using SAML-based SSO.

## Cause

The user has not been granted access to the application in Azure AD. The user must belong to a group that is assigned to the application, or be assigned directly. Note that nested groups are not supported, and the group must be directly assigned to the application.

## Resolution

 To assign one or more users to an application directly, see [Quickstart: Assign users to an app](/azure/active-directory/manage-apps/add-application-portal-assign-users).

## More Information

For a full list of Active Directory authentication and authorization error codes see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
