---
title: E-commerce SDK clone module known issues 
description: Provides information about the clone module process and known issues associated with this process in Dynamics 365 Commerce.
author: Bstorie
ms.author: Brstor
ms.date: 10/19/2023
---
# Known issues with e-commerce SDK clone modules

This article provides information about the clone module process and known issues associated with this process in Microsoft Dynamics 365 Commerce.

## Introduction

The Dynamics 365 e-commerce software development kit (SDK) provides the clone [command-line interface (CLI)](/dynamics365/commerce/e-commerce-extensibility/cli-command-reference#clone) command to clone a module from the [module library](/dynamics365/commerce/starter-kit-overview). The clone command attempts to copy a module from the module library to your repo for customization. When you run the clone command, the e-commerce SDK will:

1. Copy the files inside the immediate module folder (except the test files) to your repo.
2. Rename the module in the module definition to the new name provided.
3. Rename all the file and class names to map to the new module names.
4. Attempt to update all the imports in the **.tsx* files.
    - If it's a local reference, the path will be updated to reflect the new name of the module.
    - If it's a reference outside the module folder, we try to resolve the partial file path and fix the file reference.
5. Attempt to update the data action file path so the references are correct.

> [!NOTE]
> Both steps 4 and 5 are prone to errors, so it's recommended to review these files manually and fix broken references. 

## Known issues

#### Error: Can't resolve '@msdyn365-commerce-modules/\<moduleName>'

After cloning a module, you get a build error stating "Can't resolve \<moduleName>." This issue occurs because the module has an incorrect *package.json* file. The following screenshot shows that `"main"` should always point to the entry file of the module, which is typically *index.js*. For errors stating "Can't resolve \<moduleName> where the package exists," check if the path of the entry file *.js* is correct.

:::image type="content" source="media/ecommerce-clone-module-issues/invalid-json-pacakge-example.png" alt-text="Screenshot that shows an incorrect entry in the package.json file.":::

#### Error: Export 'IFullProductsSearchResultsWithCount' was not found in './get-full-products-by-collection'

When building a custom module, you might get this error even though the interface exists in the given path.

A good resource to understand the background of this issue is the [Stackoverflow thread](https://stackoverflow.com/questions/40841641/cannot-import-exported-interface-export-not-found). To summarize this thread, it's recommended to have an interface in its own file. If the interface and class are in the same file, you can't import or export them like this:

:::image type="content" source="media/ecommerce-clone-module-issues/import-module-interfaces-in-same-class.png" alt-text="Screenshot that shows the interface and class are in the same file." lightbox="media/ecommerce-clone-module-issues/import-module-interfaces-in-same-class.png":::
  
The screenshot above shows that`IFullProductsSearchResultsWithCount` and `GetFullProductsByCollectionInput` are in the same class and can't be imported like that. Instead, it should be imported with the `type` keyword, as shown in the following screenshot:

:::image type="content" source="media/ecommerce-clone-module-issues/correct-way-to-import-modules.png" alt-text="Screenshot that shows the correct process to import each object individually." lightbox="media/ecommerce-clone-module-issues/correct-way-to-import-modules.png":::
