---
title: Some clients are assigned to the wrong site code
description: Fixes an issue where some clients may be assigned to the incorrect site code in System Center Configuration Manager 2007.
ms.date: 08/20/2020
ms.prod: configuration-manager
ms.prod-support-area-path:
ms.reviewer: clintk
---
# Some clients may be assigned to the wrong site code in System Center Configuration Manager 2007

This article helps you fix an issue where some clients may be assigned to the incorrect site code in Microsoft System Center Configuration Manager 2007.

_Original product version:_ &nbsp; System Center Configuration Manager 2007  
_Original KB number:_ &nbsp; 2002059

## Symptoms

When using System Center Configuration Manager 2007, some clients may be assigned to the incorrect site code. You may also see entries similar to those below in the locationservices.log file:

> DhcpGetOriginalSubnetMask entry point not supported.  
> Current AD site of machine is *ADSite1*  
> This client might be within the boundaries of more than one site - AD SiteCode search matched 2 entries  
> The client will be assigned to the first valid site  
> LSGetAssignedSiteFromAD : Trying to Assign to the Site \<*P04*>  
> LSVerifySiteVersion : Verifying Site Version for \<*P04*>  
> LSGetSiteVersionFromAD : Successfully retrieved version '4.00.6221.0000' for site '<*P04*>'  
> LSVerifySiteVersion : Verified Client Version '4.00.6221.1000' is not greater than Site Version '4.00.6221.0000'. Client can be assigned to site \<*P04*>.  
> Executing Task LSRefreshLocationsTask  

In the example above, the client should have been assigned to site P01 but was instead assigned to site *P04*.

## Cause

This can occur if Active Directory references more than one site with the same site boundary.

## Resolution

Remove or correct the site that contains objects using the same boundaries. To identify sites using the same boundaries, run `ldifde -f output.txt` from a command prompt and search the text file for the related boundary (*ADSite1* in the example above).

## More information

In many cases, this situation occurs because a site is deleted instead of being deinstalled. Doing this leaves the Active Directory objects behind which results in a duplicate boundary if another site is later added that contains the boundary used in the previously deleted site.