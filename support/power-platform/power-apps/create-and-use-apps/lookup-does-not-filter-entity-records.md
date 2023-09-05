---
title: Records aren't filtered in lookup for particular entity
description: Provides workarounds to an issue in which the lookup displays all records instead of only the records that are related to what you typed in.
ms.reviewer: krgoldie, srihas
ms.topic: troubleshooting
ms.date: 04/12/2021
---
# Lookup doesn't filter records as expected for particular entity in Dynamics 365

This article provides workarounds to an issue in which the lookup displays all records instead of only the records that are related to what you typed in.

_Applies to:_ &nbsp; Power Apps  
_Original KB number:_ &nbsp; 4603850

## Symptoms

When you type into a lookup control, the lookup displays all the records in the view instead of only the records that are related to what you typed in. If you scroll through the records, you see record text bolded like normal when the text matches the search text.

:::image type="content" source="media/lookup-does-not-filter-entity-records/search-result.png" alt-text="Screenshot shows the record text bolded like normal when the text matches the search text.":::

## Cause

There are two potential causes of this issue:

### Cause 1

The issue occurs because there are no "find" columns in the **Quick Find View** of the entity.

The Lookup view determines what columns are displayed inside of the lookup control, but the **Quick Find View** - **Find columns** determines what columns are searched inside the lookup control. Basically, when you type a value into a lookup control, it searches for a match inside of the find columns. It then selects records with a match, and displays information determined by the Lookup view to you. The reason why it shows all records is that there are no "find" columns set in the **Quick Find View**.

> [!NOTE]
> **Quick Find View** columns are not the same as **Quick Find View** - **Find columns**. There can be many columns inside the **Quick Find View**, but if none are marked as "find" columns, the search will not work as expected.

The reason why the displayed and searched columns can be different is their performance. The fewer columns searched, the faster the search can be executed. However, you might want to see lots of information in the lookup control to make sure you select the right record.

For the steps to add "find" columns, see [Workaround 1](#workaround-1).

### Cause 2

The issue occurs because there are no string type columns in the view being used by the lookup control.

The lookup control can't filter non-string type columns. The view being used needs to have at least one string type column, such as text, email, phone, url, and so on.

For the steps to add a string type column, see [Workaround 2](#workaround-2).

## Workarounds

To work around this issue, use one of the following workarounds:

### Workaround 1

1. In **Customizations**, go to the **Quick Find View** for the entity of the lookup control.

1. Select **Add Find Columns**.

    :::image type="content" source="media/lookup-does-not-filter-entity-records/add-find-columns.png" alt-text="Screenshot to select the Add Find Columns item.":::

1. Add any columns that you want to be searched and matched inside of the lookup control.

    :::image type="content" source="media/lookup-does-not-filter-entity-records/add-columns-to-find-view.png" alt-text="Screenshot to add any columns that you want to be searched and matched inside of the lookup control.":::

1. Save and publish changes.

### Workaround 2

You need to add a string type column to the view used by the lookup control.

1. In **Customizations**, go to the view used by the lookup control where filtering is broken.

1. Select **Add Columns**.

    :::image type="content" source="media/lookup-does-not-filter-entity-records/add-columns.png" alt-text="Screenshot to select the Add columns item in the test view.":::

1. Add at least one string type column.
