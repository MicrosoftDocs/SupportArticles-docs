---
title: Single sign-on doesn't work for Confluent Cloud SaaS portal
description: "Resolve issues with single sign-on (SSO) for the Confluent Cloud SaaS portal in Azure."
author: v-albemi
ms.author: v-albemi
ms.service: Confluent integration
ms.topic: troubleshooting-problem-resolution
ms.date: 09/24/2025

customer intent: As a {role}, I want {what} so that {why}.

---

# Single sign-on doesn't work for Confluent Cloud SaaS portal

This article helps you resolve issues with single sign-on (SSO) for the Confluent Cloud SaaS portal in Azure.

## Prerequisites

- Access to the Confluent Cloud SaaS portal and your Microsoft Entra ID account.
- Permissions to consent to application access in Microsoft Entra ID.

## Symptoms

- SSO fails when trying to sign in to the Confluent Cloud SaaS portal.
- You are unable to access the portal using your Microsoft Entra ID email.

## Cause

- SSO requires using the correct Microsoft Entra ID email and consenting to allow access for the Confluent Cloud SaaS portal.

## Solution 1: Verify email and consent

1. Confirm you are using the correct Microsoft Entra ID email address to sign in.
2. When prompted, consent to allow access for the Confluent Cloud SaaS portal.
3. If you are unsure which email to use, check with your Azure administrator or review your Microsoft Entra ID profile.

## Solution 2: Escalate to Confluent support

1. If SSO still doesn't work after verifying your email and consenting, contact [Confluent support](https://support.confluent.io).
2. Provide details about your account, the error message, and steps you have tried.

## Verify

- After verifying your email and consenting, confirm you can sign in to the Confluent Cloud SaaS portal using SSO.
- If support intervenes, verify receipt of resolution or further instructions.

## Related content

- [Confluent support](https://support.confluent.io)
- [Microsoft Entra ID documentation](https://learn.microsoft.com/azure/active-directory/)
- [Azure Marketplace documentation](https://learn.microsoft.com/azure/marketplace/marketplace-overview)