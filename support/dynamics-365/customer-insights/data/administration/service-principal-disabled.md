---
title: Can't access Customer Insights - Data environment
description: Address an issue with access to Customer Insights environment due to disabled user sign-in.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 12/06/2023
---

# Can't access Customer Insights - Data environment

Users can't access a new Dynamics 365 Customer Insights - Data environment due to disabled service principal.

## Prerequisites

- Admin permissions for Microsoft Entra ID

## Symptoms

After signing in to Customer Insights - Data, an error message shows: The service principal for resource `<application ID>` is disabled.

## Resolution

Most likely, an admin disabled sign-in for the `<application ID>` enterprise application in Azure.

1. Sign in to Microsoft Entra ID in the Azure Portal.
1. Go to **Enterprise applications**.
1. Open the properties for the `<application ID>` enterprise application.
1. Set **Enabled for users to sign-in?** to **Yes**.
