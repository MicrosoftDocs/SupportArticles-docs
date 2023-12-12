---
title: Troubleshooting the NETBIOS name error 
description: This article provides symptoms and resolution for troubleshooting the NETBIOS name error.
ms.date: 11/27/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# NETBIOS name error

This article helps you to resolve an error where the NETBIOS name is specified partially.

## Symptoms

When you use just the NETBIOS name, example SQLPROD01, rather than the fully qualified domain (FQDN) name, example SQLPROD01.CONTOSO.COM, the wrong DNS suffix might be appended.

## Resolution

Check the network settings for the default suffixes and make sure they're correct or use the FQDN to avoid issues.
