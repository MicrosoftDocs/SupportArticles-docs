---
title: SCSI-3 Persistent Reservation test fails
description: Provides a solution to an issue where the SCSI-3 Persistent Reservation test fails when you run the Failover Cluster Validation report.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: jburrage, kaushika
ms.custom: sap:errors-when-running-the-validation-wizard, csstroubleshoot
---
# Cluster validation fails the SCSI-3 Persistent Reservation test in Windows Server

This article provides a solution to an issue where the SCSI-3 Persistent Reservation test fails when you run the Failover Cluster Validation report.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2822335

## Symptoms

When running the Failover Cluster Validation report on an existing cluster configured in Windows Server 2008 R2 Service Pack 1, the SCSI-3 Persistent Reservation test may fail with the following error:

> Failed to access cluster disk 0 from node \<node name> status 31  
> Cluster Disk 0 does not support Persistent Reservations. Some storage devices require specific firmware versions or settings to function properly with failover clusters. Please contact your storage administrator or storage vendor to check the configuration of the storage to allow it to function properly with failover clusters.

## Cause

Some Storage devices have a defined limit in the amount of SCSI-3 registrations or reservations that it can handle. The problem comes in where you have exceeded that limit.

## Resolution

Work with the storage vendor to see if there is a firmware update that can raise this limit. If a firmware update is not available, it may require that you move some of your storage to different arrays.
