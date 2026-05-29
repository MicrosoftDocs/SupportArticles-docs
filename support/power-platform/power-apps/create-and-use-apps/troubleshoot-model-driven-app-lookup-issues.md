---
title: Troubleshoot Lookup control issues in model-driven apps
description: Helps troubleshoot Simple and Advanced Lookup control issues in Power Apps model-driven apps.
ms.date: 05/28/2026
ms.reviewer: hwhong, v-shaywood
ms.custom: sap:Running model-driven app controls\Lookup, advanced lookup
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - hwhong
---
# Troubleshoot Lookup control issues in model-driven apps

## Summary

This article explains how to troubleshoot lookup control issues in Power Apps model-driven apps.
The Simple and Advanced Lookup controls use the Lookup field, its relationships, the assigned view, the entity's Quick Find view, the search string, and any applied custom script to build a FetchXML for retrieving search results.

Issues with this operation usually fall into one of these categories:

- [Search results are incorrect.](#search-results-are-incorrect)
- [Views are incorrect.](#views-are-incorrect)
- [Result fields are incorrect.](#result-fields-are-incorrect)

## Search results are incorrect

If the Lookup control's search results are missing items or include unexpected items, inspect the [FetchXML](/power-apps/developer/data-platform/fetchxml/overview) of the [outgoing network request](/azure/azure-web-pubsub/howto-troubleshoot-network-trace) that the control makes.

- If the FetchXML is incorrect, the problem is that:

  - The Quick Find view or the view being searched is misconfigured:
    - Missing search fields.
    - Missing the primary field.
    - Using a filter that blocks results.

  - A client script modifies the control's behavior by using APIs such as [addPreSearch](/power-apps/developer/model-driven-apps/clientapi/reference/controls/addpresearch) or [addCustomFilter](/power-apps/developer/model-driven-apps/clientapi/reference/controls/addcustomfilter).

- If the FetchXML is correct, but the data returned is incorrect, the issue is on the server, such as a misconfigured relationship. Another possibility is that the user doesn't have correct permissions for some entities, which might not be apparent in the network response other than by an omission of results.

> [!TIP]
>
> Search results are listed in the order they're returned from the server. If results aren't in the expected order, then either
>
> - the FetchXML [order element](/power-apps/developer/data-platform/fetchxml/reference/order) has the wrong attribute values, or
> - the server is unable to sort the results, such as with [virtual entities](/dynamics365/customerengagement/on-premises/developer/virtual-entities/get-started-ve).

> [!NOTE]
>
> - Selecting the text area (the input box of the Lookup control) shows a list of the most recently used items, not a fresh search.
> - Selecting the magnifying glass triggers a search based on your input, showing results that match your search terms. You can configure the control to always perform a search when you select the text area, instead of showing recent items.

## Views are incorrect

- If an entity or view is missing from the Lookup control's views or results, or the default view is incorrect:

  - Verify that the entity is enabled for the app.
  - Verify that you have the permissions and roles required to interact with the entity and related entities.

- If the [addCustomView](/power-apps/developer/model-driven-apps/clientapi/reference/controls/addcustomview) API is being applied, verify that the `viewId` isn't already used.
- If the [lookupObjects](/power-apps/developer/model-driven-apps/clientapi/reference/xrm-utility/lookupobjects) or [setDefaultView](/power-apps/developer/model-driven-apps/clientapi/reference/controls/setdefaultview) API is being applied, verify that the `viewId` belongs to a view that's included in the current app.

## Result fields are incorrect

The Simple Lookup control presents the search result fields in the order that they're listed in the entity's Lookup view, with the following exceptions:

- Blank fields are replaced with the next nonblank field.
- Fields beginning with the search string are swapped with the second field.

> [!NOTE]
> A multi-entity Lookup control can have results with different orders of fields if the entities' Lookup views have different field combinations.

## See also

- [General Power Apps troubleshooting strategies](isolate-common-issues.md)
- [Isolate issues in model-driven apps - Power Apps](isolate-model-app-issues.md)
- [Records aren't filtered in lookup for particular entity](~/power-platform/power-apps/create-and-use-apps/lookup-does-not-filter-entity-records.md)
- [Work with Quick Find's search item limit (Microsoft Dataverse)](/power-apps/developer/data-platform/quick-find-limit)
