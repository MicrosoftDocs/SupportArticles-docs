---
# required metadata
title: Unable to remove account structure from ledger
description: Troubleshooting steps for removing account structures that are in use
author: ethanrimes
ms.date: 02/10/2026
---

# Unable to remove account structure from ledger

This article helps troubleshoot problems removing an account structure from your general ledger.

## Symptoms

Customer is trying to remove an Accounts Structure from Ledger Setup. However, they receive the error *"Account structure [Account structure being removed] cannot be deleted because it is in use by the general journal in [Company]. You must first update the general journal."*

## Resolution

**Blocking unposted transactions**

Any modification to an account structure which would invalidate unposted transactions will be blocked. This modification may be a change to or a deletion of its account structure.

Blocking unposted transactions can be found on the unposted journals at **General ledger > Journal entries > General journals** by choosing the filter **Show > Not posted**. 

To view each journal's transactions, select the journal and click **Lines** in the action pane. Transactions which reference the account structure to be deleted can removed with the **Delete** button or can be changed to a different ledger account/offset account.

**Resolution 1: Reusing existing account structure**

First, address blocking unposted transactions via the instructions above. Subsequently, navigate to **General ledger > Structures > Configure account structures** and select the desired account. Click **Edit** in the action pane, replace the outdated account structure's criteria with relevant criteria for your business scenario and then validate your changes with the **Validate** button. Finally, save your changes with the **Activate** button and wait for successful activation.

Modification of an account structure is suitable for:
- Broadening an account structure's range (e.g. changing from 1000-2000 to 1000-3000)
- Restricting an account structure's range (e.g. specifying **Department** segment range 012-014)
- Subdividing a main account. For example, a user may modify **BalanceSheet** structure with range 1000-3000 into **BalanceSheet_Small** with range 1000-2000 and then create **BalanceSheet_Large** with range 2000-3000. For performance reasons, this is preferable to deleting **BalanceSheet** outright and creating two new main accounts. 

**Resolution 2: True deletion of account structure**

If the account structure is no longer needed, follow the instructions above to remove unposted transactions. After doing so, you may be able to delete the existing account structure.

If you are unable to find the unposted transaction or transactions which are blocking you, contact support.