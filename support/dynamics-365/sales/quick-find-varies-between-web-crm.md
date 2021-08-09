---
title: Quick find varies between the web and CRM
description: This article provides a resolution for the problem that occurs when you perform a Quick Find Search in either the Microsoft Dynamics CRM 2011 web client or the Microsoft Dynamics CRM 2011 for Outlook client.
ms.reviewer: debrau
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Microsoft Dynamics CRM 2011 quick find varies between the web and CRM for Outlook client

This article helps you resolve the problem that occurs when you perform a Quick Find Search in either the Microsoft Dynamics CRM 2011 web client or the Microsoft Dynamics CRM 2011 for Outlook client.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011, Microsoft CRM client for Microsoft Office Outlook  
_Original KB number:_ &nbsp; 2669792

## Symptoms

When performing a Quick Find Search in either the Microsoft Dynamics CRM 2011 web client or the Microsoft Dynamics CRM 2011 for Outlook client, you may get different results.

For instance, open the Account entity and create three accounts with the following Account Names:

- test sample 1
- sample 1
- One sample

In this scenario, if a user would search the CRM web client quick find for Account using the search string `sample`, the query would search with an appended suffix wild card similar to searching for `sample*`, and would result in the return of a single record.

However, if the user searched in the Outlook Client using quick find for Accounts using the search string `sample`, the query would search with an appended prefix *and* suffix wild card, similar to searching for `*sample*`, and would result in the return of all three records.

## Cause

In Microsoft Dynamics CRM 4.0, the search functionality produced the same results in the Outlook Client and Web Client because the search was handled by the CRM server. However, since the Microsoft Dynamics CRM 2011 Outlook client offers richer integration with Outlook, the client is able to leverage the built-in search functionality of Outlook, which allows for the expanded search coverage.

## Resolution

The web client is capable of similar search functionality using substring, prefix, and suffix wild cards, along with other conditions using Advanced Find.

To emulate the search behavior of the Outlook client from within the web client, enter a `*` character at the start of the search string.

Advanced Find can also be used to leverage additional string conditions such as Contains, Equals, Begins With, Ends With, Does Not Contain Data, among others, which can be used for search strings.

## More information

Dynamics CRM 2011 Update Rollup 12 and beyond change this functionality so that the quick find in the CRM client for Outlook and the CRM web client search using similar logic. Update Rollup 12 and beyond will result in the CRM client for Outlook to use the defined quick find view when performing a quick find search rather than searching within the results of the current view.
