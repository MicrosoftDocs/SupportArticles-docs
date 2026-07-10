---
title: Fix Segment Member Count Issues in Customer Insights - Journeys
description: Troubleshoot segment member counts in Customer Insights - Journeys when segments show too few or too many members. Learn how to resolve discrepancies.
ms.date: 07/06/2026
ms.reviewer: alfergus, v-shaywood
ms.custom: sap:Real-time journeys segments
search.audienceType: 
  - admin
  - customizer
  - enduser
---

# Segments show incorrect member count

## Summary

This article helps you troubleshoot why a segment in Dynamics 365 Customer Insights - Journeys doesn't return the expected member count, showing either fewer or more members than you expect. For segments that show too few members, it covers contradictory conditions, isolating the rule that filters members out, business units, empty tables, consent, and data synchronization timing. For segments that show too many members, it covers isolating the rule that adds members, comparing results with Advanced Find, and checking for virtual fields. It also explains when to open a support ticket.

## Symptoms

A segment runs and refreshes, but it shows a discrepancy from the expected counts. The segment shows a higher or lower number of contact IDs than you expect.

## Segments show no members or fewer members than expected

To find out why a segment has fewer members than expected, use the steps in the following sections.

### Check the basic logic for contradictory conditions or rules

Contradictory `AND` conditions or rules on the same attribute always generate empty segments. For example, `FirstName = Joe AND FirstName = Frank`.

A segment can also combine two rules with a set operation. Each operation works on the `ContactId` values that the two rules return:

- `UNION` keeps contacts that are in either rule.
- `INTERSECT` keeps only contacts that are in both rules.
- `EXCEPT` keeps contacts that are in the first rule but not the second.

To find out why a contact is missing, check which rules return that contact's `ContactId`, and then confirm that the set operation between the rules produces the result you expect.

### Isolate the rule that filters out members

When you work with complex segments that have multiple conditions or rules, reduce the complexity and isolate the condition or rule that's responsible for the issue. This approach helps you identify the exact case or condition where the problem occurs.

- Isolate the rule by using one of the following approaches:
  - Start from the complete segment and remove conditions and rules one by one. Run the segment after each change until it returns members.
  - Build a new segment from scratch, and add conditions and rules one by one from the segment that yields no members. Run the segment after each step until no members are returned.
- After you identify the rule that filters out the members, take a sample expected contact and check whether it matches all conditions added to the segment.
- Remove exclusion segments to check whether the contact shows up before you add them. Check whether the exclusion segment has a `ContactId` that might remove it from the primary segment.

### Check business units

Check whether [business unit](/dynamics365/customer-insights/journeys/business-units) scoping is turned on for the environment. If it's turned on, real-time journeys return only members from your business unit.

In real-time journeys, business units are turned on by default, and the setting applies to all segments at once. Either all segments have business units turned on, or none of them do.

### Check for empty tables

Check that the tables used in the segment aren't empty. Every entity used in a segment requires a minimum of one record to trigger synchronization for that segment. If an entity is empty, the segment doesn't show the expected members.

### Check consent

Check whether consent is turned on. Consent filters the segments that are shown based on the chosen purpose and topic.

### Allow time for data synchronization

Publishing or refreshing a segment might be delayed if the underlying data isn't fully synchronized. To avoid problems:

- Wait a short period after you publish or refresh a segment.
- If members aren't added immediately, let the next scheduled refresh run so the data can finish synchronizing.

This delay is especially important in certain scenarios, such as:

- Tables that are updated through data import (for example, contacts or leads tables).
- Newly updated consent records.
- Tables that were recently turned on for segmentation or change tracking.
- Recent uploads of static segment CSV files.

## Segments show more members than expected

To find out why a segment has more members than expected, use the steps in the following sections.

### Isolate the rule that adds members

- Start from the complete segment and remove conditions and rules one by one. Run the segment after each change until it adds the expected member.
- Check whether your segment has any except clauses or exclusion segments. Check whether the expected contacts are part of these clauses and aren't filtered out.
- After you identify the rule that causes the member to get added, check whether the data correlates to the output. For example, if the rule says `firstname = 'Frank'`, the segment should add only contacts where `firstname = 'Frank'`.

### Check for discrepancies with Advanced Find members

If you see a discrepancy with **Advanced Find** members, check the following items:

- Check whether the relationships used are in the same order. An `account` entity that's used in a segment is a relationship between `contact` and `account`. It's different from applying filters directly on the `account` entity in **Advanced Find**.
- Real-time journeys let you create segments on `contact` and `lead` entities only. Check that these entities are the primary entities used in **Advanced Find**.

### Check that virtual fields aren't used

The segmentation feature doesn't support virtual fields that you create in Dataverse tables.

## When to open a support ticket

If all the previous checks are successful and the expected contacts still don't match, open a support ticket. When you open a support ticket, always include the following information:

- OrgId
- Segment ID for real-time journeys segments
- FetchXML for the Advanced Find query used as the discrepancy source
- Sample `ContactId` values that should or shouldn't show up in the segment
- Attributes and the entities where the `ContactId` is causing the potential discrepancy

## Related content

- [Segmentation overview](/dynamics365/customer-insights/journeys/real-time-marketing-segments)
- [Improve targeting using interaction data in segments](/dynamics365/customer-insights/journeys/real-time-marketing-redesigned-segment-builder)
