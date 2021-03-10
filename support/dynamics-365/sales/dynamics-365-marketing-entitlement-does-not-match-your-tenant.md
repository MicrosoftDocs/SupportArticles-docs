---
title: Dynamics 365 Marketing entitlement doesn't match your tenant
description: Your selected Dynamics 365 organization entitlement doesn't match your tenant. This message may occur when you install the Microsoft Dynamics 365 marketing application.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Microsoft Dynamics 365 Marketing entitlement does not match your tenant

This article provides a resolution for the **Your selected Dynamics 365 organization entitlement doesn't match your tenant** message that occurs when you install Microsoft Dynamics 365 marketing application.

_Applies to:_ &nbsp; Microsoft Dynamics 365 for Marketing  
_Original KB number:_ &nbsp; 4553554

## Symptoms

When installing Microsoft Dynamics 365 marketing application, users may receive the following message:

> Your selected Dynamics 365 organization entitlement doesn't match your tenant. Paid tenants require a paid organization, and preview tenants require a preview organization.

## Cause

Microsoft Dynamics 365 Marketing trial expired after 30 days. Once trial marketing instance expires, it leaves a marketing application on user tenant in **Non configured** state. This marketing application can't be configured on any other instance. When user tries to select this instance, it throws the error.  

## Resolution

To fix this issue, follow these steps:

1. Select each and every marketing application that is in **Non configured** state to install marketing.
2. At this moment, there is no easy way to differentiate between trial marketing application and paid marketing application.
3. If a right marketing application is selected, it will allow to configure marketing on desired dynamic instance.
