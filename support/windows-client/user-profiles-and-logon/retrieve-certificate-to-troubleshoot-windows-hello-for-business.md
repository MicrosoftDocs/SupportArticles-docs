---
title: Retrieve certificate to troubleshoot Windows Hello for Business logon failures.
description: This article introduces a solution to retrieve certificate information from Active Directory.
ms.date: 02/14/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: takondo
ms.custom: sap:User Logon and Profiles\User profiles, csstroubleshoot
---
# Retrieve certificate to troubleshoot Windows Hello for Business logon failures

This article introduces how to troubleshoot the logon failures with Windows Hello for Business (WHfB) in a hybrid environment.

## Scenario

After deploying WHfB to a key trust hybrid environment, you encounter one of the following issues.

- Users are unable to logon to a hybrid join device by using WHfB.
- Single sign-on (SSO) to on-premises resources fails after logging on to a Microsoft Entra join device by using WHfB.

## Analysis

To fix these issues, you need to review the certificate being used for authentication.

The **msDS-KeyCredentialLink** attribute of the Active Directory user object contains the information on the certificate being used for authentication. This certificate is created during the user's WHfB provisioning and uploaded to Microsoft Entra ID. This information is then expected to be synchronized from Entra ID to on-premises Active Directory through Microsoft Entra Connect. If this attribute isn't properly synchronized, you may see WHfB logon failures, or SSO failures to on-premises resources.

## Resolution

To troubleshoot this issue, we recommend using the script in [Script to view the certificate information in the msDS-KeyCredentialLink attribute from AD user objects](../../windows-server/support-tools/script-to-view-msds-keycredentiallink-attribute-value.md) to retrieve and review the certificate information.
