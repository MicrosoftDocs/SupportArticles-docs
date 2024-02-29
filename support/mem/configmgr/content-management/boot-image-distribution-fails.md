---
title: Can't distribute a boot image to a PXE enabled DP
description: Describes a behavior where you can't distribute a boot image to a PXE enabled distribution point if the NO_SMS_ON_DRIVE.SMS file is on the partition that's used to host the content library.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi
---
# Distribution of a boot image to a PXE enabled distribution point fails in Configuration Manager

This article describes a behavior where you can't distribute a boot image to a PXE enabled distribution point if the **NO_SMS_ON_DRIVE.SMS** file is on the partition that's used to host the content library.

_Original product version:_ &nbsp; System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2794136

## Summary

Copying a boot image to a PXE enabled distribution point in System Center 2012 Configuration Manager fails if the **NO_SMS_ON_DRIVE.SMS** file is placed on the same partition on which the content library is located.  

The error message below is generated in the distmgr.log:

> STATMSG: ID=2375 SEV=I LEV=M SOURCE="SMS Server" COMP="SMS_DISTRIBUTION_MANAGER" SYS=COMPUTERNAME.COM SITE=SS1 PID=2244 TID=3472 GMTDATE=Mo Aug 06 22:12:55.329 2012 ISTR0="["Display=\\\computername.COM\\"]MSWNET:["SMS_SITE=SS1"]\\\ computername.COM \\" ISTR1="" ISTR2="" ISTR3="" ISTR4="" ISTR5="" ISTR6="" ISTR7="" ISTR8="" ISTR9="" NUMATTRS=1 AID0=404 AVAL0="["Display=\\\COMPUTERNAME.COM\\"]MSWNET:["SMS_SITE=SS1"]\\\ computername.COM \\" SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90)  
> User (NT AUTHORITY\SYSTEM) running application(SMS_DISTRIBUTION_MANAGER) from machine (COMPUTERNAME.COM) is submitting SDK changes from site(SS1) SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90)  
> RDC: Successfully created package signature file from \\\\?\C:\SMSPKGSIG\CAS0000F.2 to \\\COMPUTERNAME.COM\SMSSIG$\CAS0000F.2.tar SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90) Setting permissions on file MSWNET:["SMS_SITE=SS1"]\\\COMPUTERNAME.COM\SMSSIG$\CAS0000F.2.tar. SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90) ExpandPXEImage: CAS0000F, 16778240 SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90)  
> CContentDefinition::GetFileProperties failed; 0x80070003 SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90)  
> CContentDefinition::TotalFileSizes failed; 0x80070003 SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90)  
> ExpandPXEImage failed; 0x80070003 SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90)  
> Error occurred. Performing error cleanup prior to returning. SMS_DISTRIBUTION_MANAGER 07.08.2012 00:12:55 3472 (0x0D90)

## More information

This behavior is expected if the **NO_SMS_ON_DRIVE.SMS** file is placed on the drive after using it to host the content library.

To resolve the issue, remove the **NO_SMS_ON_DRIVE.SMS** file from the partition used to host the content library.
