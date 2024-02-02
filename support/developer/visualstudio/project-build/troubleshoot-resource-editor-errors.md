---
title: Troubleshoot Resource Editor errors
description: Learn how to resolve errors that can occur when you use the Resource Editor. 
ms.date: 01/31/2023
f1_keywords:
- msvse_settingsdesigner.err.formatvalue
- msvse_resedit.err.nameblank
- msvse_resedit.err.duplicatename
ms.reviewer: tglee, v-jayaramanp
---

# Troubleshoot errors in the Resource Editor

_Applies to:_&nbsp;Visual Studio

When you're working with resource files for your application by using the Resource Editor in Visual Studio, you might run into errors. Here are some of the typical error messages that can appear, along with instructions on how to resolve the errors.

## Error: There is already another resource with the name 'Name'

This error occurs when you have a duplicate name for a resource in your resource list. Follow these steps to fix the issue.

1. In **Solution Explorer**, right-click the project node, and then select **Properties**.
1. In the **Search properties** dialog, select **Resources**.
1. Delete the duplicate resource item or rename it.

## Error: The resource name cannot be empty

This error occurs when you have a value for a resource that's yet unnamed. Follow these steps to fix the issue.

1. In **Solution Explorer**, right-click the project node, and then select **Properties**.
1. In the **Search properties** dialog, select **Resources**.
1. Make sure to provide a name for each resource item.

## Support options

Here are more support resources that you might find useful:

- Ask a question or find an answer on the [Microsoft Q&A](/answers/tags/176/vs) page for Visual Studio.
- Report product issues to the engineering team using the [Report a problem](/visualstudio/ide/how-to-report-a-problem-with-visual-studio) tool that appears both in the Visual Studio Installer and in the Visual Studio IDE.
- Track product issues and engineering team responses in the [Visual Studio Developer Community](https://aka.ms/feedback/suggest?space=8).

## References

- [Manage application resources (.NET)](/visualstudio/ide/managing-application-resources-dotnet)
- [Managing app resources (Visual Studio for Mac)](/visualstudio/mac/managing-app-resources)