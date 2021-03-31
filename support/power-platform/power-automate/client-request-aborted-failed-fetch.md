---
title: Client Request Aborted or Failed to fetch
description: Provides a solution to errors that occur when you create or save flows or connections, or when navigate pages within the Power Automate product.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Client Request Aborted or Failed to fetch error in Power Automate

This article provides a solution to errors that occur when you create or save flows or connections, or when navigate pages within the Power Automate product.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4557620

## Symptoms

When creating or saving flows or connections, or when navigating pages within the Power Automate product, you may see one of the following messages:

- > "Failed to Fetch"
- > "Client Request Aborted"
- > "Network Error"

:::image type="content" source="media/client-request-aborted-failed-fetch/network-error.png" alt-text="Network error example.":::

## Cause

Companies may set firewalls or block their users from unknown domains or IP addresses.

## Resolution

Contact your administrator or IT department to unblock access and allow list the following ones:

- [IP addresses](/power-automate/limits-and-config#required-services)
- [Domains](/power-automate/limits-and-config#required-services)
