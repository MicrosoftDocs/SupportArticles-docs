---
title: Troubleshoot Resource Editor errors
description: Learn how to resolve errors that can occur when you use the Resource Editor. 
ms.date: 03/13/2023
ms.topic: troubleshooting
ms.custom: sap:Project/Build System
f1_keywords:
- msvse_settingsdesigner.err.formatvalue
- msvse_resedit.err.nameblank
- msvse_resedit.err.duplicatename
author: padmajayaraman
ms.author: v-jayaramanp
ms.reviewer: tglee
---
# Troubleshoot errors in the Resource Editor

 _Applies to:_&nbsp;Visual Studio

When you're working with resource files for your application by using the Resource Editor in Visual Studio, you might run in to errors. Here are some of the typical error messages that can appear, along with instructions on how to resolve the errors.

## Issue: There is already another resource with the name 'Name'

This error occurs when you have a duplicate name for a resource in your resource list. Follow these steps to fix the issue.

1. In **Solution Explorer**, right-click the project node, and then select **Properties**.

1. In the **Search properties** dialog, select **Resources**.

1. Delete the duplicate resource item or rename it.

## Issue: The resource name cannot be empty

This error occurs when you have a value for a resource that's yet unnamed. Follow these steps to fix the issue.

1. In **Solution Explorer**, right-click the project node, and then select **Properties**.

1. In the **Search properties** dialog, select **Resources**.

1. Make sure to provide a name for each resource item.

## Support options

Here are more support resources that you might find useful:

- Ask a question or find an answer on the [Microsoft Q&A](/answers/tags/176/vs) page for Visual Studio.
- Report product issues to the engineering team using the [Report a problem](/visualstudio/ide/how-to-report-a-problem-with-visual-studio) tool that appears both in the Visual Studio Installer and in the Visual Studio IDE.
- Track product issues and engineering team responses in the [Visual Studio Developer Community](https://aka.ms/feedback/suggest?space=8).

## See also

- [Manage application resources (.NET)](/visualstudio/ide/managing-application-resources-dotnet)
- [Managing app resources (Visual Studio for Mac)](/visualstudio/mac/managing-app-resources)