---
title: Create a chunk file in Dexterity
description: Describes how to use Dexterity Utilities to create a self-extracting chunk (.cnk) file to distribute third-party Microsoft Dynamics GP customizations.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# How to create a chunk file in Dexterity in Microsoft Dynamics GP

This article describes how to create a chunk (.cnk) file in Dexterity in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 894700

## Introduction

A chunk file is a self-installing data dictionary file that creates a dictionary that is run by the Dexterity runtime engine. Additionally, a chunk file is used to distribute customizations and third-party products to seamlessly add functionality or modify existing functionality in Microsoft Dynamics GP.

## More information

Dexterity is ideal for creating transaction-based business applications, such as accounting and business management products. Additionally, Dexterity gives you the complete set of components that are used to create Microsoft Dynamics GP and Microsoft Small Business Financials. The components include a forms builder, a database manager, a report builder, a 4GL scripting language, a 4GL debugger, and an embedded macro system.

As a developer, you'll use the Dexterity IDE to create, to debug, and to test your customizations. To distribute your customization, you'll use Dexterity Utilities to create the chunk file. Dexterity Utilities can also be used to do several maintenance and reporting functions that are typically not needed during the development cycle.

The steps to create a chunk file involve two dictionaries: the development dictionary and an extracted dictionary. The development dictionary is a renamed copy of Dynamics.dic. It contains added or modified resources and code that you've developed.

An extracted dictionary is a dictionary that contains only the added or modified resources and code. It doesn't contain Dynamics.dic. Instead, it contains any modified forms and reports that were transferred from the development dictionary. Modified forms and reports become alternate forms and reports after the chunk file is installed. The chunk file is created from the extracted dictionary.

Before you create the chunk file, follow these steps in Dexterity:

- Compile your development dictionary. To open the development dictionary, select **Open Source Dictionary** on the **File** menu. With your development dictionary open, select **Compile All** on the **Explorer** menu.
- If you're using Dexterity Source Code Control, make sure that all resources are checked in. On the **Explorer** menu, select **Source Code**, and then select **Check In**.
- Make sure that the **Resource IDs** that are assigned to the resources you created don't change values between builds. For more information, see [How to use an index file and the Microsoft Dynamics GP Dexterity source code control functionality to make sure that the resources that you create maintain the same resource ID in different builds and versions of your code](https://support.microsoft.com/help/894699).

> [!NOTE]
> You can create a macro to record the following steps. You can then replay the macro later to re-create the chunk file or to modify the macro in a text editor to change the build number and any other details.

To create a chunk file, follow these steps in Dexterity Utilities:

1. On the **File** menu, select **Open Source Dictionary** to open the development dictionary as the source dictionary.
2. On the **Utilities** menu, select **Extract** to extract all third-party resources to an extracted dictionary. These resources will have a **Resource ID** that is greater than 22,000.

    > [!NOTE]
    > If you don't have alternate forms or reports, go to step 6. Alternate forms and reports are original Microsoft Dynamics GP forms and reports that have been modified in your customization. Because their resource IDs are less than 22,000, they are not extracted in step 2. So additional steps are required to move alternate forms and reports to your chunk file.
3. On the **File** menu, select **Open Destination Dictionary** to open the destination dictionary by using the extracted dictionary that you created in step 2.
4. On the Dexterity Utilities toolbar, select **Transfer**, and then select **Dictionary Module** to transfer the alternate forms or reports to the extracted dictionary.
5. On the **File** menu, select **Close Destination Dictionary**.
6. On the **File** menu, select **Close Source Dictionary**.
7. On the **File** menu, select **Open Editable Dictionary** to open the editable dictionary by using the extracted dictionary that you created in step 2.

    > [!NOTE]
    > If you don't have any alternate forms or reports, go to step 9.
8. Update the internal **Series Resources** lists to include the alternate forms or reports. On the Dexterity Utilities toolbar, select **Resources**, and then select **Series Resources**. Select the **All Resource Types** check box and the **All Series** check box, and then select **Update**.
9. On the Dexterity Utilities toolbar, select **Product Information**. Enter the following information:
   - The product name
   - The product ID that has been assigned to you by Microsoft Sales Operations
   - The names of the custom forms and reports dictionaries
   - Compatibility information

   Select **OK**. Type *DYNAMICS.SET* in the **Launch file** box, and type **0** in the **Launch ID** box.

10. Create the chunk file:
    1. On the **Utilities** menu, select **Auto Chunk**.
    2. Select **Browse** to name the chunk dictionary and to indicate the location where it will be saved. You can use an 8.3 formatted file name with the extension chunk, for example, Fabrikam.cnk.
    3. Select a **module**, for example, 51.
    4. Enter the **major**, **minor**, and **build** numbers. You can match your major and minor numbers to the Microsoft Dynamics GP version that you use, and then type your own build number.
    5. Select **Total Compression** to remove the source code from the final chunk file, and then select **OK**.
11. On the **File** menu, select **Close Editable Dictionary**.

## References

For more information that is related to this article, see the Integration Guide manual and Dexterity training materials that are included with Dexterity.
