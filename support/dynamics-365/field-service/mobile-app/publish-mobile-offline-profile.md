---
title: Troubleshoot issues with publishing a mobile offline profile
description: Resolve common issues with publishing of the mobile offline profile for the Field Service mobile app.
ms.author: andreo
author: Andrea-Orimoto
ms.reviewer: mhart
ms.date: 11/20/2023
---

# Troubleshoot issues with publishing a mobile offline profile

This article helps you solve issues with publishing the [mobile offline profile](/dynamics365/field-service/mobile-power-app-system-offline).

## Symptoms

If the system shows error messages when you try to publish the mobile offline profile.

## Resolutions

Verify the following resolutions to mitigate errors while publishing an offline profile:

- Count the amount of linked entities and make sure the number of relationships is 10 or less. One way to do this is look at the item associations and custom filter for an entity. Then for any found linked entities, look through their item associations and custom filter to count the total amount of linked entities. Another way is to query for item associations via \<orgurl\>/api/data/v9.1/mobileofflineprofileitemassociations.

- When the system reports a circular relationship, remove the relationship between the two reported entities from the parent entity. For example, if there is a circular relationship between *Account > Notes > Account*, and you want to download all notes related to an account record, remove the relationship to the *Notes* entity from the *Account* entity.

- If the system reports issues when downloading related rows only, make sure that the entity has at least one relationship to another entity configured. Choose an item association for that entity by selecting the proper entity in the **Relationships** dropdown menu.
