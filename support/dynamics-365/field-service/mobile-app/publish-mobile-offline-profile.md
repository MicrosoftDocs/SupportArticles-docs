---
title: Troubleshoot issues with publishing a mobile offline profile
description: Resolves common issues with publishing a mobile offline profile in the Dynamics 365 Field Service mobile app.
ms.author: jobaker
author: JonBaker007
ms.reviewer: mhart
ms.date: 01/31/2025
ms.custom: sap:Mobile application\Offline data sync - Other
---
# Troubleshoot issues with publishing a mobile offline profile

This article helps you solve issues with publishing a [mobile offline profile](/dynamics365/field-service/mobile-power-app-system-offline) in the Microsoft Dynamics 365 Field Service mobile app.

## Symptoms

You might receive one of the following error messages when trying to publish a mobile offline profile.

> The profile \<name-of-offline-profile> could not be published because one or more tables exceed the allowed number of relationships of 10. Please reduce the number of relationships for the following table(s): \<entity-logical-name>.

> The profile \<name-of-offline-profile> could not be published because it is configured to download related records only for table: \<entity-logical-name>, but no relationships are specified. Please review the filter selection of "download related records only" for table \<entity-logical-name> and select at least one relationship or change the filter type for the table \<entity-logical-name>.

## Resolution

Try the following resolutions to mitigate errors while publishing an offline profile:

- Count the number of linked entities and ensure the number of relationships is 10 or less. One way to do this is to view an entity's item associations and custom filters. Then, for any linked entities found, look through their item associations and custom filters to count the total number of the linked entities. Another way is to query the item associations by using `\<orgurl\>/api/data/v9.1/mobileofflineprofileitemassociations`.

- When the system reports a circular relationship, remove the relationship between the two reported entities from the parent entity. For example, if there's a circular relationship between *Account > Notes > Account*, and you want to download all notes related to an account record, remove the relationship to the *Notes* entity from the *Account* entity.

- If the system reports issues only when downloading related rows, make sure that the entity has at least one relationship to another entity configured. Choose an item association for that entity by selecting the proper entity in the **Relationships** dropdown menu.
