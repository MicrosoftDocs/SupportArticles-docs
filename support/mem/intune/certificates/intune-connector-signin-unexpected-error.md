---
title: Troubleshoot error when you sign in to Intune Connector for Active Directory
description: Fixes an unexpected error problem that occurs when you sign in to Intune Connector for Active Directory.
ms.date: 12/05/2023
search.appverid: MET150
ms.custom: sap:Sign in to Intune
ms.reviewer: kaushika, saurkosh, intunecic
---
# Unexpected error when you try to sign in to Intune Connector for Active Directory

This article fixes an unexpected error that occurs when you sign in to Microsoft Intune Connector for Active Directory.

## Symptoms

When you try to sign in to Microsoft Intune Connector for Active Directory, you receive the following error message:

> An unexpected error has occurred.  
> An error occurred while processing your request.  
> View Service Status

:::image type="content" source="media/intune-connector-signin-unexpected-error/unexpected-error.png" alt-text="Screenshot of the unexpected error.":::

## Cause

This issue occurs because the account isn't assigned an Intune or Microsoft Office license.

## Solution

To fix this issue, assign an Intune license to the user account. For more information, see the following articles:

- [Assign licenses to users so they can enroll devices in Intune](/mem/intune/fundamentals/licenses-assign)
- [Add users individually or in bulk](/microsoft-365/admin/add-users/add-users)
