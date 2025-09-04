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

# Unable to install Astro using a personal email

If you're trying to install Apache Airflow on Astro from the Azure Marketplace using a personal email from a generic domain, you may encounter issues. This article explains why this happens and how to resolve it.

## Prerequisites

- Access to the Azure portal.
- An email address associated with a unique domain (such as work or school).
- Subscription owner permissions in Azure.

## Symptoms

- Unable to proceed with Astro installation using a personal email (for example, Gmail, Yahoo, Outlook).
- Error or warning indicating unsupported email domain.

## Cause

Astro installation from the Azure Marketplace doesn't support personal emails from generic domains. The service requires an email address with a unique domain, typically associated with an organization, school, or business.

## Solution

1. Use an email address with a unique domain (for example, your organization's email).
1. Alternatively, create a new user in Azure with a unique domain and assign subscription owner permissions.
1. Retry the Astro installation from the Azure Marketplace.