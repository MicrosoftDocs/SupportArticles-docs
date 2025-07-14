---
title: Updated results aren't returned when you try to search the new or changed properties of the people categories in SharePoint Online
description: Describes an issue in which updated results aren't returned when you try to search the new or changed properties of the people categories in SharePoint Online.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Search\Schema
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Updated results aren't returned when you try to search the new or changed properties of the people categories

## Problem

When you try to search the new or changed properties of the people categories in the following scenarios in Microsoft SharePoint Online, the search results don't contain updated values.

### Scenario 1

In the SharePoint admin center, you click **search**, click **Manage Search Schema**, and then click **Crawled Properties**. Then, you search for the **People:LastName** property and then add a mapping to the managed property that's set to **Searchable**.

### Scenario 2

You change the **Mappings to crawled properties** search schema for a people property on a site collection.

### Scenario 3

In the SharePoint admin center, you click **search**, click **Manage Search Schema**, and then click **Crawled Properties**. Then, you select a property and then change the order of the **Mappings to crawled properties** list.

## Solution

To resolve this issue, use one of the following methods, as appropriate for your situation.

### Scenario 1 solution: Set the managed property to the people index

The managed property that you mapped to People:LastName wasn't set to the people index. To change this setting, follow these steps:

1. Sign in to the Microsoft 365 admin center.

2. Click **Admin**, click **SharePoint**, and then click **search** in the SharePoint admin center.

3. Click **Manage Search Schema**.

4. Find and open the managed property that you mapped to **People:LastName**.

5. Click **Advanced Searchable Settings**, and then select **PeopleIdx** for **Full-text index**.

6. Click **OK**, and then click **OK** at the bottom of the page.

When you change the search schema in the people categories, the change is applied only after you update a user profile. If you have to apply the change to all user profiles, you should contact Microsoft 365 technical support.

### Scenario 2 solution: Change the search schema at the site collection level

The search schema change was made for a specific site collection and not at the organization level. To resolve this issue, make the change at the organization level. To do this, follow these steps:

1. Sign in to the Microsoft 365 admin center.

2. Click **Admin**, click **SharePoint**, and then click **search** in the SharePoint admin center,

3. Click **Manage Search Schema**.

4. Configure the search schema change that was made at the site collection level.

When you change the search schema in the people categories, the change is applied only after you update a user profile. If you have to apply the change to all user profiles, you should contact Microsoft 365 technical support.

### Solution for scenario 3: Update the user profiles

The changed property was not re-crawled after search schema changes were made.

When you change the search schema in the people categories, the change is applied only after you update a user profile. If you have to apply the change to all user profiles, you should contact Microsoft 365 technical support.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
