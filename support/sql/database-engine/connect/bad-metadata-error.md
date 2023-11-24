---
title: Troubleshooting the bad metadata error 
description: This article provides cause, symptoms, and solution for troubleshooting the bad metadata error.
ms.date: 11/23/2023
author: prmadhes-msft
ms.author: prmadhes
ms.reviewer: jopilov, haiyingyu, mastewa, v-jayaramanp
ms.custom: sap:Connection issues
---

# Bad metadata error

This article provides the symptoms, and resolution of the bad metadata error.

## Symptoms

A View or stored procedure which is used to query views in the linked server, receives login failures whereas a distributed `SELECT` statement copied from them doesn't. This might happen if the View was created and then the linked server was recreated, or a remote table was modified without rebuilding the View.

## Solution

