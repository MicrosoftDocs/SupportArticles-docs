---
title: Unable to install Astro using a personal email
description: Discusses why installing Apache Airflow on Astronomer from Azure Marketplace by using a personal email account isn't supported, and how to resolve the problem.
author: ProfessorKendrick
ms.author: jarrettr
ms.reviewer: kkendrick
ms.service: partner-services
ms.topic: troubleshooting-problem-resolution
ms.date: 09/04/2025
ai-usage: ai-assisted

#customer intent: As an Azure user, I want to understand why I can't install Astronomer by using a personal email account so that I can successfully deploy Apache Airflow.

---

# Can't install Astronomer using a personal email account

You might experience errors if you try to install Apache Airflow on Astronomer from the Microsoft Azure Marketplace by using a personal email account. This article explains why the errors occur and how to resolve them.

## Prerequisites

- Access to the Azure portal
- An email address that's associated with a unique domain (such as work or school)
- Subscription owner permissions in Azure

## Symptoms

If you try to install Apache Airflow on Astronomer by using a personal email account (for example, Outlook, Gmail, or Yahoo), the installation fails, and you receive an error or warning message that states that the email domain is unsupported.

## Cause

Astronomer installation from the Azure Marketplace doesn't support personal email accounts from generic domains. The service requires an email address that has a unique domain that's typically associated with an organization, school, or business.

## Solution

To resolve this problem, follow these steps:

1. Use an email address that has a unique domain (for example, your organization's email domain).
2. Create a new user in Azure that has a unique domain, and assign subscription owner permissions to that user.
3. Retry the Astronomer installation from the Azure Marketplace.
