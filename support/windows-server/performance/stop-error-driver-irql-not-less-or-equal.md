---
title: Stop error "DRIVER_IRQL_NOT_LESS_OR_EQUAL"
description: Helps to fix the error "DRIVER_IRQL_NOT_LESS_OR_EQUAL" or "USER_MODE_HEALTH_MONITOR"
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan 
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Blue Screen/Bugcheck
ms.technology: Performance
---
# Stop error message: "DRIVER_IRQL_NOT_LESS_OR_EQUAL" or "USER_MODE_HEALTH_MONITOR"

This article helps to fix the error "DRIVER_IRQL_NOT_LESS_OR_EQUAL" or "USER_MODE_HEALTH_MONITOR".

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2863960

## Symptoms

On a Windows Server 2012-based computer, you receive a Stop error message that is similar to one of the following:

>Your PC ran into a problem and needs to restart. We're just colleting some error info, and then we'll restart for you. (0% complete)
If you would like to know more, you can search online later for this error: DRIVER_IRQL_NOT_LESS_OR_EQUAL

Or

>Your PC ran into a problem and needs to restart. We're just colleting some error info, and then we'll restart for you. (0% complete)
If you would like to know more, you can search online later for this error: USER_MODE_HEALTH_MONITOR

> [!NOTE]
> Not all "DRIVER_IRQL_NOT_LESS_OR_EQUAL" and "USER_MODE_HEALTH_MONITOR" errors are caused by this issue.

## Cause

This problem occurs with HP Smart Array SCSI or SAS/SATA Controllers driver HpCISSS2 driver version 62.26.0.64.

## Resolution

To resolve this problem, you need to downgrade the HPCISSS2 driver to 62.24.2.64. 

The HPCISSS2.SYS version 62.24.2.64 is available here: [http://www.hp.com/swpublishing/MTX-9175345236064183975c0c817f](http://www.hp.com/swpublishing/mtx-9175345236064183975c0c817f) 

## More information

This blue screen error occurs because of a portion of the Smart Array firmware that deals with 64-bit command submissions. HP Windows Server 2012 HPCISSS2.SYS driver Version 62.26.0.64 exposes this error condition because it is the first driver to enable 64-bit command addressing feature support.

HP Customer Advisory is located [here](http://h20566.www2.hp.com/portal/site/hpsc/template.page/public/help/docdisplay/?javax.portlet.begcachetok=com.vignette.cachetoken&javax.portlet.endcachetok=com.vignette.cachetoken&javax.portlet.prp_ba847bafb2a2d782fcbb0710b053ce01=wsrp-navigationalstate%3ddocid%253demr_na-c03793656-2%257cdoclocale%253d%257ccalledby%253d&javax.portlet.tpst=ba847bafb2a2d782fcbb0710b053ce01&ac.admitted=1371740522281.876444892.199480143).
