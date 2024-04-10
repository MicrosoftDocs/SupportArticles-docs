---
title: Troubleshoot project templates and item templates
description: Learn how to troubleshoot templates when they fail to load in the development environment.
ms.date: 01/02/2018
ms.reviewer: tglee, v-jayaramanp
---

# Troubleshoot project and item templates

_Applies to:_&nbsp;Visual Studio

If a template fails to load in the development environment, there are several ways to locate the problem.

## Validate the vstemplate file

If the _vstemplate_ file in a template doesn't adhere to the Visual Studio template schema, the template may not appear in the dialog box where you create new projects.

### Validating the vstemplate file

1. Locate the _.zip_ file that contains the template.
1. Extract the _.zip_ file.
1. On the **File** menu in Visual Studio, select **Open** > **File**.
1. Select the _vstemplate_ file for the template, and select **Open**.
1. Verify that the XML of the _vstemplate_ file adheres to the template schema.
   For more information on the _vstemplate_ schema, see the [Template schema reference](/visualstudio/extensibility/visual-studio-template-schema-reference) section.

    > [!NOTE]
    > To get IntelliSense support while authoring the _vstemplate_ file, add a `xmlns` attribute to the `VSTemplate` element, and assign it a value of `http://schemas.microsoft.com/developer/vstemplate/2005`.

1. Save and close the _vstemplate_ file.
1. Select the files included in your template, right-click, and select **Send to** > **Compressed (zipped) folder**. The files that you selected are compressed into a _.zip_ file.
1. Place the new _.zip_ file in the same directory as the old _.zip_ file.
1. Delete the extracted template files and the old template _.zip_ file.

## Enable diagnostic logging

You can enable diagnostic logging for template discovery by following the steps in the [Troubleshoot template discovery (extensibility)](/visualstudio/extensibility/troubleshooting-template-discovery) section.

## References

- [Troubleshoot template discovery (extensibility)](/visualstudio/extensibility/troubleshooting-template-discovery)
- [Customize templates](/visualstudio/ide/customizing-project-and-item-templates)
- [Create project and item templates](/visualstudio/ide/creating-project-and-item-templates)
- [Template schema reference](/visualstudio/extensibility/visual-studio-template-schema-reference)
