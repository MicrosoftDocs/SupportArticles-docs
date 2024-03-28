---
title: Microsoft Entra Management Agent hangs during Full Import or Delta Import
description: Provides a resolution to an issue in which the Microsoft Entra Management Agent stops responding with error System.Collections.Generic.KeyNotFoundException.
ms.date: 10/10/2020
ms.service: entra-id
ms.author: genli
author: genlin
ms.reviewer: 
ms.subservice: users
---
# Microsoft Entra Management Agent hangs during Full Import or Delta Import with error: System.Collections.Generic.KeyNotFoundException

This article provides a resolution to an issue in which the Microsoft Entra Management Agent stops responding with error System.Collections.Generic.KeyNotFoundException.

_Original product version:_ &nbsp; Active Directory  
_Original KB number:_ &nbsp; 3096482

## Symptoms

When you run a Full Import or a Delta Import on the Microsoft Entra Connector, one of the following actions occur:

- The following error is logged in the Application log:

    ```
    FIMSynchronizationService Event 6801
    The extensible extension returned an unsupported error.
    The stack trace is:
    "System.Collections.Generic.KeyNotFoundException: The given key was not present in the dictionary.
    at System.Collections.Generic.Dictionary`2.get_Item(TKey key)
    at System.Collections.ObjectModel.KeyedCollection`2.get_Item(TKey key)
    at Microsoft.Azure.ActiveDirectory.Connector.Connector.GetConnectorSpaceEntryChange(SyncObject syncObject)
    at System.Linq.Enumerable.WhereSelectListIterator`2.MoveNext()
    at System.Collections.Generic.List`1.InsertRange(Int32 index, IEnumerable`1 collection)
    at Microsoft.Azure.ActiveDirectory.Connector.Connector.GetImportEntriesCore()
    at Microsoft.Azure.ActiveDirectory.Connector.Connector.GetImportEntries(GetImportEntriesRunStep getImportEntriesRunStep)
    ```

- You receive the following error message:

    ```
    DirectorySynchronization Event 109:
    Failure while importing entries from Windows Azure Active Directory. Exception: System.Collections.Generic.KeyNotFoundException: The given key was not present in the dictionary.
    at System.Collections.Generic.Dictionary`2.get_Item(TKey key)
    at System.Collections.ObjectModel.KeyedCollection`2.get_Item(TKey key)
    at Microsoft.Azure.ActiveDirectory.Connector.Connector.GetConnectorSpaceEntryChange(SyncObject syncObject)
    at System.Linq.Enumerable.WhereSelectListIterator`2.MoveNext()
    at System.Collections.Generic.List`1.InsertRange(Int32 index, IEnumerable`1 collection)
    at Microsoft.Azure.ActiveDirectory.Connector.Connector.GetImportEntriesCore()
    at Microsoft.Azure.ActiveDirectory.Connector.Connector.GetImportEntries(GetImportEntriesRunStep getImportEntriesRunStep).
    ```

## Resolution

To resolve this problem, select the missing object type (**device**). To do this, follow these steps:

1. Open Management Agent for the Microsoft Entra directory in the Forefront Identity Manager (FIM) Sync console.
2. Click **Connectors**, and then click **Microsoft Entra ID**.
3. In the **Actions** pane, click **Properties**.

    > [!NOTE]
    > The Properties window opens.

4. Under **Connector Design**, click **Select Object Types**.
5. In the **Select Object Types** pane, locate and then select the **device**  check box.
6. Click **OK** three times.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
