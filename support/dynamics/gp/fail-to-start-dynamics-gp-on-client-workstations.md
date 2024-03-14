---
title: Error when you start Dynamics GP on a client workstation
description: Describes a problem that occurs because the version of the Dynamics.dic file on the client workstation differs from the version of the Dynamics.dic file that is used in the tables in the Dynamics database.
ms.topic: troubleshooting
ms.reviewer: theley, kyouells
ms.date: 03/13/2024
---
# Error message when you start Microsoft Dynamics GP on a client workstation: "A product on the computer is on a different version than the database version"

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 915897

## Symptoms

When you start Microsoft Dynamics GP 9.0 or Microsoft Dynamics GP 10.0 on a client workstation, you receive the following error message:

> A product on the computer is on a different version than the database version. You will not be able to use the application until this issue is resolved. Use the GP_LoginErrors.log file in your temp directory to assist in resolving this issue.

## Cause 1

This problem occurs when a software update was installed on the server that is running Microsoft SQL Server. However, this software update was not installed on the client workstation. If the client workstation does not have the software update installed, the version of the Dynamics.dic file differs from the version of the Dynamics.dic file that is used in the tables in the Dynamics database. To resolve this problem, see [Resolution 1](#resolution-1).

> [!NOTE]
> You can view the GP_LoginErrors.log file to compare the versions of the products that are installed on the workstation to the versions of the products that are installed on the server. To locate the GP_LoginErrors.log file, click **Start**, click **Run**, type *%temp%*, and then click **OK** to open the Temp folder for the user.

## Cause 2

This problem occurs when a translated release of Microsoft Dynamics GP 9.0 was installed. However, the translated release of the client version does not match the database version. To resolve this problem, see [Resolution 2](#resolution-2).

## Cause 3

This problem occurs when you are install Microsoft Dynamics GP 10.0 Service Pack 1, and the databases have not been updated to the Service Pack 1 version (version 10.00.0903). To resolve this problem, see [Resolution 3](#resolution-3).

## Cause 4

This problem occurs if the following conditions are true:

- An additional sub-feature is installed on a client instance of Microsoft Dynamics GP.
- The additional sub-feature was not installed on the Server/Client instance first to create the tables for the additional sub-feature. To resolve this problem, see [Resolution 4](#resolution-4).

## Resolution 1

To resolve this problem, install the same update on all the client workstations.

## Resolution 2

To resolve this problem, install the appropriate update for the translated release of the client version so that it matches the database version.

## Resolution 3

To resolve this problem, download and then install the latest update for Microsoft Dynamics GP 10.0.

## Resolution 4

To resolve this problem, install the additional sub-feature on the Server/Client instance of Microsoft Dynamics GP. Additionally, start Microsoft Dynamics GP Utilities to update the databases with the additional sub-feature information. After you do this, the client version starts successfully.
