---
title: Worker Process takes much memory
description: This article provides resolutions for the problem that Worker Process may allocate a large amount of memory when you have a complex directory structure on IIS.
ms.date: 04/07/2020
ms.custom: sap:Site behavior and performance
ms.reviewer: robmcm, romanf
ms.technology: site-behavior-performance
---
# Worker Process may allocate a large amount of memory when you have a complex directory structure on IIS

This article provides resolutions for the problem where Worker Process may allocate large amounts of memory when you have a complex content directory structure on Microsoft Internet Information Services (IIS).

_Original product version:_ &nbsp; Windows Server 2008, 2008 R2, 2012, 2012 R2  
_Original KB number:_ &nbsp; 3020858

## Symptoms

Consider the following scenario:

- You install the Web Server role from IIS.
- You have a content directory whose structure is complex. For example, you have a deep tree that includes many child directories in a parent directory.
- Users send requests for many unique URLs. For example, users send requests for many virtual directories or applications.

In this scenario, the worker process may suddenly allocate a large amount of memory.

## Cause

IIS caches configuration information by using a virtual directory path. Additionally, a hash table to access the configuration information efficiently is created. If many unique URLs are accessed, and if the size of the hash table becomes insufficient, the hash table is extended. If you also have a complex directory structure, the size of the hash table may be extended greatly.

## Workaround

To work around this issue, use one of the following methods:

- Simplify the content directory structure.
- Increase the frequency of recycling the worker process.
