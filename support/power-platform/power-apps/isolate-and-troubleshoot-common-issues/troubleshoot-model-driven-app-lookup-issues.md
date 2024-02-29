---
title: Troubleshoot Lookup issues in model-driven apps
description: Helps troubleshoot Simple Lookup control issues in Power Apps model-driven apps.
author: hwhong
ms.date: 02/29/2024
ms.author: hwhong
ms.topic: Helps troubleshoot Simple Lookup control issues in Power Apps model-driven apps.
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - hwhong
---

# Troubleshoot Lookup issues in model-driven apps

The Lookup control combines the Lookup field and its relationships, the assigned view, the entity's Quick Find view, search string, and any applied custom script to build a fetchXML for retrieving search results.

Issues with this operation usually fall into one of these categories:

- Search results are incorrect.
- Views are incorrect.
- Result fields are incorrect.

## Search results are incorrect

If the Lookup's search results are missing items or include unexpected items, inspect the fetchXML of the outgoing network request that the control makes.

If the fetchXML is incorrect, then there is a problem with:

  1. The Quick Find view or the view being searched is misconfigured:
      - Missing search fields.
      - Missing the primary field.
      - Using a filter that is blocking results.
  2. A client script is modifying the control's behavior with API such as [`addPreSearch`](/power-apps/developer/model-driven-apps/clientapi/reference/controls/addpresearch) or [`addCustomFilter`](/power-apps/developer/model-driven-apps/clientapi/reference/controls/addcustomfilter).

If the fetchXML is correct but the data returned is incorrect then the issue is on the server, such as a misconfigured relationship. Another possibility is that the user doesn't have correct permissions for some entities, which may not be apparent in the network response other than with an omission of results.

## Views are incorrect

If an entity or view is missing from the Lookup views or results, or the default view incorrect, then:

- Verify that the entity is enabled for the app.
- Verify that the user has permissions and roles required to interact with the entity and related entities.

If the [`addCustomView`](/power-apps/developer/model-driven-apps/clientapi/reference/controls/addcustomview), API is being applied then:

- Verify that the `viewId` isn't already used.

## Result fields are incorrect

The Lookup control's search results are presented in the order that they're listed for that entity's Lookup view, with blank fields being replaced with the next non-blank field. A multi-entity Lookup can have results with different orders of fields if the entities' Lookup views have different field combinations.

## See also

[General Power Apps troubleshooting strategies](isolate-common-issues.md)
[Isolate issues in model-driven apps - Power Apps](isolate-model-app-issues.md)
<!-- TODO fix link [Records aren't filtered in lookup for particular entity](/power-platform/power-apps/create-and-use-apps/lookup-does-not-filter-entity-records) -->
[Work with Quick Find’s search item limit (Microsoft Dataverse)](/power-apps/developer/data-platform/quick-find-limit)
