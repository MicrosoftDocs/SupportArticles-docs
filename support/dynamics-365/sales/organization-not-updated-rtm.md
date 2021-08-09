---
title: Organization is not updated to RTM
description: This article provides a resolution for the problem that occurs when you install Microsoft Dynamics CRM 2011 RTM, and then import an RC organization.
ms.reviewer: ehagen, mmaasjo
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# When you import a Microsoft Dynamics CRM 2011 RC organization into a Microsoft Dynamics CRM 2011 RTM environment, the database does not get updated

This article helps you resolve the problem that occurs when you install Microsoft Dynamics CRM 2011 RTM, and then import an RC organization.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2511317

## Symptoms

When you install Microsoft Dynamics CRM 2011 RTM, and then import an RC organization, the organization is not updated to RTM as expected. Deployment Manager says an update is available, however running the update does not do anything.

## Cause

The required Microsoft Dynamics CRM 2011 RTM patch has not been installed on the server.

## Resolution

Install the RTM patch on the Microsoft Dynamics CRM Server, which can be found at [An update for Microsoft Dynamics CRM 2011 Release Candidate is available](https://support.microsoft.com/help/2461082).

## More information

The patch will be installed via Windows Update if the server itself was upgraded from RC to RTM. However if the RTM server was installed separately, the update will not be prompted automatically.

If you upgraded a Microsoft Dynamics CRM 4.0 organization into the RC server, you will need to apply a SQL script to the database. This has been documented in KB 2461082.
