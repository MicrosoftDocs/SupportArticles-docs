---
title: WCF net.tcp service stops responding
description: This article describes a problem that occurs when you run a .NET Framework 4-based WCF service that uses the net.tcp Port Sharing Service (Smsvchost.exe), and provides a resolution.
ms.date: 05/06/2020
---
# WCF net.tcp service stops responding because of a race condition

This article helps you resolve problems when you run a Microsoft .NET Framework 4-based Windows Communication Foundation (WCF) service that uses the net.tcp Port Sharing Service (Smsvchost.exe). Specifically, a race condition causes the WCF service to hang.

_Original product version:_ &nbsp; .NET Framework 4.5  
_Original KB number:_ &nbsp; 3017663

## Symptoms

Consider the following scenario:

- You have a WCF service installed that uses the net.tcp service.
- You use the net.tcp Port Sharing service (SmSvchost.exe).
- You host this WCF service by using Internet Information Services (IIS) 7.0 or a later version of IIS.

In this scenario, the WCF service occasionally stops responding to requests.

## Cause

A race condition occasionally occurs when the IIS application pool for a net.tcp WCF service is recycled. This recycling can be triggered manually, automatically, or by modifying the application's configuration file while the application is running.

When an application pool recycle occurs, the default settings allow a new worker process to be started during the shutdown of the old process. In rare situations, a race condition may cause the net.tcp Port Sharing service to stop processing requests. At this point, you should restart the net.tcp Port Sharing service.

## Resolution

Use IIS Manager to configure the WCF service's application pool to disallow overlapped recycles. Do this by setting the following advanced settings to true for that application pool:

- Disable **Overlapped Recycle**.
- Disable **Recycling for Configuration Changes**.

Learn more about application pool recycling and other options at [Managing, tuning, and configuring application pools in IIS 7.0](/previous-versions/tn-archive/cc745955(v=technet.10)).
