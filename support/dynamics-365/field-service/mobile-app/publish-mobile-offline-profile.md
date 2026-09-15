---
title: Mobile Offline Profile Publishing and Related-Table Errors
description: Resolve mobile offline profile publishing and related-table errors in Dynamics 365 Field Service by reviewing relationships, filters, and offline data sync.
ms.reviewer: jobaker, v-wendysmith, v-shaywood, puneetsingh
ms.date: 09/11/2026
ms.custom: sap:Mobile application\Offline data sync - Other
ai-usage: ai-assisted
---
# Resolve mobile offline profile and related-table errors

## Summary

This article helps you resolve publishing and related-table errors for a [mobile offline profile](/dynamics365/field-service/mobile/set-up-offline-profile) in the Microsoft Dynamics 365 Field Service mobile app. Review profile relationships and filters when publishing or offline data synchronization fails.

## Symptoms

You might receive one of the following error messages when you publish a mobile offline profile or synchronize offline data.

> The profile \<OfflineProfileName> could not be published because one or more tables exceed the allowed number of relationships of 10. Please reduce the number of relationships for the following table(s): \<EntityLogicalName>.

> The profile \<OfflineProfileName> could not be published because it is configured to download related records only for table: \<EntityLogicalName>, but no relationships are specified. Please review the filter selection of "download related records only" for table \<EntityLogicalName> and select at least one relationship or change the filter type for the table \<EntityLogicalName>.

> The view has related entities that aren't available offline.

The Power Apps mobile offline platform publishes and validates the profile. The Field Service native client doesn't evaluate profile filters or related-table availability.

## Solution

Use the resolution that applies to the reported error:

- Count the number of linked entities and ensure the number of relationships is 10 or less. One way to do this count is to view an entity's item associations and custom filters. Then, for any linked entities found, look through their item associations and custom filters to count the total number of linked entities. Another way is to query the item associations by using `<OrganizationUrl>/api/data/v9.1/mobileofflineprofileitemassociations`. Replace `<OrganizationUrl>` with your organization's URL. Learn more in [FetchXML editor for offline profiles (preview)](/power-apps/mobile/fetchxml-editor).

- When the system reports a circular relationship, remove the relationship between the two reported entities from the parent entity. For example, if there's a circular relationship between *Account > Notes > Account*, and you want to download all notes related to an account record, remove the relationship to the *Notes* entity from the *Account* entity.

- If the system reports issues only when downloading related rows, make sure that the entity has at least one relationship to another entity configured. Choose an item association for that entity by selecting the proper entity in the **Relationships** dropdown menu.

- If a view or filter references a related table that isn't available offline, review each table and filter in the profile. Then, take one of the following actions:

  - Add the related table and required relationship to the offline profile.
  - Change the filter to use columns from the primary table only.
  - Remove the filter if it isn't required.

Save and publish the profile after you update it. Then, synchronize the app again.

This error doesn't establish that an offline filter caused a blank native screen. If the schedule displays **No bookings** or an error after the profile synchronizes, see [Troubleshoot common issues in the Dynamics 365 Field Service mobile app](mobile-app-common-issues.md).
