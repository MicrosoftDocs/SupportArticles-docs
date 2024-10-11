---
title: License key expired after migrating the Orchestrator database
description: Fixes an issue where you're prompted that the license key is expired in Orchestrator Designer after you migrate an Orchestrator database from one instance of SQL Server to another.
ms.date: 06/26/2024
ms.reviewer: nicholad
---
# Orchestrator Designer generates a prompt for a license key after you migrate the Orchestrator database

This article helps you fix an issue where you're prompted that the license key is expired in Orchestrator Designer after you migrate an Orchestrator database from one instance of Microsoft SQL Server to another.

_Applies to:_ &nbsp; All versions of Orchestrator  
_Original KB number:_ &nbsp; 2920037

## Symptoms

When you migrate the Orchestrator database from one instance of SQL Server to another and then try to open Orchestrator Designer in Microsoft System Center Orchestrator, Orchestrator Designer starts to open and then generates a prompt that indicates that the license key expired. When you enter a valid key and then select **OK**, the same prompt appears.

## Cause

When you migrate the Orchestrator database from one instance of Microsoft SQL Server to another, the service master key (SMK) must also be backed up. Then, this database key must be reapplied on the new instance of SQL Server after the database is restored. If the SMK isn't backed up on the original server, you must re-create the SMK on the new server.

## Resolution

To resolve this issue, follow these steps:

1. Stop the Orchestrator Management service.
2. Open the Orchestrator database on the new instance of SQL Server.
3. Open a new query, and make sure that the Orchestrator database is selected.
4. Execute the following two lines on the database, one at a time:

   1. Delete the old key:

      ```sql
      [Microsoft.SystemCenter.Orchestrator.Cryptography].[DropOrchestratorKeys]
      ```

   2. Create the new key:

      ```sql
      [Microsoft.SystemCenter.Orchestrator.Cryptography].[CreateOrchestratorKeys]
      ```

5. Start the Orchestrator Management service.

When you now open Orchestrator Designer, you're again prompted for the key. When you enter the key, the key works as designed.

## More information

When the Orchestrator database SMK is lost, encrypted data is also lost. For example, variables that were set up with an encrypted password will no longer have values and must be repopulated. For more information about how to correctly migrate the Orchestrator database to a new server, see [Migrate Orchestrator Between Environments](/previous-versions/system-center/system-center-2012-R2/hh913929(v=sc.12)?redirectedfrom=MSDN).
