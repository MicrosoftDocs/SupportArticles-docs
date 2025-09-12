---
title: Unable to use single sign-on in Astronomer portal
description: "Troubleshoot issues with single sign-on (SSO) for the Astronomer portal in Azure, including consent and email requirements."
author: ProfessorKendrick
ms.author: jarrettr
ms.reviewer: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution 
ms.date: 09/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure admin, I want to resolve SSO issues with Astronomer so that users can access the portal securely.

---

# Unable to use single sign-on in Astronomer portal

This article helps you troubleshoot and resolve issues with single sign-on (SSO) when accessing the Astronomer portal in Microsoft Azure. If SSO isn't working, follow these steps to identify and fix common problems related to email, consent, and tenant settings.

## Prerequisites

- Access to the Azure subscription and Astronomer portal.
- Microsoft Entra account credentials.
- Admin permissions to review tenant consent settings.

## Symptoms

- You're unable to sign in to the Astronomer portal using SSO.
- You're prompted for both **Admin** and **User consent** during first-time sign in.
- You get error messages related to email or consent.

## Cause

SSO issues can occur if you're using an incorrect email, haven't provided consent, or your tenant settings prevent access.

## Solution

- Verify you're using the correct Microsoft Entra email for SSO.
- Ensure you've consented to allow access for the Astronomer software-as-a-service (SaaS) portal.
- If you see both **Admin** and **User consent** screens during first-time sign in, check your tenant consent settings.
