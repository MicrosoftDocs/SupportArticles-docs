---
title: Error AADSTS50105 - The signed in user is not assigned to a role for the application.
description: Describes a problem in which you receive the AADSTS50105 error when you sign in to a SAML-based configured app with Azure AD SSO.
ms.date: 06/15/2022
ms.reviewer: bernawy
ms.service: active-directory
ms.subservice: app-mgmt
---
# Error AADSTS50105 - The signed in user is not assigned to a role for the application

This article provides a resolution to the AADSTS50105 error that occurs during federated authentication with Azure Active Directory (Azure AD).

## Symptoms

You receive the following error when trying to sign into an application that has been set up to use Azure AD for identity management using SAML-based Single Sign-On (SSO):

>Error AADSTS50105 - The signed in user is not assigned to a role for the application.

## Cause

The user hasn't been granted access to the application in Azure AD. The user must belong to a group that is assigned to the application, or be assigned directly. 

>[!Note]
>Nested groups are not supported, and the group must be directly assigned to the application.

## Resolution

 To assign one or more users to an application directly, see [Quickstart: Assign users to an app](/azure/active-directory/manage-apps/add-application-portal-assign-users).

## More Information

For a full list of Active Directory authentication and authorization error codes, see [Azure AD Authentication and authorization error codes](/azure/active-directory/develop/reference-aadsts-error-codes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
