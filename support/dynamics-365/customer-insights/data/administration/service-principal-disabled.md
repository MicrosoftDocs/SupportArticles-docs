---
title: Can't create Customer Insights - Data environment
description: Address an issue with environment creation due to disabled user sign-in.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 12/05/2023
---

# Can't create Customer Insights - Data environment

Users can't create a new Dynamics 365 Customer Insights - Data environment due to disabled service principal.

## Prerequisites

- Admin permissions for Customer Insights
- Admin permissions for Microsoft Entra

## Symptoms

When trying to create a new Customer Insights - Data environment, an error message shows: The service principal for resource `<resource ID>` is disabled.

## Resolution

Most likely, an admin disabled sign-in for the **Dynamics 365 AI for Customer Insights** enterprise application in Azure.

1. Sign in to Microsoft Entra ID in the Azure Portal.
1. Go to **Enterprise applications**.
1. Open the properties for the **Dynamics 365 AI for Customer Insights** enterprise application.
1. Set **Enabled for users to sign-in?** to **Yes**.
