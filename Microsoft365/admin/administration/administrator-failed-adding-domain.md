---
title: An administrator can't add a domain to Office 365, Azure, or Intune
description: Discusses an issue in which an administrator can't add a domain to Office 365, Azure or Intune. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- Office 365 User and Domain Management
- Cloud Services (Web roles/Worker roles)
- Microsoft Intune
---

# An administrator can't add a domain to Office 365, Azure, or Intune

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## PROBLEM

When you try to add a domain to Microsoft Office 365, Microsoft Azure, or Microsoft Intune as an administrator, you experience one of the following symptoms:

- In the Office 365 portal, you receive one of the following error messages:

  - **Number of unverified domains exceeded. Your account has too many unverified domains. Verify or delete one of your unverified domains, and then add the new domain.**
  - **Before you continue, you'll need to verify or delete one of your unverified domains. Then you can add and verify a new domain.**

- In Azure Active Directory PowerShell, you receive the following error message:

  **Before you continue, you'll need to verify or delete one of your unverified domains. Then you can add and verify a new domain.**

- In the Azure Management portal (also known as the Azure classic portal), you cannot add a new domain. You don't receive an error message when this happens.
- In the Azure Management portal (also known as the Azure classic portal), you receive the following error message:

  **Registering domain failed**

## SOLUTION

To resolve this problem, use one of the following methods:

- If you have several unverified domains, remove them. Or, verify some of your unverified domains. Currently, the limit for unverified domains is 100.
- If you receive the "Registering domain failed" error message, no action is required by you because the domain already exists.

## MORE INFORMATION

This problem may occur if one of the following conditions is true:

- The maximum number of unverified domains has been reached.
- The domain already exists within the Office 365 subscription.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).