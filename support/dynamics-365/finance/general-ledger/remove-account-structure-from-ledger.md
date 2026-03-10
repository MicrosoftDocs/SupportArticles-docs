---
# required metadata
title: Unable to remove an account structure from the general ledger
description: Troubleshooting steps for removing account structures that are in use
author: ethanrimes
ms.date: 02/10/2026
---

# Unable to remove an account structure from the general ledger

This article helps troubleshoot problems removing an account structure from your general ledger.

## Symptoms

User is trying to remove an Account structure from the Ledger setup. However, they receive the error "Account structure [Account structure being removed] can't be deleted because it is in use by the general journal in [Company]. You must first update the general journal."*

## Resolution

**Blocking unposted transactions**

An unposted transaction is blocking if it references an account structure you are trying to modify or delete, and the modification would make that transaction invalid. The system prevents the change until these transactions are resolved.

To find blocking transactions, follow these steps:
1. Go to **General ledger > Journal entries > General journals**.
2. Filter by **Show > Not posted**.
3. Select a journal and click **Lines** in the action pane to view its transactions.
4. Transactions that reference the account structure can be removed with the **Delete** button or updated to reference a different ledger account or offset account.

### Reuse an existing account structure

First, address blocking unposted transactions using the instructions above. Specifically, unposted transactions that reference an account and would be invalidated by this modification are considered blocking.

1. Go to **General ledger > Structures > Configure account structures** and select the desired account.
2. Click **Edit** in the action pane, replace the outdated account structure's criteria with relevant criteria for your business scenario.
3. Click **Validate** to validate your changes.
4. Click **Activate** to save your changes and wait for successful activation.

Modification of an account structure is suitable for:
- Broadening an account structure's range. For example, changing from 1000-2000 to 1000-3000.
- Restricting an account structure's range. For example, specifying **Department** segment range 012-014.
- Subdividing a main account. For example, a user may modify **BalanceSheet** structure with range 1000-3000 into **BalanceSheet_Small** with range 1000-2000 and then create **BalanceSheet_Large** with range 2000-3000. For performance reasons, this is preferable to deleting **BalanceSheet** outright and creating two new main accounts. 

### Delete the account structure

If the account structure is no longer needed, address any blocking unposted transactions using the instructions above before attempting deletion.
If you can't find the blocking unposted transactions, contact support.
