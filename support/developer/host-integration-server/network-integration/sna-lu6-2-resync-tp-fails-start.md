---
title: SNA LU6.2 Resync TP fails to start
description: This article describes that the SNA LU6.2 Resync TP service (Resyncsvc.exe) fails to start on a Host Integration Server 2000 or HIS 2004 server that is operating in client mode when configured to connect to an SNA Server 4.0 system.
ms.date: 10/13/2020
ms.custom: sap:Network Integration (SNA Gateway)
ms.topic: article
---
# SNA LU6.2 Resync TP Service logs event 131 and fails to Start in Host Integration Server 2000 or 2004

This article describes that the SNA LU6.2 Resync TP service (Resyncsvc.exe) fails to start on a Host Integration Server (HIS) 2000 or HIS 2004 server that is operating in client mode when configured to connect to an SNA Server 4.0 system.

_Original product version:_ &nbsp; Host Integration Server  
_Original KB number:_ &nbsp; 311948

## Symptoms

The SNA LU6.2 Resync TP service (Resyncsvc.exe) fails to start on a HIS 2000 or HIS 2004 server that is operating in client mode when configured to connect to an SNA Server 4.0 system. In addition, the following event will be logged in the Application Event Log on the HIS system:

> Event ID: 131
Source: SNA LU6.2 Resync TP
Description: (131) The Resynchronization Service was unable to initialize interfaces to the WMI Provider.
>
> EXPLANATION  
The Resynchronization Service encountered HRESULT 8004100E when trying to obtain SNA configuration information from the HIS WMI namespace. The service is unable to initialize its environment and prepare for transactions. This may indicate that the primary SNA configuration server or other SNA server service has become inactive or unreachable on the network, or that the HIS was not installed properly.

The HRESULT listed in the explanation of the Event 131 may vary. The following are common HRESULT errors that may be returned:

> 8004100E - WBEM_E_INVALID_NAMESPACE  
80040154 - REGDB_E_CLASSNOTREG

## Cause

The SNA LU6.2 Resync TP in HIS needs to read the HIS configuration file (COM.cfg) to determine which Advanced Program-to-Program Communications (APPC) Logical Units (LUs) are configured for SyncPoint support. The SNA LU6.2 Resync TP is designed to use Windows Management Instrumentation (WMI) to read the HIS configuration.

SNA Server 4.0 (and earlier) does not support WMI, so the SNA LU6.2 Resync TP is unable to read an SNA Server 4.0 configuration to obtain the APPC LU information that it requires. This results in the Event 131 and the service's failure to start.

This behavior is by design since SNA Server 4.0 and earlier do not support WMI.

## Status

This behavior is by design because SNA Server 4.0 (and earlier) does not support WMI.

## More information

The SNA LU6.2 Resync TP service works with Distributed Transaction Coordinator (DTC) to perform automatic recovery to a consistent state in the face of failures at any point in a two-phase commit (2PC) transaction.

The SNA LU6.2 Resync TP service is installed by default when an HIS Server is installed. This service is not available when you install either the HIS End-User Client or the HIS Admin Client.

An HIS Server can be installed in client (or 'Nodeless') mode if the SNA Service component under "SNA Application Support" is deselected during the installation process. The SNA LU6.2 Resync TP service is still installed when you are installing HIS Server in client mode.

When HIS is installed in client mode, the SNA Resource Location Wizard will be presented at the end of the installation process to allow the HIS in client mode to be configured to locate a HIS or SNA Server. If the HIS in client mode is configured to connect to an SNA Server 4.0 system, the SNA LU6.2 Resync TP service will fail to start as described previously.
