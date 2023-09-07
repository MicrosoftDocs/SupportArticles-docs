---
title: Entitlement doesn't match your tenant
description: Your selected Dynamics 365 organization entitlement doesn't match your tenant. This message may occur when you install the Dynamics 365 Customer Insights - Journeys application.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-marketing-marketing
---
# Entitlement does not match your tenant

This article provides a resolution for the **Your selected Dynamics 365 organization entitlement doesn't match your tenant** message that occurs when you install the application.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Customer Insights - Journeys  
_Original KB number:_ &nbsp; 4553554

## Symptoms

When installing the application, users may receive the following message:

> Your selected Dynamics 365 organization entitlement doesn't match your tenant. Paid tenants require a paid organization, and preview tenants require a preview organization.

## Cause

The trial expired after 30 days. Once the trial instance expires, it leaves the application on user tenant in **Non configured** state. This application can't be configured on any other instance. When a user tries to select this instance, it throws the error.  

## Resolution

To fix this issue, follow these steps:

1. Select each and every Customer Insights - Journeys application that is in **Non configured** state.
1. If the right application is selected, you can configure it.