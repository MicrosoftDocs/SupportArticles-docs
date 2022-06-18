---
title: Isolate issues in canvas apps
description: Learn about techniques to narrow down the cause of errors in canvas apps.
author: tahoon

ms.subservice: troubleshoot
ms.topic: conceptual
ms.custom:
ms.reviewer:
ms.date: 06/15/2022
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---

# Isolate issues in canvas apps

Canvas apps allow a lot of freedom in design of visuals, data connections, and processing. But that also means that the type of problems are diverse. [IntelliSense](/power-platform/power-fx/overview) and the [app checker](https://powerapps.microsoft.com/en-us/blog/new-app-checker-helps-you-fix-errors-and-make-accessible-apps/) guards against common issues. [Monitor](../monitor-overview.md) and the [Variables panel](working-with-variables.md#use-a-context-variable) can aid in debugging.

Here are some other techniques to isolate problems in a canvas app.


## Inspect formulas with debug labels

Formulas can be complex. When things go wrong, it can be difficult to pinpoint which part failed. Debug labels are an useful technique to see the results of different parts of a formula.

A debug label is simply a **[Label](controls/control-text-box.md)** with its **Text** property set to a formula of interest. It lets you see exactly how Power Apps treats these formulas. To avoid [scoping bugs](#try-a-different-app-structure), insert the debug label outside other controls like **Gallery** and **Form**.

Imagine that a **Combo box** control is showing less items than expected and the dropdown options are blank.

![Expanded combo box, showing empty space where options should be in the dropdown](media/isolate-canvas-app-issues/empty-combobox.png)

The obvious thing to check is whether the **Combo box** is configured correctly. Here, its **Items** property is set to a complex formula:

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

Start with the innermost expression ``Filter( Products, Rating > 4 )``. Insert a debug label and set its **Text** property to test the result of that expression. Some useful things to verify:

* Check if the number of results is as expected: ``CountRows( Filter( Products, Rating > 4 ) )``
* Examine the first result and verify the filter is working as expected: ``"Rating of first result is " & First( Filter( Products, Rating > 4 ) ).Rating``
* Check results by combining their names: `` Concat( Filter( Products, Rating > 4 ), ProductName & ", ")``

> [!TIP]
> When working with datasets, debug tables are useful for previewing records. The concept is similar to debug labels. Insert a **[Data table](controls/control-data-table.md)** with its **Items** property set to the dataset of interest.
> You might want to use the [FirstN and LastN functions](functions/function-first-last.md) for better performance with datasets.

Once you've confirmed that an expression is evaluated correctly, you can move on to the next outer expression ``GroupBy( Filter( Products, Rating > 4 ), "ProductType", "Details" )``. By proceeding methodically, you can find out which part of a complex expression is not working.

As for the empty dropdown options, the **DisplayFields** property is a good place to start. Imagine it's set to ``[ProductType]``. Use a debug label to verify that this field is recognized by Power Apps and contains text. Since all the dropdown options are empty, it's sufficient to examine any record. Let's pick the first record and see what its ``ProductType`` field is. Set the debug label to:

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

* The ``ProductType`` for that record really is empty. If the dataset comes from outside the app, check it outside of Power Apps.
* One or more of the expressions is not working. Break it down as described above to find out which one(s). It could be a Power Apps bug or a mistake in writing the formula.
* Data is not reaching Power Apps. It could be a networking issue, an issue with the data source, or a Power Apps bug.

If the result has text, then it's likely a Power Apps bug with the control. You can report the bug to Microsoft and [use a different control](#try-a-different-control) as a workaround.

## Try a different control

To find out if the issue is with a specific control, try using a different control that has the same [type](functions/data-types.md) of input or output.

### Boolean
* [Check box](controls/control-check-box.md)
* [Toggle](controls/control-toggle.md)

### Choice and Table
* [Charts](controls/control-column-line-chart.md)
* [Combo box](controls/control-combo-box.md)
* [Data table](controls/control-data-table.md)
* [Dropdown](controls/control-drop-down.md)
* [Gallery](controls/control-gallery.md)
* [List box](controls/control-list-box.md)
* [Radio](controls/control-radio.md)

### Date and DateTime
* [Date picker](controls/control-date-picker.md)
* [Text input](controls/control-text-input.md)

### Image and Media
* [HTML text](controls/control-html-text.md)
* [Image](controls/control-image.md)
* **Image** property of [Audio, Video](controls/control-audio-video.md), and [Microphone](controls/control-microphone.md)

### Number
* [Rating](controls/control-rating.md)
* [Slider](controls/control-slider.md)
* [Text input](controls/control-text-input.md)

### Text
* [Rich text editor](controls/control-richtexteditor.md)
* [Text input](controls/control-text-input.md)

### All types
* [Label](controls/control-text-box.md), after converting a value to text

If the same problem happens on a different control, then the issue is with the formulas or data source used. Proceed with the debugging steps above to further isolate the issue.

If the problem only happens on a particular type of control, then it's likely a control bug. You can report the bug to Microsoft.

## Try a different app structure

Formulas can behave differently for controls inside another control. For example, controls inside a **Gallery** can use **[ThisItem](functions/operators.md#thisitem-thisrecord-and-as-operators)** but those outside can't. Controls outside a **Gallery** or **Component** cannot reference the controls inside.

This different visibility of identifiers is called [scope](working-with-tables.md#record-scope). Controls that contain other controls introduce a new scope.

* [Component](create-component.md)
* [Container](controls/control-container.md)
* [Display form](controls/control-form-detail.md)
* [Edit form](controls/control-form-detail.md)
* [Gallery](controls/control-gallery.md)
* [Horizontal container](controls/control-horizontal-container.md)
* [Scrollable screen (Fluid grid)](add-scrolling-screen.md)
* [Vertical container](controls/control-vertical-container.md)

If a formula is not working inside a contained control, it could be related to scoping. Try using the same formula outside the container.

For example, a **Label** control inside a **Gallery** should show each record's name but no text is appearing. **Label.Text** is set to ``ThisItem.Name``. **Gallery.Items** is set to ``Products``.

![A gallery shows empty space instead of text. The property panel shows the formulas used for the Labels in the gallery.](media/isolate-canvas-app-issues/empty-gallery.png)

To check if it is a scoping issue, insert a [debug label](#inspect-formulas-with-debug-labels) outside the **Gallery**, at the top-level of the app. Set its **Text** property to show the name of the first record of the dataset: ``First(Products).Name``.

The debug label should have the same result as the first row of the gallery. If not, it is likely a scoping bug with Power Apps and you should report it to Microsoft. On the other hand, if both are blank, then the issue could be with the data source.

Some possible workarounds for scoping issues:

* Move controls outside of their containers
* Refer to data in [global or context variables](working-with-variables.md)
* Use [Patch](functions/function-patch.md) to avoid using an [Edit form](controls/control-form-detail.md) control

## Restore to an earlier version

If you haven't made major changes to an app and it suddenly stopped working after re-publishing it, try [restoring it to the previous version](restore-an-app.md). If it works again, examine the changes made to see what might have broke the app.

Sometimes, bugs may be introduced with new versions of Power Apps. Conversely, new versions may bring bug fixes. Microsoft Support can recommend whether you should [revert to an older authoring version or upgrade to a newer one](studio-versions.md). If you change the authoring version on your own, be aware that there is limited support for non-recommended versions.

## Create a minimal repro app

The process of creating a [minimal repro app](minimal-repro-app.md) may uncover app configuration errors that aren't obvious with a complex app. Even if the problem isn't fixed, you would have narrowed the cause and made it easier to explain the problem to others. This is what professional app and website makers do when they want to report a bug on a platform like Edge browser or iOS operating system.

## Next steps

[Debugging canvas apps with Monitor](../monitor-canvasapps.md)


### See also

[Think like a debugger](../common/isolate-issues.md)


[!INCLUDE[footer-include](../../includes/footer-banner.md)]