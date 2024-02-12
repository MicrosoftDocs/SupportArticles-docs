---
title: Troubleshooting the SQL Server Dump
description: This article helps you to resolve an issue where the SQL Server becomes unresponsive.
ms.date: 02/12/2024
ms.custom: sap:Database Engine
---

# SQL Server becomes unresponsive during SQL Server dump generation

This article helps you resolve an issue when SQL Server becomes unresponsive when a SQL Server dump is generated.

## Symptoms

Consider the following scenario:

- You are generating a SQL Server dump.
- You experience the following error message that mentions the assert expression `pilb->m_cRef == 0`.
- The SQL Server becomes unresponsive during the dump process.

