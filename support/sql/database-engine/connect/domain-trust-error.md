---
title: Troubleshooting the domain trust error 
description: This article provides symptoms and resolution for the domain trust error.
ms.date: 12/15/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# Domain trust error

This article helps you resolve the "Domain trust" error. This error might occur if there's an issue with the trust relationship between two domains.

## Symptoms

The trust level between domains might cause failures in account authentication or the visibility of Service Provider Name (SPN)s.

## Resolution

Use the `SETSPN` and `RUNAS` commands to test the trust relationship independent of your application.
