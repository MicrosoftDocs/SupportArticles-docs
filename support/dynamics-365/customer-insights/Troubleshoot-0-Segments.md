---
title: Troubleshoot Segments returning "0 members"
description: Learn how to identify the root cause when segment returns 0 members in Dynamics 365 Customer Insights.
author: ashwini-puranik
ms.author: aspuranik
ms.reviewer: mhart
ms.date: 03/08/2023
---

# Segments returning "0 members"

This article provides guidance that will help to identify the root cause of Segments returning "0 members".

## Prerequisites

- Segment refresh Status is 'Successful'.
- Last refresh date is within 28 days.

## Symptoms

You may find the following issues:

- Segment runs/refreshes successfully but does not include any members/profiles ("0 members").

## Root Cause Identification Steps

Take the following steps to investigate the issue:

1. Validate basic logic for contradictory rules:
Having contradictory ANDed conditions or rules on same attribute will always generate a 0-member Segment (e.g. "MyAttribute = 123 AND MyAttribute = 456").
To remove this possibility, analyze all the rules and conditions that would reveal such a broken logic. Of course it could be more complex where the contradiction is actually across several attributes and this would need more business knowledge of what can or cannot exists in the dataset(s) (e.g. "MyAttributeStatus = 1 AND MyAttributeStatusDescription = Inactive" when this is by nature impossible for this dataset where both attributes are functionally linked and "Status = 1" means "Active")

2. Missing data for the attribute/s used in Segment Rule or Condition:
If the value of the attribute used in Segment rule or condition is missing for any reason, the segment is likely to return 0 members. This can be investigated further by checking if the 'expected' value actually exists in the entity:

    - Check the steps described [here](https://learn.microsoft.com/en-us/dynamics365/customer-insights/entities#explore-a-specific-entitys-data) to explore entity data/attribute values. 
If available, closely observe the 'Summary' of attributes you are interested in and ensure they are not in 'Missing' or 'Error' state. 
Note: 'Summary' view is not available for all system generated entities and is optional for entities ingested using 'Attach Azure Data Lake' ingestion pattern.

    - Check if the source records are not rejected for being identified as ['corrupt'](https://learn.microsoft.com/en-us/dynamics365/customer-insights/data-sources#corrupt-data-sources).
    
    - To check if a specific value exists in the entity for a given attribute is to create a very 'Measure' on that entity, filtered on said attribute value. Use the "Count" to see how many records contains the value of your filtering condition, or a "First" on the PK or FK to find a reference record.

    - If the above steps were not useful to locate/identify an attribute in the entity to further investigate, these approaches could be used to further explore the attribute values in the data:
    
        - D365 Customer Insights "Entity" screen: The "data" tab can previews 1000 records, and the "Download" to .csv option would only contain 100,000 records. 
    Note: There might be a few cases where for security and privacy reasons Customer has asked that the "Download" button is disabled and you would not even have access to this 100,000 export approach, or where your dataset is bigger.
    
        - Power BI connector: Use Power BI connector to explore the Customer Insights entity from Power BI. [Link](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-power-bi)
Note: All entities, especially source entities from a "CDM-attach" data source, won't be available with this connector, and this not going to scale too good past 1 million records, so would only recommend for investigations on smaller entities.

        - Export to Azure: Export the entity to either [Blob](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-azure-blob-storage)  or [ADLS gen2](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-azure-data-lake-storage-gen2)  or [Azure Synapse](https://learn.microsoft.com/en-us/dynamics365/customer-insights/export-azure-synapse-analytics), from where you can proceed to further investigations thanks to Synapse, Power BI or any other data exploration tool.

        - Power Query: If the data you want to check is from a PowerQuery source entity, you can also spin a dedicated data source, or extra reference query in your existing Data source that would apply the same filtering condition (e.g. "MyAttribute = 123") and see if once refreshed the new entity corresponding to this new query is containing any data.
        
3. "Relationships" Issues:
If the relationship between the entity used in segmentation and Customer entity doesn't work, the segment will continue to return "0 members".

    - Choose correct Relationship Path: Check if the intended [relationship path](https://learn.microsoft.com/en-us/dynamics365/customer-insights/relationships#relationship-paths) is used as several paths could be technically valid between your source entity (with the condition) and the Customer entity. If there are several hops, inspect each relationship and validate if they are setup correctly and on expected 'attributes'.
    
    - Case sentivivity: For each relationship in the path, the attributes evaluation is case sensitive. Joining attribute 'MembershipType' from 'LoyaltyMaster' entity  from  so joining on an attribute AA from an entity EA to an attribute AB from an entity EB with respective values "ABC" and "abc" would yield no successful join and hence no record being identified in the Segment.

Also verify the data types of the attributes, joining a "GUID" to a "String" through a Relationship might work for Measures and Segments, but it didn't last time tested for Unification ("Match" step) ... so in any case it's always a good practice to have aligned data types on things intended to be linked, matched, related ...Etc.

The ultimate reason why a Relationship might provide no resulting record identified between a source entity and the Customer entity might relate to AlternateKeys.
https://learn.microsoft.com/en-us/dynamics365/customer-insights/review-unification#verify-output-entities-from-data-unification 
Indeed if the source entity is related to the Customer entity through a Relationship on a Profile entity contributing to Unification by its Key, and your Profile entity is deduplicated as part of the Unification, then the behavior of matching on all (i.e. Alternate) Keys or only on the Key of the winner record is dictated by a Feature Flag : "Segmentation.ShouldExplodeAlternateKey" which is an instance-wide setting.
There is a dedicated TSG for this here: https://powerbi.visualstudio.com/Customer360/_wiki/wikis/Customer360.wiki/20820/TSG-for-missing-records-from-segments-or-measures

In the case of Advanced SQL Segments, Relationships defined in UI don't matter, only the Join conditions explicitly defined in the SQL statement matter. Exploding AlternateKeys for consideration can be achieved with a specific syntax on a Segment-per-Segment basis (irrelative of the aforementioned instance-wide Feature Flag that is only applicable to Segment created through the Segment Builder UI).
<< Sample SQL syntax to be provided later after prototyping >>
