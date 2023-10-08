---
title: E-commerce SDK clone modules known issues 
description: Provides information about the clone module process and known issues associated with this process in Dynamics 365 Commerce.
author: Bstorie
ms.author: Brstor
ms.date: 10/08/2023
---
# Known issues with e-commerce SDK clone modules

This article provides information about the clone module process and known issues associated with this process in Microsoft Dynamics 365 Commerce.

## Introduction

The Dynamics 365 e-commerce software development kit (SDK) provides the clone [command-line interface (CLI)](/dynamics365/commerce/e-commerce-extensibility/cli-command-reference#clone) command to clone a module from the [module library](/dynamics365/commerce/starter-kit-overview). The clone command attempts to copy a module from the module library to your repo for customization. When you run the clone command, the e-commerce SDK will:

1. Copy the files inside the immediate module folder (except the test files) to your repo.
2. Rename the module in the module definition to the new name provided.
3. Rename all the files and class names to map to the new module name.
4. Attempt to update all the imports in the **.tsx* files.

	  - If it's a local reference, the path will be updated to reflect the new name of the module.
	  - If it's a reference outside the module folder, we try to resolve the partial file path and fix the file references.

5. Attempt to update the data action file paths so the references are correct.

> [!NOTE]
> Both steps 4 and 5 are prone for errors, so it's recommended reviewing these files manually and fixing broken references. Microsoft strives for achieving 100% success rate but a lot depends on the code that's written, so we still have scenarios where this can result in broken references. However, it should be easy to fix these references.

## Known issues

- **Error: Can't resolve '@msdyn365-commerce-modules/\<moduleName>'**

  After cloning a module, you get a build error that states "Can't resolve \<moduleName>." This issue occurs because the module has an incorrect *package.json* file. The following screenshot shows the `"main"` should always point to the entry file of the module, which is typically *index.js*. For errors that state "can't resolve \<moduleName> where the package exists," check if the path of the entry file *.js* is correct.

  :::image type="content" source="media/ecommerce-clone-module-issues/invalid-json-pacakge-example.png" alt-text="Screenshot that shows an incorrect entry in the package.json file.":::

- **When building a custom module, you might get errors such as "export 'IFullProductsSearchResultsWithCount' was not found in './get-full-products-by-collection'" despite the interface exists in the given path.**

  A good resource to understand the background of this issue is [Stackoverflow thread](https://stackoverflow.com/questions/40841641/cannot-import-exported-interface-export-not-found). To summarize this thread, it's recommended having an interface in its own file. If you have the interface and class in the same file, you can't import or export them like this.

  :::image type="content" source="media/ecommerce-clone-module-issues/import-module-interfaces-in-same-class.png" alt-text="Screenshot that shows having the interface and class in the same file.":::

  The above screenshot shows the `IFullProductsSearchResultsWithCount` and `GetFullProductsByCollectionInput` are in the same class and can't be imported like this. Instead, it should be imported with a `type` keyword as the below screenshot shows.

  :::image type="content" source="media/ecommerce-clone-module-issues/correct-way-to-import-modules.png" alt-text="Screenshot that shows the correct process to import each object individually.":::
