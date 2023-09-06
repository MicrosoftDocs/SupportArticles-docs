---
title: Cannot sign in to OneDrive connector when using office 365 account
description: You are unable to sign in to OneDrive connector when using office 365 account during flow creation. Provides a resolution.
ms.reviewer: anaggar
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: power-automate-connections
---
# Unable to sign in to OneDrive connector when using office 365 account during flow creation

This article provides a resolution for the issue tht you can't sign in to OneDrive connector when using office 365 account during flow creation.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4533363

## Symptoms

While creating a flow from blank or with a template that is using any trigger/action from OneDrive connector, if you try to sign in using office 365 account, you may receive the error:

> Sorry, we can't sign you in here with your account.

## Resolution

This error happens because OneDrive is a cloud-based storage for personal use, which can be accessed with an outlook.com or microsoft live account not with office 365 account. You can use OneDrive for business connector if you want to use office 365 account.
