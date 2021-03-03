---
title: RODC logs DNS event 4015 with error code 00002095
description: Describes event ID 4015 that occurs when you run the Domain Name Service (DNS) role on a Read-Only Domain Controller (RODC) and a writable Domain Controller (hosting DNS) isn't accessible.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: DNS
ms.technology: networking
---
# RODC logs DNS event 4015 every three minutes with error code 00002095

This article describes event ID 4015 that occurs when you run the Domain Name Service (DNS) role on a Read-Only Domain Controller (RODC) and a writable Domain Controller (hosting DNS) isn't accessible.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 969488

## Symptoms

If we're running the Domain Name Service (DNS) role on a Read-Only Domain Controller (RODC) and a writable Domain Controller (hosting DNS) isn't accessible, we see the following event being logged on the RODC.

> Log Name: DNS Server  
Source: Microsoft-Windows-DNS-Server-Service  
Date: *date time*  
Event ID: 4015  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: *computer_name*  
Description:  
The DNS server has encountered a critical error from the Active Directory. Check that the Active Directory is functioning properly. The extended error debug information (which may be empty) is "00002095: SvcErr: DSID-03210A6A, problem 5012 (DIR_ERROR), data 16". The event data contains the error.

## Cause

When a Read Only Domain Controller (RODC) locates a writeable DNS server to perform ReplicateSingleObject (RSO), it performs a DSGETDC function with the following flags set:

DS_AVOID_SELF  
DS_TRY_NEXTCLOSEST_SITE  
DS_DIRECTORY_SERVICE_6_REQUIRED  
DS_WRITEABLE_REQUIRED  

Once a DC is returned from the DSGETDC call, it uses the result to search for the NS record in DNS. If the DSGETDC call fails, or it fails to find the NS record of the DC returned from DSGETDC, the error 4105 will be logged.

Possible causes of the 4105 error:

1) No writeable DC is accessible, or none returned from DSGETDC call

2) The DSGETDC call was successful, but the DC returned doesn't have the DNS Server Role installed, or doesn't register an NS record in DNS.

The following command can be ran from the RODC to check which DC is returned from the DSGETDC call:

```console
nltest /dsgetdc: DOMAIN.COM /WRITABLE /AVOIDSELF /TRY_NEXT_CLOSEST_SITE /DS_6
```
  
Where `DOMAIN.COM` is your domain name.

## Resolution

To resolve either cause above, ensure that a writable DC is accessible from the RODC, that the DNS Server Role is installed on that DC, and that the NS record is registered in DNS for the writable DC.

## More information

For more information about the DSGETDC function, see TechNet article:

[DsGetDcNameA function](/windows/win32/api/dsgetdc/nf-dsgetdc-dsgetdcnamea)

## Disclaimer

Microsoft and/or its suppliers make no representations or warranties about the suitability, reliability, or accuracy of the information contained in the documents and related graphics published on this website (the "materials") for any purpose. The materials may include technical inaccuracies or typographical errors and may be revised at any time without notice.

To the maximum extent permitted by applicable law, Microsoft and/or its suppliers disclaim and exclude all representations, warranties, and conditions whether express, implied, or statutory, including but not limited to representations, warranties, or conditions of title, non-infringement, satisfactory condition or quality, merchantability and fitness for a particular purpose, with respect to the materials.
