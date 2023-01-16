---
title: Incorrect status in a VMM library share
description: Describes a known issue in which not all nodes show up in the Agent Status when you see the properties of a Virtual Machine Manager library share on a highly available library file server.
ms.date: 04/26/2020
---
# A Virtual Machine Manager library share on highly available file server displays an incorrect status

This article describes a known issue in which **Agent Status** is displayed incorrectly when you see the properties of a Virtual Machine Manager (VMM) library server on a highly available library file server.

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager Service Pack 1  
_Original KB number:_ &nbsp; 2795033

## Symptoms

When looking at the properties of a System Center 2012 Virtual Machine Manager (VMM) Service Pack 1 library server on a highly available library file server, not all nodes show up in the **Agent Status** as responding. It may also indicate that **This node is not being managed by VMM**, which is incorrect.

## Cause

This is a known issue with System Center 2012 Virtual Machine Manager SP1.

## Resolution

This **Agent Status** is erroneous and can be safely ignored.
