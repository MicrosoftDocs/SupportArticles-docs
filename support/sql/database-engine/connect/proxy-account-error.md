---
title: Troubleshooting the proxy account error 
description: This article provides cause, symptoms, and workarounds for troubleshooting the proxy account error.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Proxy account error

This article provides the cause, symptoms, and resolution of the proxy account error.

## Symptoms

An SSIS job run by SQL Agent might need permissions other than the SQL Agent service account can provide.

## Solution

Check whether a Proxy account needs to be created or used and if a proxy account is being used, it is the correct account.