---
title: Can't connect to a named instance
description: This article provides resolutions where you might not be able to connect to a named instance of Analysis Services that is installed on a failover cluster.
ms.date: 05/09/2025
ms.custom: sap:Analysis Services
ms.reviewer: karang, gasadas
---
# Cannot connect to a named instance of a clustered analysis service

This article helps you resolve the problem where you might not be able to connect to a named instance of Analysis Services that is installed on a failover cluster.

_Original product version:_ &nbsp; SQL Server    
_Original KB number:_ &nbsp; 2429685

## Symptoms

You might not able to connect to a named instance of Analysis Services that is installed on a failover cluster. You may receive an error message that is similar to the following:

> Cannot connect to \<server name>  
>
> ADDITIONAL INFORMATION:
>
> A connection cannot be made. Ensure that the server is running. (Microsoft.AnalysisServices.AdomdClient)
>
> No connection could be made because the target machine actively refused it \<ip address>:2383 (System)

## Cause

The problem occurs when you start the named instance of SQL Server Analysis services (SSAS) using either SQL Server Configuration Manager or the Services applet in the Control panel.
When you start an SSAS instance on a failover cluster using a tool other than Failover Cluster Management (Cluster administrator on older Operating Systems), that SSAS instance will run as a stand-alone instance and will listen on a non-default port resulting in connection failures from various applications.

## Resolution

Stop and restart the SQL Server Analysis services using the Failover Cluster Management tool.

## More information

An SSAS instance started on a cluster (default or named instance) will start listening on all IP addresses of the cluster group using the default port of 2383. The server setting `<Port>` property does not change the port number of SSAS service on a cluster.

