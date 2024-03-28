---
title: Size Limit Exceeded - Error Code 0x4 during delta import
description: Learn how to resolve the Size Limit Exceeded - Error Code 0x4 error during the delta import step for an on-premises connector in Microsoft Entra Connect.
ms.date: 05/31/2023
author: DevOpsStyle
ms.author: tommasosacco
editor: v-jsitser
ms.reviewer: v-leedennis, nualex
ms.service: entra-id
ms.subservice: users
---
# "Size Limit Exceeded - Error Code 0x4" error message during delta import in Microsoft Entra Connect

This article discusses how to troubleshoot the "Size Limit Exceeded - Error Code 0x4" error message that occurs during the delta import step from an on-premises Active Directory in Microsoft Entra Connect.

## Symptoms

In the Synchronization Service Manager app, the **Delta Import** steps from the on-premises Active Directory [connector](/azure/active-directory/hybrid/connect/how-to-connect-sync-service-manager-ui-operations) fail. The **Connection Log** dialog box displays a **dropped-connection** status, a **Size Limit Exceeded** error, and an error code of **0x4**:

:::image type="content" source="./media/size-limit-exceeded/synchronization-service-manager-dropped-connection.png" alt-text="Screenshot of the Synchronization Service Manager app's Operations tab. The Connection Log dialog box shows a dropped-connection incident." lightbox="./media/size-limit-exceeded/synchronization-service-manager-dropped-connection.png":::

In the Application log, the error event ID 6050 is recorded, as shown in the following example:

```output
Log Name:      Application
Source:        ADSync
Date:          5/12/2023 7:34:38 AM
Event ID:      6050
Task Category: Management Agent Run Profile
Level:         Error
Keywords:      Classic
User:          N/A
Computer:      AADConnect.Contoso.com
Description:
The management agent "Contoso.com" failed on run profile "Delta Import" because of connectivity issues.
 
 Additional Information
 Discovery Errors       : "0"
 Synchronization Errors : "0"
 Metaverse Retry Errors : "0"
 Export Errors          : "0"
 Warnings               : "0"
 
 User Action
 View the management agent run history for details.
```


## Cause

By default, when you make a Lightweight Directory Access Protocol (LDAP) search or query in Microsoft Entra ID, the directory can return no more than 1,000 records. By security design, this is the default behavior of Active Directory. The 1,000-record limit is intended to prevent a distributed denial-of-service (DDoS) attack on LDAP queries. This issue can occur if you recently restored a large number of objects simultaneously from the Active Directory Recycle Bin. The restore process can cause the delta import query to exceed the record limit.

## Solution 1: Run a full import on the AD DS connector

The easiest resolution to this issue is to manually run a full import (instead of a delta import) on the Active Directory Domain Services (AD DS) connector. Follow these steps:

1. Select **Start**, and then search for and select **Synchronization Service Manager**.

2. In the **Synchronization Service Manager** window, select the **Delta Import** step of the on-premises AD Connector that isn't connecting. Look for the Delta Import step that shows a **stopped-connectivity** status.

3. Select <kbd>Ctrl</kbd>+<kbd>F5</kbd>, or right-click your selection, and then select **Run**.

4. In the **Run Connector** dialog box, select the **Full Import** run profile, and then select **OK**.

After the full import finishes, open a PowerShell console, and run the `Start-ADSyncSyncCycle` cmdlet to start a normal delta synchronization cycle. This process is described in [Microsoft Entra Connect Sync: Scheduler][Start-ADSyncSyncCycle].

## Solution 2: Temporarily increase the record limit

If you don't want to run a full import on the AD DS connector, you can temporarily change your configuration so that an LDAP search can return a larger number of records during delta synchronization.

To increase the 1,000-record limit, increase the maximum page size (`MaxPageSize`) setting to accommodate the number of objects that the delta import step returns. For example, if you restored an Organization Unit (OU) that has 5,000 users, we recommend that you temporarily increase `MaxPageSize` to a value of 5,000. Then, after the Microsoft Entra Connect issue is resolved, restore `MaxPageSize` to the default value of 1,000.

To change the `MaxPageSize` setting, run the [Ntdsutil](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc753343(v=ws.11)) command, as shown in the following procedure. For more information about `MaxPageSize`, see [LDAP administration limits](../../../windows-server/identity/view-set-ldap-policy-using-ntdsutil.md#ldap-administration-limits).

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the default AD configuration incorrectly. When the issue is resolved, you can restore the default values.

1. Select **Start**, enter *Command Prompt*, and then select **Run as administrator**.

2. At the command prompt, enter `ntdsutil` to start an Ntdsutil console session.

3. In the [View and set LDAP policy in Active Directory by using Ntdsutil.exe](../../../windows-server/identity/view-set-ldap-policy-using-ntdsutil.md) article, follow the instructions in the [View current policy settings](../../../windows-server/identity/view-set-ldap-policy-using-ntdsutil.md#view-current-policy-settings) section to learn what the policy settings currently are.

4. To change the maximum page size, enter `set MaxPageSize to <new-maximum-page-size-value>`.

5. Enter `commit changes` to apply the new value.

6. To exit the Ntdsutil session, enter `quit` two times.

After you make the configuration change, open a PowerShell console, and then run the `Start-ADSyncSyncCycle` cmdlet to start a normal delta synchronization cycle. This process is described in [Microsoft Entra Connect Sync: Scheduler][Start-ADSyncSyncCycle]. Now, Active Directory returns a larger number of records, and it should be able to provide the full delta response to Microsoft Entra Connect.

After the delta synchronization finishes successfully, repeat the procedure to restore the `MaxPageSize` setting to its original value (1,000).

## References

[LDAP policies](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc770976(v=ws.11))

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]

[Start-ADSyncSyncCycle]: /azure/active-directory/hybrid/connect/how-to-connect-sync-feature-scheduler
