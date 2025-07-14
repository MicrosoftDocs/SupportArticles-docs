---
title: Create An Excel Add-In to Calculate Body Mass Index (BMI)
description: This article describes how to create a custom function to calculate BMI (Body Mass Index), save Excel Add-In file, install the Add-In and uninstall the Add-In.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Extensibility\Macros
  - sap:office-experts
  - CSSTroubleshoot
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Microsoft Office Excel 2007
ms.date: 06/06/2024
---

# Create An Excel Add-In to Calculate Body Mass Index (BMI)

This article was written by [Raddini Rahayu](https://mvp.microsoft.com/en-US/mvp/raddini%20gusti%20rahayu-4038228), Microsoft MVP.

## Introduction

Excel Add-In is a file that contains code of VBA to adds additional Excel function that doesn't exist in Excel function by default. This file is saved in .xlam format and always loaded when Excel starts up. The additional or custom Excel function can also be called a UDF (User-Defined Function) that is a custom function that is created by user.

In using Add-In, at first you must install it on your computer then it will always be used for all workbook. In this article, you will be shown how to create custom function in the Add-In using VBA code, save file that contains Add-In, install the Add-In, using custom function from Add-In and uninstall the Add-In.

## Case

In this case below, I will share about how to create a custom function to calculate BMI (Body Mass Index).

Body Mass Index is a simple index of weight and height that is commonly used to classify underweight, overweight, and obesity in adults. BMI values ​​are age-independent and same for both sexes. The classifications of BMI are shown in the following table:

:::image type="content" source="media/create-add-in-to-calculate-bmi/classifications-of-bmi.png" alt-text="Diagram showing the classifications of Body Mass Index." border="false":::

The BMI scale used here is only suitable for adults aged 20-65 and here is the calculation:
:::image type="content" source="media/create-add-in-to-calculate-bmi/calculation-of-bmi.png" alt-text="Diagram showing the calculation of Body Mass Index." border="false":::

## What To Do

### Step 1: Coding VBA Code

1. Open Microsoft Excel, then press Alt+F11on keyboard, so VBE (Visual Basic Editor) window is displayed.

2. Open a module by selecting Module on Insert menu and write this script:

    ```vb
    Function BMI(weight, height) BMI = weight / (height / 100) ^ 2 End Function
    ```

    :::image type="content" source="media/create-add-in-to-calculate-bmi/write-script.png" alt-text="Screenshot shows steps to write the script in the Visual Basic Editor window." border="false":::

3. Close the VBE window and back to Excel. Then save the file with click on Save button or press CTRL+S on your keyboard, so the Save as dialog box is displayed.

### Step 2: Save The Excel Workbook

1. Fill the name that you want named to at the File Name box. Here I name it BMI Calculation.

2. For the file type, choose Excel Add-In (.xlam) format. Then close the workbook.

    :::image type="content" source="media/create-add-in-to-calculate-bmi/select-xlam-format.png" alt-text="Screenshot to fill the name and select the file format." border="false":::

    > [!NOTE]
    > You can save your Add-In file anywhere you want. But if you want it to be listed on Excel bulit-in, you should save it into the default location. On my computer with Windows 7 operating system, the default location for any versions of Microsoft Excel is:
    C:\Users\RADDINI\AppData\Roaming\Microsoft\AddIns

Until this step, we have finished creating a custom function that is saved in Excel Add-In file. Next we need to install it and then we can use the Add-In.

### Step 3: Install The Add-In

1. Open Microsoft Excel and select Options by clicking File tab, so Excel Options dialog box is displayed.

2. In the Excel Options dialog box, click on Add-Ins tab. Find the Manage option below, choose Excel Add-Ins then click Go.

3. Also, you can display the Add-Ins dialog box by click on Developer tab then click Add-Ins.

4. On the Add-Ins dialog box, find the Add-In that we want installed to (in this case is BMI calculation), make sure the BMI calculation checkbox is unchecked. Then click OK.

    :::image type="content" source="media/create-add-in-to-calculate-bmi/uncheck-bmi-calculation.png" alt-text="Screenshot shows steps to uncheck the B M I calculation option in the Excel Options dialog box.":::

    :::image type="content" source="media/create-add-in-to-calculate-bmi/uncheck-bmi-calculation-in-developer-tab.png" alt-text="Screenshot shows steps to uncheck the B M I calculation option in the Developer tab.":::

    > [!NOTE]
    > This step is applied to the file which is saved in default Add-Ins location. If you want to installing Add-In that is saved in another location, you should click on Browse button in the Add-Ins dialog box. When Browse dialog box is displayed, go to the file location, choose the Add-In file and then click Open.

Now, BMI calculation custom function has installed and ready to use.

### Step 4: Use The Function

Now, we can use the custom function that we have created. To testing this BMI function, write on the cell B1: =BMI(55,170), then Press Enter. If the Result is 19.03, it means our custom function is working well. Also you can try calculate your BMI then find out your BMI classification by looking at BMI Classification table.

:::image type="content" source="media/create-add-in-to-calculate-bmi/use-the-function.png" alt-text="Screenshot to use the custom B M I function in Excel.":::

### Step 5: Uninstall The Add-In

However, every Add-In that has installed on Excel, will always running when Excel gets started. Excel load time may takes longer than Excel without Add-In. If you don't need that Add-In anymore, you can uninstall one or more of them. The steps are almost same as installing Add-In, please following this step:

1. Open Add-Ins dialog box by clicking Add-Ins on the Developer tab.

2. Choose the Add-In that you want uninstalled to, then uncheck its checkbox.

3. Click OK and Restart your Excel.

:::image type="content" source="media/create-add-in-to-calculate-bmi/uninstall-add-in.png" alt-text="Screenshot shows steps to uninstall the Add-Ins.":::

[!INCLUDE [Community Solutions Content Disclaimer](../../../includes/community-solution-content-disclaimer.md)]
