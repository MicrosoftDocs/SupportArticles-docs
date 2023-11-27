---
title: Troubleshooting the service account not trusted for delegation error 
description: This article provides symptoms and resolution for the service account not trusted for delegation error.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Service account not trusted for delegation error

This article helps you to resolve the service account not trusted for delegation error.

## Symptoms

(To be added)

## Resolution

If a delegation scenario isn't enabled, check the SQL Server *secpol.msc* if the SQL Server service account is listed under **Local Policies > User Rights Assignment > Impersonate a client after authentication** security policy settings.
