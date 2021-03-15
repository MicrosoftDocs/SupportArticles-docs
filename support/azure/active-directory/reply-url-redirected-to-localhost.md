---
title: Azure Active Directory is sending the token to an incorrect reply URL endpoint or localhost.
description: Describes a problem in which Azure Active Directory is sending the token to an incorrect reply URL endpoint or localhost.
ms.date: 03/15/2021
ms.prod-support-area-path: 
ms.reviewer: bernawy
---
# Azure Active Directory is sending the token to an incorrect reply URL endpoint or localhost.

This article describes a problem in which Azure Active Directory is sending the token to an incorrect reply URL endpoint or localhost.

## Symptoms

During single sign-on, if the sign-in request does not contain an explicit reply URL (Assertion Consumer Service URL) then Azure AD will select any of the configured reply URLs for that application. Even if the application has an explicit reply URL configured, the user may be to redirected `https://127.0.0.1:444`. 

When the application was added as a non-gallery app, Azure Active Directory created this reply URL as a default value. This behavior has changed and Azure Active Directory no longer adds this URL by default.

## Cause

The user has not been granted access to the application in Azure AD.

## Resolution

Delete the unused reply URLs configured for the application.

On the SAML-based SSO configuration page, in the **Reply URL (Assertion Consumer Service URL)** section, delete unused or default Reply URLs created by the system. For example, `https://127.0.0.1:444/applications/default.aspx`.
