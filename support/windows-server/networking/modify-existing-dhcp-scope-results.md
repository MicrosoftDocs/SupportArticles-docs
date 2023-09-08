---
title: Fail to modify existing DHCP scope
description: Provides solutions to an error that occurs when you modify an existing scope.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
ms.technology: networking
---
# Modifying an existing DHCP scope results in the error

This article provides help to fix an error that occurs when you modify an existing scope.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2634442

## Summary

When trying to modify an existing scope, we get the following error:
> "The specified range either overlaps an existing range or is not valid".

This seems to be an expected behavior depending on how the DHCP scope is modified. The following line diagram illustrates how the scope can be modified and the allowed method.

Initial Subnet Space: -------------------------

Allowed Expanding on both sides: --------------------------------------

Allowed: Contracting on both sides: --------------

Not Allowed: shifting to the right: --------------------------

Not Allowed: Shifting to the left: --------------------

## Resolution

1. Either ensure that the scope is expanded or contracted both ways or in one direction.
2. Modify either the start or the endip address one at a time and immediately applying the changes after each and every change to the start or end ip address of the scope.

## More information

Following are the steps to reproduce the issue:

### Steps to repro the issue

1. Create a scope called Test with the Start IP = 10.23.228.1 and End IP = 10.23.228.254. The subnet mask is 255.255.240.0 (/20)
2. Modify the scope by changing the Start ip to 10.23.226.1 and End ip to 10.23.227.254 (This is well within the range 10.23.224.1-10.23.229.254)
It Results in the message "The specified range either overlaps an existing range or is not valid".

### Resolution

The above scenario falls in the category of "Not Allowed: Shifting to left". So try to modify the range as follows:

1. Modify the Start IP address alone to 10.23.226.1 and Apply the changes. This will take effect since this falls under the category of Expanding the scope.

2. Then modify the end ip address to 10.23.227.254 and Apply the changes. This will take effect since it falls under the category of Shrinking or Contracting the scope.
