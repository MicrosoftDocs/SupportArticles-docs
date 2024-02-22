---
title: Fail to move Windows Server to a domain
description: Provides a solution to an issue that you receive the error message (The wizard cannot gain access to the list of domains in the forest) when you use Dcpromo.exe to move a Windows Server into an existing domain.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:dcpromo-and-the-installation-of-domain-controllers, csstroubleshoot
---
# Error message: The wizard cannot gain access to the list of domains in the forest

This article helps fix the error (The wizard cannot gain access to the list of domains in the forest) that occurs when you use Dcpromo.exe to move a Windows Server into an existing domain.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 259374

## Symptoms

When you attempt to use Dcpromo.exe to move a Windows 2000-based, or a Windows Server 2003-based server into an existing domain, the following error message may be displayed:

Active Directory Installation Wizard

The wizard cannot gain access to the list of domains in the forest. The error is:

The specified domain either does not exist or could not be contacted.
If you are using Windows Server 2008, the error message may resemble the following: Active Directory Installation Wizard

The wizard cannot access the list of domains in the forest. The error is:

The network path was not found.

## Cause

This problem can occur if the server that is running the Domain Name System (DNS) service has not registered an "A" record for itself in DNS.

The SRV records for the domain controllers must be in the DNS database. If the "A" record for the DNS server is missing, the process does not succeed.

## Resolution

You can add the "A" record to DNS by issuing the following command at the DNS server:

ipconfig /registerdns
After verifying that an "A" record is present for the DNS server, you may receive the following error message when you attempt to continue the Dcpromo.exe process:

Active Directory Installation Wizard

The wizard cannot gain access to the list of domain in the forest. The error is:

The RPC server is unavailable.

To resolve this problem, type the following command on the server on which you try to use Dcpromo.exe. This command clears the DNS resolver cache on the computer that is running Dcpromo.exe so that it re-creates the query after the "A" record for the DNS server is registered in the DNS database.ipconfig /flushdns

This problem can also occur during the Dcpromo.exe process if the existing domain controller that is authenticating this process does not have file and printer sharing enabled on its network adapter. To resolve this issue, enable file and printer sharing on the existing domain controller until the Dcpromo.exe process is complete.
