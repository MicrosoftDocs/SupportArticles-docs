---
title: How to copy items between two SharePoint lists via Flow
description: Describes the procedure to copy all the items of a SharePoint list in one site to to a second SharePoint site by building a flow.
ms.reviewer: 
ms.topic: how-to
ms.date: 03/31/2021
ms.subservice: power-automate-flow-creation
---
# How to use Flow to copy items between two data sources

This article describes how to use Microsoft Flow to copy items between two data sources efficiently.

For example, you can build a flow to copy all the items from a SharePoint list in one site to a second SharePoint site. The flow process also works between a SharePoint list and an SQL table or any of the more than 100 services that are supported by Flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4467880

## More information

You must populate all the required columns. There's no requirement that the names of all columns in your two data sources be the same, but there must be at least one column (of your choice) that will be able to uniquely identify items between the two data sources.

In the following example, we assume that the **Title** column is the same in both sources.

### Set up the trigger

The first step is to set up your trigger on the source SharePoint list. Because you want to capture all item changes (not only new items), you should select the **SharePoint - When an existing item is modified** trigger.

:::image type="content" source="media/how-to-copy-items-between-two-sharepoint-lists-via-flow/when-an-existing-item-is-modified.png" alt-text="Screenshot to select the When an existing item is modified trigger in Sharepoint.":::

> [!NOTE]
> Although the trigger name mentions only modifications to existing items, the trigger also reacts to new items that are added to the list.

### Find the item in the destination

Search for the item in the destination list to get its ID and update it. Although Flow has a **Filter** action, you should not use that action in this scenario because that action downloads all list items from SharePoint. The process will be slow, will use up your quota, and will not work if the list has more than 256 items.

Instead, you should use the **Filter Query** field on the **Get items** step in SharePoint. Add the **Get items** action, and then select **Show advanced options** to show all the fields. If you are matching the titles of the rows of the source list, type the following in the **Filter Query** field (make sure that you include the single quotation marks):

Title eq '[*select the title from dynamic content*]'

:::image type="content" source="media/how-to-copy-items-between-two-sharepoint-lists-via-flow/get-items.png" alt-text="Screenshot to type the title in the Filter Query field on the Get items step.":::

You don't necessarily have to have a strict 1:1 column mapping between the two data sources. For example, if you have **First Name** and **Last Name** columns in the source list, and a **Full name** column in the destination list, you can type **FullName eq '[*First name*] [*Last name*]'** in the **List Name** field.

### Add a condition to check whether the item exists

When you get the items from the destination list, one of the following situations will be true:

- The item doesn't yet exist in the destination, so you have to create it.
- The item already exists in the destination, and you have to update it.

Use a condition to determine the actual situation. To do this, follow these steps:

1. Select **New step**, and then select **Add a condition**.
2. Under the left text box on the **Condition** card, select **Add dynamic content**.

    > [!NOTE]
    > The collection that contains the list of all items returned by **Get items**  is named **value**. Make sure that you select the value from **Get items** (not from the trigger if an existing item is changed).

    :::image type="content" source="media/how-to-copy-items-between-two-sharepoint-lists-via-flow/value-listed-when-adding-condition.png" alt-text="Screenshot shows that a value collection is listed in Get items when adding a condition.":::

3. On the **Condition** card, select **is equal to** in the **Relationship** box, and then type *0* in the **Value** box.

4. Add the length function in Advanced mode. This is important because the dynamic value content returns the list of items. You have to determine whether the length of the list (not the value) equals 0 (zero).

5. In Advanced mode, type **length()** around the **body('Get_items')?['value']** expression. Your condition appears as follows.

    :::image type="content" source="media/how-to-copy-items-between-two-sharepoint-lists-via-flow/length-is-0.png" alt-text="Screenshot of the Condition box shows the length of the list equals 0.":::

### Create the item

In the **IF YES**  branch, you will add a SharePoint **Create item** step.

Select the site and list that you used in the *Get items* steps. In **Create item**, you should populate each column by using fields from the trigger only. You should not use any data from the *Get items* steps because that would be coming from the destination list, not the source list. *Get items* will appear above the trigger. Make sure that you scroll to the bottom to find it.

### Update the item

In the **IF NO** branch, you will add a SharePoint **Update item** step.

Select the site and list. Then, select the ID that's returned from the **Get items** steps.

:::image type="content" source="media/how-to-copy-items-between-two-sharepoint-lists-via-flow/id-in-get-items.png" alt-text="Screenshot to select the ID that's returned from the Get items steps.":::

When you add the ID, an **Apply to each** container is automatically added around the **Update item** step. This is expected behavior. If the query that you used in the **Get items** step is accurate, the container will update only the item that you want to copy. After you complete the remaining fields (and make sure that you use the outputs from the trigger, not from the **Get items** call), your condition block should resemble the following screenshot.

:::image type="content" source="media/how-to-copy-items-between-two-sharepoint-lists-via-flow/condition-block.png" alt-text="Screenshot shows an example of the condition block.":::

### Limitations of the flow process

The flow process enables changes that are made in the first list to be reflected in the second list.

The following limitations apply to the process:

- If items are deleted from the first list, the items will not be deleted from the second list. This is because there is no trigger for **When an item is deleted**. In this case, there is no way for a flow to be notified when a deletion occurs. Instead, we recommend that you add a column to indicate that the item is no longer needed or relevant instead of deleting items from SharePoint lists (or SQL tables, or other data source). That column will sync between the two lists.
- If changes are made to the field that you are using to keep items in sync between the two lists, a new item is created in the destination list. For example, if you use a person's **Name** column to copy between the two lists, and that person's **Name** column changes, the flow considers that change to be a new item, not an update to an existing item. If you can guarantee that the **Name** column will never change, you won't be affected by this limitation. However, if the **Name** column does change, you have to add to the destination list a column that stores the ID of the item in the first list. In this case, instead of using **Name** to find items, you can use **ID**. (The ID is guaranteed to always be unique).
- This process is not a two-way sync. That means that if items are updated in the destination list, the changes will not be reflected in the source list. You should not try to set up two-way sync in the flow because that will create an infinite loop without additional modifications. For example, list A will update list B, list B will update list A, list A will update list B again, and so on.
