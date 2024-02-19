---
title: Certutil -view doesn't return issued certificates
description: Fixes an issue where the Certutil -view command doesn't return issued certificates correctly.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, jtierney
ms.custom: sap:certificate-enrollment, csstroubleshoot
---
# "Certutil -view" command does not return issued certificates correctly

This article provides help to fix an issue where the `Certutil -view`command doesn't return issued certificates correctly.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2233022

## Symptoms

The Certutil command-line tool can be used to display the certificates that have been issued by a certification authority using the -view parameter. Under some circumstances, Certutil may not display all the expected certificates.  

For example, the following command would not return the expected number of certificates:

```console
certutil -view -restrict "RequesterName=contoso\twt"  
```

Output would be similar to the following:

> Maximum Row Index: 0  
0 Rows  
0 Row Properties, Total Size = 0, Max Size = 0, Ave Size = 0  
0 Request Attributes, Total Size = 0, Max Size = 0, Ave Size = 0  
0 Certificate Extensions, Total Size = 0, Max Size = 0, Ave Size = 0  
0 Total Fields, Total Size = 0, Max Size = 0, Ave Size = 0  
CertUtil: -view command completed successfully.

## Cause

This issue is a result of how Certutil handles parsing for the -view parameter. Specifically, there is an issue with how it parses the following escape characters: \n, \r, and \t.

## Resolution

The workaround is to uppercase all requester name strings passed as restrictions on the Certutil command line.

For example, instead of using this command:  

```console
certutil -view -restrict "RequesterName=contoso\twt"
```
  
Use this command:

```console
certutil -view -restrict "RequesterName=contoso\TWT"
```
