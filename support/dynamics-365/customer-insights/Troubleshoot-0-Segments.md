---
title: Troubleshoot Segments returning "0 members"
description: Learn how to identify the root cause when segment returns 0 members in Dynamics 365 Customer Insights.
author: ashwini-puranik
ms.author: aspuranik
ms.reviewer: mhart
ms.date: 03/08/2023
---

# Segments returning "0 members"

This article provides functional guidance to identify the root cause when a Segment returns "0 members". This guide must be used only for functional troubleshooting when you expect the segment to return members but it does not. This is often true during new segment creation or when scheduled segments that used to include members in the past are returning "0 members" now.

## Prerequisites

- Segment refresh Status is 'Successful'.
- Last refresh date is within 1 day.

## Symptoms

You may find the following issues:

- Segment runs/refreshes successfully but does not include any members/profiles ("0 members").

## Root Cause Identification Steps

Take the following steps to investigate the issue:

1. **Validate basic logic for contradictory conditions/rules**:<br>
Having contradictory ANDed conditions or rules on same attribute will always generate a 0-member Segment (e.g. "MyAttribute = 123 AND MyAttribute = 456").
To remove this possibility, analyze all the rules and conditions that would reveal such a broken logic. Sometimes it could be more complex where the contradiction is actually across several attributes and this would need more business knowledge of what can or cannot exists in the dataset(s) (e.g. "MyAttributeStatus = 1 AND MyAttributeStatusDescription = Inactive" when this is by nature impossible for this dataset where both attributes are functionally linked and "Status = 1" means "Active").

2. **Break down complexity**:<br>
When working with complex segments with multiple conditions and/or rules, the best way to narrow down the Condition/Rule responsible in 'breaking' the segment is either:
    - Start building a Segment from scratch adding Conditions and Rules one by one and executing segment after each step, until no members are returned anymore.
    - Start from the complete Segment and remove Conditions and Rules until you get some members to identify the limiting factor.

3. **Missing data for the attribute/s used in Segment Rule or Condition**:<br>
If the value of the attribute used in Segment rule or condition is missing for any reason, the segment is likely to return 0 members. This can be investigated further by checking if the 'expected' value actually exists in the entity:

    - Check the steps described [here](https://learn.microsoft.com/en-us/dynamics365/customer-insights/entities#explore-a-specific-entitys-data) to explore entity data/attribute values.<br>
If available, closely observe the 'Summary' of attributes you are interested in and ensure they are not in 'Missing' or 'Error' state. 
Note: 'Summary' view is not available for all system generated entities and is optional for entities ingested using 'Attach Azure Data Lake' ingestion pattern.

    - Check if the source records are not rejected for being identified as ['corrupt'](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data-sources#corrupt-data-sources).
    
    - A way to check if a specific value exists in the entity for a given attribute is to create a 'Measure' on that entity, filtered on said attribute value. Use the "Count" to see how many records contain the value of the filtering condition, or a "First" on the PK or FK to find a reference record.

    - If the above steps were not useful to locate/identify an attribute in the entity, the below approaches could be used to further explore the attribute values in the data:
    
        - *D365 Customer Insights "Entity" screen*: The "data" tab can previews 1000 records, and the "Download" to .csv option would only contain 100,000 records.<br> 
    Note: There might be a few cases where for security and privacy reasons Customer has asked that the "Download" button is disabled and you would not even have access to this 100,000 export approach, or where your dataset is bigger.
    
        - *Power BI connector*: Use [Power BI connector](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-power-bi) to explore the Customer Insights entity from Power BI.<br>
Note: All entities, especially source entities from a "CDM-attach"/"Attach Azure Data Lake Storage" data source, won't be available with this connector, and this not going to scale too good past 1 million records, so would only recommend for investigations on smaller entities.

        - *Export to Azure*: Export the entity to either [Blob](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-azure-blob-storage)  or [ADLS gen2](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-azure-data-lake-storage-gen2)  or [Azure Synapse](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-azure-synapse-analytics), which can help with further investigations using Synapse, Power BI or any other data exploration tool.

        - *Power Query*: If the data you want to check is from a PowerQuery source entity, spin a dedicated data source, or extra reference query in existing Data Source that would apply the same filtering condition (e.g. "MyAttribute = 123") and check if once refreshed the new entity corresponding to this new query is containing any data.
        
4. **"Relationships" Issues**:<br>
If the relationship between the entity used in segmentation and Customer entity doesn't work, the segment will continue to return "0 members".

    - *Choose correct Relationship Path*: Check if the intended [relationship path](https://learn.microsoft.com/en-us/dynamics365/customer-insights/relationships#relationship-paths) is used as several paths could be technically valid between your source entity (with filter condition on attribute) and the Customer entity. If there are several hops, inspect each relationship and validate if they are setup correctly and on expected 'attributes'.
    
    - *Case sensitivity*: For each relationship in the path, the attribute value evaluation is case sensitive. Relationship between 'MembershipMaster' and 'CustomerMembership' is on attribute 'MembershipType' available in both entities, however, if the attribute value is 'GOLD' in 'MembershipMaster' and 'gold' in 'CustomerMembership', it will not yield successful join and hence no record being identified in the Segment. Note: This is true for GUIDs which is easy to miss.

    - *Data Type alignment*: Verify the data types of the attributes, joining a "GUID" to a "String" through a Relationship, which might work for Measures and Segments but it's always a good practice to have aligned data types on things intended to be linked, matched, related etc.

    - *No Relation to "Winner" Record*: During the deduplication process, a “winner” record is identified by the unification process. In the Customer entity, the Primary Key of the “winner” record is capture in the Primary Key column while the Primary Key values of “non-winner” record/s are captured as a semi colon separated list in the Alternate Key column along with the Primary Key value as described [here](https://learn.microsoft.com/en-us/dynamics365/customer-insights/review-unification#verify-output-entities-from-data-unification). For all the subsequent measures and segments created using this entity in the “Relationship path”, the calculations will by default happen only with the “winner” record’s Primary Key. By default, all the segment conditions on attributes from entities that are prior in the relationship path to entities contributing to Profile Unification (or directly the entity contributing to Profile Unification) will be evaluated only for those source records that have a relationship to the “winner” record of Profile Unification.<br>
    E.g: Customer had 'MembershipType' of 'Slvr' (Silver) in the past and is now upgraded to 'Gld' (Gold) but both records exist in the 'CustomerMembership' entity. ContactId is the Primary Key (PK) on this table and this table participates in Unification. During Deduplication process, the PK of record with MembershipType 'Slvr' was deemed as 'winner' and it's PK was included in the Primary Key column of Customer entity while that of the record with 'Gld' was added to the Alternate Key column. The 'MembershipMaster' contains the abbrevations for 'Slvr' and 'Gld' and a segment is created from this entity with condition where 'MembershipTypeName' = 'Gold'. In this scenario, the customer will not be included in the Segment since the 'winner' PK has 'slvr' (Silver) MembershipType.
    Relation: MembershipType (MembershipType)--> CustomerMembership (MembershipType):(ContactId)--> Customer (ContactId)

    - *Advanced SQL*: In the case of Advanced SQL Segments, the Join conditions explicitly defined in the SQL statement are considered while the relationships defined within D365 Customer Insights UI are disregarded. 
