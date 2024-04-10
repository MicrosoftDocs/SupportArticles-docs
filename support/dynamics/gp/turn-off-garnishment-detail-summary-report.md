---
title: Turn off Garnishment Detail/Summary report
description: Describes how to turn off Garnishment Detail/Summary reports in Payroll for Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# GP 2018 New feature - How to turn off Garnishment Detail/Summary reports in Payroll for Microsoft Dynamics GP

This article describes how to turn off Garnishment Detail/Summary reports in Payroll for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4072348

## Symptoms

How can you turn off the Garnishment Detail/Summary reports from printing in Payroll for Microsoft Dynamics GP?  
They're slowing down our payroll process.

View the new feature in [Microsoft Dynamics GP 2018 Who wants to see those pesky garnishment reports that slow down the process of my payroll? Turn off Garnishment reports in Posting Setup](https://community.dynamics.com/blogs/post/?postid=0228ded7-30bb-4417-94c4-0697971bd21c).

## Resolution

It's a new feature added in Microsoft Dynamics GP 2018 (RTM) to be able to turn off the Garnishment reports in the Posting Setup for Payroll. Which will speed up the payroll posting process for those that don't need to view these reports?

1. Go to **Microsoft Dynamics GP | Tools | Setup | Posting | Posting**.
1. Select **Payroll** series, and Origin of **All**.
1. Mark/Unmark the **Payables Garnishment Detail** and **Payables Garnishment Summary** reports' as wanted.
1. **Save.**

> [!NOTE]
> If you upgrade, these reports will stay marked by default, and the reports will still print until they are unmarked in the posting setup window.
