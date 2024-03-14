---
title: Management Reporter 2012 Base diagnostic
description: Describes the tasks that are performed by the Management Reporter 2012 Base diagnostic.
ms.reviewer: theley, kellybj, kevogt
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# [SDP 3][882c45ca-18ab-4e13-a1bf-8b23b96a8e4e] Management Reporter 2012 Base diagnostic

The Management Reporter 2012 Base diagnostic reviews your Management Reporter 2012 environment and looks for known issues. This diagnostic also collects general information about your Management Reporter 2012 environment and provides this information to Support.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2698359

When you run this diagnostic, you are prompted to type the name of the server where the Management Reporter 2012 Services is located. You must be a local administrator on this server for the diagnostic to run successfully.

This diagnostic collects the following information:

MR General Environment Information:

- MRServiceHost.exe version
- Process Service server name
- Process Service Log In As user
- Process Server machine domain
- Application Service Log In As User
- Application Service state
- Application Service port
- Application Service port state
- Local machine name
- SQL Server version
- MR Database Schema version
- MR User Role
- IE Versions Installed
- IE Proxy Information
- GL Client Version
- GL System Version

MR Local Client Information:

- Client Install Path
- Client version
- Server Connection string

MR Provider/Adapter DL version lists

Datamart Integrations

Legacy Integrations

MR Integration Logs (last 10000 records)

MR Server Event Viewer logs (last 30 errors)

MR Deployment logs

MR Performance Data
