---
title: Error when you open the Multicurrency Access Setup window in Microsoft Dynamics GP
description: Provides a solution to an error that occurs when you open the Multicurrency Access Setup window in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.reviewer: theley, kyouells
ms.date: 03/13/2024
---
# Error when you try to open the Multicurrency Access Setup window in Microsoft Dynamics GP: "You cannot open the Multicurrency Access Setup window because another user is working in Microsoft Dynamics GP"

This article provides a solution to an error that occurs when you open the Multicurrency Access Setup window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 932336

## Symptoms

When you try to review the configuration of the currencies in the Multicurrency Access Setup window, you receive the following error message:

> You cannot open the Multicurrency Access Setup window because another user is working in Microsoft Dynamics GP. Try again later.

Alternatively, when you try to log in to a company, you receive the following error message:

> You cannot open Microsoft Dynamics GP now because another user is entering Multicurrency access information. Try again later.

## Cause

This problem occurs because only one user can be logged in to a company when you access the Multicurrency Access Setup window.

## Resolution

To resolve this problem, make sure that no other users are logged in to the company. To determine the users who are logged in to the company, view the User Activity window. To do this, use either of the following methods as appropriate:

- If you are using Microsoft Dynamics GP 9.0, click **Tools**, click **Utilities**, click **System**, and then click **User Activity**.

- If you are using Microsoft Business Solutions - Great Plains 8.0, click **Tools**, click **Setup**, click **System**, and then click **User Activity**.

## Steps to reproduce the problem

1. Start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0, and then log in to a company.
2. Click **Tools**, click **Setup**, click **System**, and then click **Multicurrency Access**. The **Multicurrency Access Setup** window opens as expected.
3. Start Microsoft Dynamics GP or Microsoft Business Solutions - Great Plains 8.0 again, and then log in to the same company as another user.
4. As this other user, click **Tools**, click **Setup**, click **System**, and then click **Multicurrency Access**. You receive the error message that is mentioned in the [Symptoms](#symptoms) section. And, the **Multicurrency Access Setup** window does not open.
