---
title: Unable to use single sign-on in Astronomer portal
description: Troubleshoot issues with single sign-on (SSO) for the Astronomer portal in Azure, including consent and email requirements.
author: ProfessorKendrick
ms.author: jarrettr
ms.reviewer: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution 
ms.date: 09/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure administrator, I want to resolve SSO issues in Astronomer so that users can access the portal securely.

---

# Can't use single sign-on in Astronomer portal

This article helps you to troubleshoot and resolve issues that affect single sign-on (SSO) when you access the Astronomer portal in Microsoft Azure. If SSO isn't working, follow these steps to identify and fix common problems that are related to email, consent, and tenant settings.

## Prerequisites

- Access to the Azure subscription and Astronomer portal
- Microsoft Entra account credentials
- Administrator permissions to review tenant consent settings

## Symptoms

- You can't sign in to the Astronomer portal by using SSO.
- You're prompted for both **Admin** and **User consent** during the initial sign-in process.
- You receive error messages that are related to your email account or consent.

## Cause

SSO issues can occur if you use an incorrect email account, if you don't provide consent, or if your tenant settings prevent access.

## Solution

- Verify that you use the correct Microsoft Entra email account for SSO.
- Make sure you consent to allow access for the Astronomer software-as-a-service (SaaS) portal.
- If you see both **Admin** and **User consent** screens during the initial sign-in process, check your tenant consent settings.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]