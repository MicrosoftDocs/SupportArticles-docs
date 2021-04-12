---
title: Error occurs when installing Dynamics CRM E-mail Router
description: Describes a problem that occurs when you try to install Microsoft Dynamics CRM E-mail Router on a server that is running Microsoft Exchange Server. A resolution is provided.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# The Microsoft Exchange MAPI subsystem is not installed on this system error when installing Microsoft Dynamics CRM E-mail Router

This article provides a resolution for the issue that you can't install Microsoft Dynamics CRM E-mail Router due to an error occurs.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 951401

## Symptoms

When you try to install Microsoft Dynamics CRM E-mail Router, you receive the following error message:

> The Microsoft Exchange MAPI subsystem is not installed on this system.

## Cause

This problem occurs because the following components are not installed:

- The Messaging API (MAPI) client libraries
- Collaboration Data Objects (CDO) 1.2.1

## Resolution

To resolve this problem, install the MAPI client libraries and CDO 1.2.1.
