---
title: Disable third-party products or temporarily disable additional products in the Dynamics.set file in Microsoft Dynamics GP
description: Describes the steps to change the Dynamics.set file to stop third-party products from starting when Microsoft Dynamics GP is started.
ms.reviewer:
ms.topic: how-to
ms.date: 03/13/2024
---
# Steps to disable third-party products or temporarily disable additional products in the Dynamics.set file in Microsoft Dynamics GP

This article describes how to disable a third-party product or temporarily disable an additional product that is integrated with Microsoft Dynamics GP. For an additional products, use this article to temporarily remove the product. If you want to permanently remove an additional Microsoft Dynamics GP product, use the **Programs and Features** item in Control Panel to uninstall it.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872087

> [!NOTE]
> [Method 3: create new vanilla Dynamics GP code folder for testing](#method-3-create-new-vanilla-dynamics-gp-code-folder-for-testing) is the cleanest method for removing 3rd party products. [Method 1: Remove from Dynamics.set file](#method-1-remove-from-dynamicsset-file) will suffice if you are able to start Dynamics GP after removing the product. [Method 2: Temporarily disable in the front-end in Customization Status](#method-2-temporarily-disable-in-the-front-end-in-customization-status) may work, but is not always reliable.

## Method 1: Remove from Dynamics.set file

To preferred method to disable a third-party product is to remove it from the Dynamics.set file. When you do this, Microsoft Dynamics GP can start without other products also trying to load. To edit the Dynamics.set file, follow these steps.

> [!NOTE]
> Each workstation has a Dynamics.set file in their own Dynamics GP code folder. Therefore, complete these steps on each workstation to disable the third-party product on all workstations.

1. Locate the Dynamics.set file in the local Microsoft Dynamics GP folder.

    To find the location of the Microsoft Dynamics GP code folder, log on to Microsoft Dynamics GP, click the **Tools** menu, point to **Setup**, point to **System**, and then click **Edit Launch File**.  Click to select the first product of 0 for Microsoft Dynamics GP, and the dictionary locations will populate at the bottom.   Take not of the paths for the dictionary locations.  Navigate to that location on your workstation.

    > [!NOTE]
    > If you are set up not to show extensions of known file types, you may see multiple "Dynamics" files in the folder. You have to open the file that has the ".set" extension. To know which file to open, click **Views**, and then click **Details**. If you are using Windows XP, the file type is Dynamics Launch File. If you are using Windows Vista, the file type is SET File.

2. Right-click on the current **Dynamics.set file**. and click **COPY** to save a copy of it.
3. Right-click the **Dynamics.set** file, and then click **Edit**.

    The Dynamics.set file will open in Notepad. For example, the Dynamics.set file resembles the following structure:

    > \----------------------------------------------------  
    2  
    0  
    Microsoft Dynamics GP  
    >
    > 1493 **(Additional or Third-Party Product_ID_Number)**  
    SmartList **(Additional or Third-Party Product_Name)**  
    >
    > Windows  
    :C: Microsoft Dynamics GP/Dynamics.dic  
    :C: Microsoft Dynamics GP/Forms.dic  
    :C: Microsoft Dynamics GP/Reports.dic
    >
    > example:  
    :C: Microsoft Dynamics GP/EXP1493.DIC  
    :C: Microsoft Dynamics GP/EXP1493F.DIC  
    :C: Microsoft Dynamics GP/EXP1493R.DIC  
    \--------------------------------------------------

4. In this example, remove the product SmartList (1493) from the file. To remove the product Smartlist (1493) from the file, follow these steps:

    1. Change the number on the first line to 1 because you are removing a product from the list and one product remains. When you do this, Microsoft Dynamics GP knows that only one product will load. If you remove several products, count the items that you remove. This way, you can decrease the first number by the number of products that you remove. This number should show the number of products that remain.

    2. Delete the additional or third-party product ID. For example, delete 1493.

    3. Delete the additional or third-party product name. For example, delete SmartList.

    4. Remove the paths of the dictionaries that are loaded for this product. For example, in the file that is shown in step 3, delete the following lines:

       > :C: Microsoft Dynamics GP/EXP1493.DIC  
       :C: Microsoft Dynamics GP/EXP1493F.DIC  
       :C: Microsoft Dynamics GP/EXP1493R.DIC

        > [!NOTE]
        > Typically, the dictionary, reports, and forms dictionary paths have the same number as the product ID number. For example, 1493 relates to EXP1493.dic, EXP1493R.dic, and EXP1493F.dic. Look for the lines that have the same number as the product ID number in case you have lots of products to remove.

        For example, the changed Dynamics.set file resembles the following:

        > 1  
        0  
        Microsoft Dynamics GP  
        Windows  
        :C:Microsoft Dynamics GP/Dynamics.dic  
        :C:Microsoft Dynamics GP/Forms.dic  
        :C:Microsoft Dynamics GP/Reports.dic

When Microsoft Dynamics GP is started on the workstation on which the Dynamics.set file has been modified, the third-party product or the additional product does not start. Only Microsoft Dynamics GP starts. (There may be some add-ins for certain products that may not allow you to start Dynamics GP. In this case, use Method 3 below instead.)

If you want the third-party product or the additional product to start when Microsoft Dynamics GP starts, delete the modified Dynamics.set file, and then restore the original Dynamics.set file that you created in step 2.

> [!NOTE]
>
> - You should not remove Report Scheduler (product ID 3278) from the Dynamics.set file when you use Microsoft Dynamics GP 10.0, because it is needed to start the application. If the product is removed from the Dynamics.set file, you receive the following error message, and the application closes:  
> "Microsoft.Dynamics.GP.Sharepoint.dll:The type initializer for 'Microsoft.Dexterity.Applications.root'threw an exception.InnerException: Specified argument was out of the range of valid values.Parameter name:productId."
> - If you want to disable Manufacturing, make sure to do so in a test environment only. The exception is if you will not be using Manufacturing anymore.

## Method 2: Temporarily disable in the front-end in Customization Status

An alternative option to disable a third-party product or an additional GP product would be to use the Customization Status window. You can disable a specific third-party product or an additional GP product without users having to exit Microsoft Dynamics GP. To disable a third-party product or an additional GP product by using the Customization Status window, follow these steps:

1. Open the Customization Status window. To do this, follow these steps:

    In Microsoft Dynamics GP, on the Microsoft Dynamics GP menu, point to **Tools**, point to **Customize**, and then click **Customization Status**.

2. In the Customization Status window, highlight a specific product, and then click **Disable**.

> [!NOTE]
>
> - Disabling a product by taking it out of the Dynamics.set file is more effective as it prevents the specific product code from being initialized in the first place.
> - If the issue can no longer be recreated, it implies the product that was disabled is the one causing the issue. On the other hand, if the issue can still be recreated, the next step would be to disable the product completely by removing it from the Dynamics.set file. Please see steps 1 - 4 in the [Method 1: Remove from Dynamics.set file](#method-1-remove-from-dynamicsset-file) section.
> - Note that disabling it using this method is not always reliable for some products that are deeply embedded (ie, have triggers and add-ins), so may not be good enough for all products.  

## Method 3: create new vanilla Dynamics GP code folder for testing

This method works best because you are recreating the entire GP directory, which will rule out dictionary files and GP code itself, as well as removing third party products (and the add-ins folder for those) and customizations to get a better test. This creates a 'clean' GP instance from which you can add back third party products one by one, testing after each one until you find the issue.  You will need to use this method if your third party products have add-ins that prevent you from starting Dynamics GP.

1. Rename the existing GP code folder (usually located at C:\\Program Files (x86)\\Microsoft Dynamics\\GP - refer to [Method 1: Remove from Dynamics.set file](#method-1-remove-from-dynamicsset-file) to find the path)

2. Run a **Repair** on the GP installation via **Control Panel** > **Programs and Features**, which will re-deploy the code folder with no third Party products.

3. Launch GP from the new code folder you just created. Test the issue again. If the issue does not occur, you can try re-adding each third Party product back and test the issue after each to determine which product is causing the issue. (You can also revert back to the original folder to restore back to the original state, when finished testing.)
