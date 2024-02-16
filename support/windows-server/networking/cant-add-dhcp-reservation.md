---
title: Can't add a DHCP reservation that is outside of the scope distribution range
description: Provides a solution to an issue where you can't add a DHCP reservation that is outside of the scope distribution range.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, btoth, miodon, joelch
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# You cannot add a DHCP reservation that is outside of the scope distribution range in Windows Server

This article provides a solution to an issue where you can't add a DHCP reservation that is outside of the scope distribution range.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2005980

## Symptoms

In Windows Server, you cannot add a reservation using the Dynamic Host Configuration Protocol (DHCP) MMC or netsh commands if the reservation is outside of the distribution range of the DHCP scope, even if it falls in the subnet defined by the subnet mask of  the scope.

Example

Scope: 10.10.0.0  
Distribution Range: 10.10.1.21-10.10.1.230  
Subnet Mask: 255.255.254.0  
Reservation: 10.10.0.164

Adding the IP address 10.10.0.164 will fail. The message that will be displayed is:

> The specified DHCP client is not a reserved client  

## Cause

When adding a new reservation, the DHCP server checks if the IP address is within the defined distribution range of the scope.

## Resolution

This is by design. If the DHCP scope range does not cover the whole subnet defined by the subnet mask, you cannot add a reservation outside of the configured range. You can, however, extend the distribution range so that the whole subnet is covered, and specify the reservation after this step. If you do not want to distribute addresses from the whole subnet, you can also define an exclusion range. A reservation that falls into an exclusion range will still work.  

## More information

Adding a reservation that is outside of the distribution range of a scope was possible in Windows Server 2003 and Windows Server 2008.

However, this is considered to be an invalid configuration and as such, the behavior has been changed so that it isn't possible anymore to create such a reservation.
