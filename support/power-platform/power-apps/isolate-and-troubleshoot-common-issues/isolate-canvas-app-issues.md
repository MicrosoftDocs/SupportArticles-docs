---
title: Isolate issues in canvas apps
description: Learn about techniques to narrow down the cause of errors in canvas apps.
author: tahoon
ms.reviewer: tapanm
ms.date: 06/24/2022
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# Isolate issues in canvas apps

Canvas apps allow you to design apps with numerous different visuals and various data connections. Use [IntelliSense](/power-platform/power-fx/overview) and the [App checker](https://powerapps.microsoft.com/blog/new-app-checker-helps-you-fix-errors-and-make-accessible-apps/) as guards against common issues. [Monitor](/power-apps/maker/monitor-overview) and the [Variables panel](/power-apps/maker/canvas-apps/working-with-variables#use-a-context-variable) can help you with debugging.

Here are some other techniques to isolate problems in a canvas app.

## Inspect formulas with debug labels

Formulas can be complex. When things go wrong, it can be difficult to pinpoint which part failed. Debug labels are a useful technique to see the results of different parts of a formula.

A debug label is a [Label](/power-apps/maker/canvas-apps/controls/control-text-box) with its **Text** property set to a formula of interest. It lets you see exactly how Power Apps treats these formulas. To avoid [scoping bugs](#try-a-different-app-structure), insert the debug label outside other controls like **Gallery** and **Form**.

Imagine that a **Combo box** control is showing less than expected and the dropdown options are blank.

:::image type="content" source="media/isolate-canvas-app-issues/empty-combobox.png" alt-text="Expanded combo box, showing an empty space where options should be in the dropdown.":::

Check if the **Combo box** is configured correctly. For example, the **Items** property is set to a complex formula below:

```powerapps-dot
AddColumns(
  GroupBy(
    Filter( Products, Rating > 4 ),
    "ProductType",
    "Details"
  ),
  "Total quantity",
  Sum( Details, Quantity )
)
```

Start with the innermost expression `Filter( Products, Rating > 4 )`. Insert a debug label and set its **Text** property to test the result of that expression. Some useful information to verify:

- Check if the number of results is as expected: `CountRows( Filter( Products, Rating > 4 ) )`
- Examine the first result and verify the filter is working as expected: `"Rating of first result is " & First( Filter( Products, Rating > 4 ) ).Rating`
- Check results by combining their names: `Concat( Filter( Products, Rating > 4 ), ProductName & ", ")`

> [!TIP]
> When working with datasets, debug tables are useful for previewing records. The concept is similar to debug labels. Insert a [Data table](/power-apps/maker/canvas-apps/controls/control-data-table) with its **Items** property set to the dataset of interest.
>
> You might want to use the [FirstN and LastN functions](/power-apps/maker/canvas-apps/functions/function-first-last) for better performance with datasets.

Once you've confirmed that an expression is evaluated correctly, you can move on to the next outer expression `GroupBy( Filter( Products, Rating > 4 ), "ProductType", "Details" )`. By proceeding methodically, you can find out which part of a complex expression isn't working.

When using empty dropdown options, start with the **DisplayFields** property. Imagine it's set to `[ProductType]`. Use a debug label to verify that this field is recognized by Power Apps and contains text. Since all the dropdown options are empty, it's sufficient to examine any record. Let's pick the first record and see what its `ProductType` field is. Set the debug label to:

```powerapps-dot
First(
  AddColumns(
    GroupBy(
      Filter( Products, Rating > 4 ),
      "ProductType",
      "Details"
    ),
    "Total quantity",
    Sum( Details, Quantity )
  )
).ProductType
```

If the result is empty, it could be:

- The `ProductType` field for that record really is empty. If the dataset comes from outside the app, check it outside of Power Apps.
- One or more of the expressions isn't working. Break it down as described above to narrow down. It could be a Power Apps bug or a mistake in writing the formula.
- Data isn't reaching Power Apps. It could be a networking issue, an issue with the data source, or a Power Apps bug.

If the result has text, then it's likely a Power Apps bug with the control. You can report the bug through a [support request](/power-platform/admin/get-help-support) and [use a different control](#try-a-different-control) as a workaround.

## Try a different control

To find out if the issue is with a specific control, try using a different control that has the same [data type](/power-platform/power-fx/data-types) of input or output.

### Boolean

- [Check box](/power-apps/maker/canvas-apps/controls/control-check-box)
- [Toggle](/power-apps/maker/canvas-apps/controls/control-toggle)

### Choice and Table

- [Charts](/power-apps/maker/canvas-apps/controls/control-column-line-chart)
- [Combo box](/power-apps/maker/canvas-apps/controls/control-combo-box)
- [Data table](/power-apps/maker/canvas-apps/controls/control-data-table)
- [Dropdown](/power-apps/maker/canvas-apps/controls/control-drop-down)
- [Gallery](/power-apps/maker/canvas-apps/controls/control-gallery)
- [List box](/power-apps/maker/canvas-apps/controls/control-list-box)
- [Radio](/power-apps/maker/canvas-apps/controls/control-radio)

### Date and DateTime

- [Date picker](/power-apps/maker/canvas-apps/controls/control-date-picker)
- [Text input](/power-apps/maker/canvas-apps/controls/control-text-input)

### Image and Media

- [HTML text](/power-apps/maker/canvas-apps/controls/control-html-text)
- [Image](/power-apps/maker/canvas-apps/controls/control-image)
- **Image** property of [Audio, Video](/power-apps/maker/canvas-apps/controls/control-audio-video), and [Microphone](/power-apps/maker/canvas-apps/controls/control-microphone)

### Number

- [Rating](/power-apps/maker/canvas-apps/controls/control-rating)
- [Slider](/power-apps/maker/canvas-apps/controls/control-slider)
- [Text input](/power-apps/maker/canvas-apps/controls/control-text-input)

### Text

- [Rich text editor](/power-apps/maker/canvas-apps/controls/control-richtexteditor)
- [Text input](/power-apps/maker/canvas-apps/controls/control-text-input)

### All types

- [Label](/power-apps/maker/canvas-apps/controls/control-text-box), after converting a value to text

If the same problem happens on a different control, then the issue is with the formulas or data source used. Proceed with the debugging steps above to further isolate the issue.

If the problem only happens on a particular type of control, then it's likely a control bug. You can report the bug to Microsoft.

## Try a different app structure

Formulas can behave differently for controls inside another control. For example, controls inside a **Gallery** can use [ThisItem](/power-apps/maker/canvas-apps/functions/operators#thisitem-thisrecord-and-as-operators) but controls outside the gallery can't. Controls outside a **Gallery** or **Component** can't reference the controls inside.

This different visibility of identifiers is called [scope](/power-apps/maker/canvas-apps/working-with-tables#record-scope). Controls that contain other controls introduce a new scope.

- [Component](/power-apps/maker/canvas-apps/create-component)
- [Container](/power-apps/maker/canvas-apps/controls/control-container)
- [Display form](/power-apps/maker/canvas-apps/controls/control-form-detail)
- [Edit form](/power-apps/maker/canvas-apps/controls/control-form-detail)
- [Gallery](/power-apps/maker/canvas-apps/controls/control-gallery)
- [Horizontal container](/power-apps/maker/canvas-apps/controls/control-horizontal-container)
- [Scrollable screen (Fluid grid)](/power-apps/maker/canvas-apps/add-scrolling-screen)
- [Vertical container](/power-apps/maker/canvas-apps/controls/control-vertical-container)

If a formula isn't working inside a contained control, it could be related to scoping. Try using the same formula outside the container.

For example, a **Label** control inside a **Gallery** should show each record's name but no text is appearing. **Label.Text** is set to `ThisItem.Name`. **Gallery.Items** is set to `Products`.

:::image type="content" source="media/isolate-canvas-app-issues/empty-gallery.png" alt-text="A gallery shows an empty space instead of text. The property panel shows the formulas used for the labels in the gallery.":::

To check if it's a scoping issue, insert a [debug label](#inspect-formulas-with-debug-labels) outside the **Gallery**, at the top-level of the app. Set its **Text** property to show the name of the first record of the dataset: `First(Products).Name`.

The debug label should have the same result as the first row of the gallery. If not, it's likely a scoping bug with Power Apps that you can report through a [support request](/power-platform/admin/get-help-support). On the other hand, if both are blank, then the issue could be with the data source.

Some possible workarounds for scoping issues:

- Move controls outside of their containers
- Refer to data in [global or context variables](/power-apps/maker/canvas-apps/working-with-variables)
- Use [Patch](/power-apps/maker/canvas-apps/functions/function-patch) to avoid using an [Edit form](/power-apps/maker/canvas-apps/controls/control-form-detail) control

## Restore to an earlier version

If you haven't made major changes to an app and it suddenly stopped working after republishing it, try [restoring it to the previous version](/power-apps/maker/canvas-apps/restore-an-app). If it works again, examine the changes made to see what might have broken the app.

Sometimes, bugs may be introduced with new versions of Power Apps. Conversely, new versions may bring bug fixes. Microsoft Support can recommend whether you should [revert to an older authoring version or upgrade to a newer one](/power-apps/maker/canvas-apps/studio-versions). Remember there's limited support for non-recommended versions if you change the authoring version on your own.

## Create a minimal repro app

The process of creating a [minimal repro app](minimal-canvas-app-repro.md) may uncover app configuration errors that aren't obvious with a complex app. Even if the problem isn't fixed, you would have narrowed the cause and made it easier to explain the problem to others.

## Next steps

[Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps)

## See also

[General Power Apps debugging strategies](isolate-common-issues.md)
