---
title: Single Sign-on Doesn't Work for the Confluent Cloud SaaS Portal
description: Resolve problems with single sign-on (SSO) for the Confluent Cloud SaaS portal.
author: praveenrajap
ms.author: jarrettr
ms.reviewer: v-ryanberg
ms.custom: sap:Confluent on Azure
ms.service: partner-services  
ms.topic: troubleshooting-problem-resolution
ms.date: 09/24/2025
ai-usage: ai-assisted
# customer intent: As an Azure administrator or user, I want to resolve issues with single sign-on for the Confluent Cloud SaaS portal.

---

# Single sign-on (SSO) doesn't work for the Confluent SaaS portal

This article helps you resolve problems with SSO for the Confluent Cloud software-as-a-service (SaaS) portal.

## Prerequisites

- Access to the Confluent Cloud SaaS portal. 
- Your Microsoft Entra ID email.

## Symptoms

- SSO fails when you try to sign in to the Confluent Cloud SaaS portal.

## Cause

- SSO requires that you use the correct Microsoft Entra ID email and that you consent to allow access for the Confluent Cloud SaaS portal.

## Solution 1: Verify email and consent

1. Verify that you're using the correct Microsoft Entra ID email address to sign in.
1. When prompted, consent to allow access for the Confluent Cloud SaaS portal.
 
## Solution 2: Escalate to Confluent support

If SSO still doesn't work after you verify your email and provide consent, contact [Confluent support](https://support.confluent.io).

## Resources

- [Microsoft Entra ID documentation](/entra/identity/index)
- [Confluent support](https://support.confluent.io)
- [Confluent Cloud documentation](https://docs.confluent.io/cloud/)
 
 

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)] 
 