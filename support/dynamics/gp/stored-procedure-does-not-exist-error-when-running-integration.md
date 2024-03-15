---
title: Cannot run integration via eConnect destination adapter
description: Describes how to resolve the stored procedure error for a Microsoft Dynamics GP eConnect destination adapter in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley, grwill, dclauson
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Stored procedure doesn't exist error when running an integration via a Dynamics GP eConnect destination adapter

This article provides a resolution for the issue that you can't run an integration by using a Microsoft Dynamics GP eConnect destination adapter in Integration Manager for Microsoft Dynamics GP due to an eConnect error.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 951775

## Symptoms

When you try to run an integration by using a Microsoft Dynamics GP eConnect destination adapter in Integration Manager for Microsoft Dynamics GP, you receive the following error message:

> DOC X ERROR: eConnect error - The stored procedure **procedure_name** doesn't exist.

> [!NOTE]
> In this error message, *procedure_name* is a placeholder for the name of the eConnect SQL stored procedure that is used in the integration.

## Cause

This problem occurs because the user account that is specified in the eConnect 10 for Microsoft Dynamics GP Microsoft COM+ component does not have the required permissions for the Microsoft Dynamics GP databases in Microsoft SQL Server.

## Resolution

The user account that is specified in the eConnect 10 for Microsoft Dynamics GP COM+ component must be a member of the DYNGRP role for the DYNAMICS database and for the company databases in SQL Server. This user account must be a member of the DYNGRP role to have the Execute permission for the required eConnect SQL stored procedures.

To determine which user account is specified in the eConnect 10 for Microsoft Dynamics GP COM+ component, follow these steps:

1. Select **Start**, select **Run**, type *dcomcnfg* in the **Open** box, and then select **OK**.

2. In Component Services, expand **Component Services**, expand **Computers**, expand **My Computer**, and then expand **COM+ Applications**.

3. Right-click **eConnect 10 for Microsoft Dynamics GP**, and then select **Properties**.

4. Select the **Identity** tab.

The user account that is configured under **This user** is the user account that connects to SQL Server.
