---
title: Quick find in Outlook Client displays unexpected results
description: This article provides two resolutions for the problem where the Quick find in Outlook Client displays unexpected results.
ms.reviewer: bhshastr, clintwa
ms.topic: troubleshooting
ms.date: 
---
# When using the Microsoft Dynamics CRM client for Outlook 2011, the Quick find in Outlook Client displays unexpected results

This article helps you resolve the problem where the Quick find in Outlook Client displays unexpected results.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2602016

## Symptoms

Consider this scenario:

There is a field (attribute) which has display name fully or partially matching with real life name of person. You have added records for this entity with names fully or partially matching with above field display name. When you search in CRM for Outlook using the Quick Find by keywords that fully or partially matches with field display names, search results show all records.

Example:

- You have added attributes with following display name on Contact entity:
  - LAN
  - IS
  - IL
  - SO
- You add contacts by name: Alan Jackson
  - Chris Perry
  - Gail Erickson
- Quick find view includes Firstname Lastname in filtering criteria.
- When you search in Outlook, quick find by keyword Alan, Chris, Jackson, or Gail results will show all records instead of records that have the key words included. However, if you search by Al, Chi or Erick search shows accurate results.

## Cause

This issue happens when field names exist within the search terms

## Resolution

- Method 1:

    Use search syntax like Outlook

    Instead of searching for simply Erickson, or Erick, use [Last Name]: Erick* or [Last Name]: Erickson

    Instead of searching for simply Alan, use [First Name]: Alan

    You can even use syntax like this example to make: [Last Name]: Erick* OR [First Name]: Gail and you would get contacts with last name that contains Erick and contacts with first name that contains Gail.

- Method 2:

  Change display name on the field to be unique that is not likely to be part of search terms

## More information

Dynamics CRM 2011 Update Rollup 12 and beyond change this functionality so that the quick find in the CRM client for Outlook and the CRM web client search using similar logic. Update Rollup 12 and beyond will result in the CRM client for Outlook to use the defined quick find view when performing a quick find search rather than searching within the results of the current view.
