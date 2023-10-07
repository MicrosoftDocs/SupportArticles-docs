---
title: Known issues - E-Commerce SDK Clone Modules 
description: This article provides information about the Clone module process and known issues associated with this process.
author: Bstorie
ms.author: Brstor
ms.topic: troubleshooting-known-issue 
ms.date: 10/03/2023
---

# Introduction
This article provides information about the Clone module process and known issues associated with this process.

E-Commerce SDK provides CLI commands provides the ability to clone a module from the Module Library. Clone command will attempt to copy a module from the Module library into the your repo so you can customize the module to your needs. When you run the clone command, the e-commerce SDK will attempt to do the following
1. Copy the files inside the immediate module folder (except the test files) to the your repo.
2. It will also rename the module in the module definition to the new name provided.
3. It will rename all the files and the classnames to map to the new module name
4. *Attempt* to update all the imports in the *.tsx files.
	1. If its a local reference, path will be updated to reflect the new name of the module
	2. If its a reference outside of the module folder, we try to resolve the partial file path and try and fix up the file references.
5. *Attempt* to update the data action file paths so the references are correct.

 Both steps 4 and 5 are prone for errors so we recommend reviewing these files manually and fix any broken references. We strive for achieving 100% success rate but a lot depends on the code that is written so we still have scenarios where this can result in broken references. However it should be easy to fix these references.
 
# Known issues: 

-  **Error: Can't resolve '@msdyn365-commerce-modules/<moduleName>'**   
  After cloning a module, you get build error saying "Cant resolve <moduleName>". Upon investigation, it was noticed that the module had incorrect package.json. As you can see from below picture, the main should always point to the entry file of the module, which is typically index.js. For errors that say Can't resolve < moduleName> where the package exists, validate if the path of the entry js file is correct.  
 :::image type="content" source="invalidjsonpacakgeexample.png" alt-text="Screenshot that shows an incorrect entry in the package.json file.":::

- **When building a custom module, you might get errors such as "export 'IFullProductsSearchResultsWithCount' was not found in './get-full-products-by-collection'"**  despite the interface existing in the given path.  
   A good resource to understand the background of this issue can be found on this [Stackoverflow thread](https://stackoverflow.com/questions/40841641/cannot-import-exported-interface-export-not-found). To summarize this thread, its recommended to have an interface in its own file. If you have interface and class in the same file, you cannot import or export them like this.  
 :::image type="content" source="importmoduleinterfacesinsameclass.png" alt-text="Screenshot that shows an having interface and class in same file.":::  
  In above screenshot, IFullProductSearchResultWithCount and GetFiullProductsByCollectionInput are in the same class and cannot be imported like this. Instead, it should be imported as below with a type keyword.   
:::image type="content" source="correctwaytoimportmodules.png" alt-text="Screenshot that shows the correct processe to import each object individually.":::


