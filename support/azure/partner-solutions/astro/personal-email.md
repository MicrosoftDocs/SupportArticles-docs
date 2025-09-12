---
title: Unable to install Astro using a personal email
description: Learn why installing Apache Airflow on Astro from the Azure Marketplace isn't supported with a personal email and how to resolve the issue.
author: ProfessorKendrick
ms.author: jarrettr
ms.reviewer: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 09/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure user, I want to understand why I can't install Astro with a personal email so that I can successfully deploy Apache Airflow.

---

# Can't install Astro using a personal email

If you're trying to install Apache Airflow on Astro from the Microsoft Azure Marketplace using a personal email from a generic domain, you can encounter issues. This article explains why this happens and how to resolve them.

## Prerequisites

- Access to the Azure portal.
- An email address associated with a unique domain (like work or school).
- Subscription owner permissions in Azure.

## Symptoms

- You're unable to install Astro with a personal email (for example, Gmail, Yahoo, or Outlook).
- You get an error or warning message indicating an unsupported email domain.

## Cause

Astro installation from the Azure Marketplace doesn't support personal emails from generic domains. The service requires an email address with a unique domain, typically associated with an organization, school, or business.

## Solution

1. Use an email address with a unique domain (for example, your organization's email).
2. Alternatively, create a new user in Azure with a unique domain and assign subscription owner permissions.
3. Retry the Astro installation from the Azure Marketplace.