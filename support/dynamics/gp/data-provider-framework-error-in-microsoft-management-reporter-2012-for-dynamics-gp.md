---
title: Data provider framework error in Microsoft Management Reporter 2012 for Dynamics GP
description: Describes an error message in Management Reporter 2012 for Dynamics GP. Provides a resolution.
ms.reviewer: theley, kellybj, kevogt
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Data provider framework error in Microsoft Management Reporter 2012 for Microsoft Dynamics GP

This article provides a resolution for **The operation could not be completed due to a problem in the data provider framework** error that may occur in Microsoft Management Reporter 2012 for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2776705

## Symptoms

When you open a row definition or a column definition in Management Reporter Report Designer for Microsoft Dynamics GP, you receive the following error message:

> The operation could not be completed due to a problem in the data provider framework

Additionally, one of the following events is logged in Event Viewer:

> Microsoft.Dynamics.Performance.DataProvider.Core.RequestException: The source system request did not complete successfully. ---> System.ArgumentException: An item with the same key has already been added.  
 at System.ThrowHelper.ThrowArgumentException(ExceptionResource resource)  
 at System.Collections.Generic.Dictionary\`2.Insert(TKey key, TValue value, Boolean add)  
 at System.Collections.ObjectModel.KeyedCollection\`2.AddKey(TKey key, TItem item)  
 at System.Collections.ObjectModel.KeyedCollection\`2.InsertItem(Int32 index, TItem item)  
 at Microsoft.Dynamics.Performance.DataProvider.Collections.LockableKeyedCollection\`2.InsertItem(Int32 index, TItem item)  
 at System.Collections.ObjectModel.Collection\`1.Add(T item)  
 at Microsoft.Dynamics.Performance.DataProvider.GeneralLedger.GP.Data.AttributeElementCollection.CreateAttributeElementCollection(ChartElementCollection elementCollection, SourceSystemRepository repository)  
 at Microsoft.Dynamics.Performance.DataProvider.GeneralLedger.GP.GLProvider.EnsureAttributeElementsPopulated()  
 at Microsoft.Dynamics.Performance.DataProvider.GeneralLedger.GP.GLProvider.GetAttributes(GLAttributeRequest request)
>
> Microsoft.Dynamics.Performance.DataProvider.Core.RequestException: The source system request did not complete successfully. ---> System.ArgumentException: An item with the same key has already been added.  
at System.Collections.Generic.Dictionary\`2.Insert(TKey key, TValue value, Boolean add)  
at System.Collections.ObjectModel.KeyedCollection\`2.InsertItem(Int32 index, TItem item)  
at Microsoft.Dynamics.Performance.DataProvider.GeneralLedger.DataMart.Data.AttributeAccess.RetrieveResultFromCache(IList\`1 cacheItem, GLRequest request)  
at Microsoft.Dynamics.Performance.DataProvider.GeneralLedger.DataMart.GLProvider.GetAttributes(GLAttributeRequest request)  
at Microsoft.Dynamics.Performance.DataProvider.GeneralLedger.GLSystemProvider.HandleRequest(GLAttributeRequest request)  
at Microsoft.Dynamics.Performance.DataProvider.Core.SourceSystemRequest.Handle[TRequest](SourceSystemProvider provider, TRequest request)  
at Microsoft.Dynamics.Performance.DataProvider.Core.SourceSystemProvider.SubmitRequest(SourceSystemRequest request)  
--- End of inner exception stack trace ---  
at Microsoft.Dynamics.Performance.DataProvider.Core.SourceSystemProvider.SubmitRequest(SourceSystemRequest request)  
at Microsoft.Dynamics.Performance.DataProvider.Core.SourceSystemProvider.HandleSubmit(SourceSystemRequest request)  
at Microsoft.Dynamics.Performance.DataProvider.Core.SourceSystemConnection.Submit(SourceSystemRequest request)  
at Microsoft.Dynamics.Performance.Reporting.DataProvider.Server.DirectLinkService.SubmitRequestDirect(SourceSystemConnection connection, GLRequest request)  
at Microsoft.Dynamics.Performance.Reporting.DataProvider.Server.DirectLinkService.<>c__DisplayClass26.\<SubmitRequestInternal>b__25(SourceSystemConnection glConnection)  
at Microsoft.Dynamics.Performance.Reporting.DataProvider.Server.DirectLinkConnectionManager.UsingConnection[TResult](DataServiceConnection connection, Func\`2 executor)  
at Microsoft.Dynamics.Performance.Reporting.DataProvider.Server.DirectLinkService.SubmitRequestErrorHandler[T](Func\`1 requestSubmission)  
Component: Microsoft.Dynamics.Performance.Reporting.DataProvider.Server.DirectLinkService

## Cause

This problem occurs if one or more fields of the following types are blank or contain a duplicate or reserved name:

- A user-defined field in the General Ledger Setup window (**Tools** > **Setup** > **Financial** > **General Ledger**).
- A **Trx Dimension** field in the Transaction Dimension Maintenance window (**Cards** > **Financial** > **Analytical Accounting** > **Transaction Dimension**) that has a **Date Type** of **Alphanumeric**, **Numeric**, or **Date**.
- The following reserved attribute names:
  - Account Type
  - Account Category
  - Audit Trail Code
  - Batch ID
  - Currency ID
  - Customer ID
  - Distribution Reference
  - Employee
  - Exchange Rate
  - Item ID
  - Journal Entry
  - Originating Audit Trail Code
  - Originating Document Number
  - Originating Master Record ID
  - Originating Master Record Name
  - Originating Transaction Type
  - Reference
  - Reporting Ledger
  - Site ID
  - Source Document
  - Transaction Date
  - Vendor ID
  - Voided
  - Series

For example, the following conditions cause the error that is mentioned in the Symptoms section:

- A user-defined field is named *Reference*.
- A user-defined field is named *Customer* and an AA Dimension (Boolean) name of *Customer* already exists.

## Resolution

To resolve this issue, enter a name that is unique across the three groups that are listed in the Cause section, change the duplicate name to a unique name, or change the reserved name to a non-reserved name.
