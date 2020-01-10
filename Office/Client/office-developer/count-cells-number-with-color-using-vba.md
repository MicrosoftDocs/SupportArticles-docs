---
title: Count The Number of Cells With Specific Cell Color By Using VBA
description: Create User Defined Function (UDF) to count the number of cells with spesific cell color and pack it into Add-In file, so the UDF can be used in every workbook and other computer.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Excel for Office 365
- Excel 2019
- Excel 2016
- Excel 2013
- Excel 2010
- Microsoft Office Excel 2007
- Microsoft Office Excel 2003
---

# Count the number of cells with a specific cell color using VBA

## Summary 

On the Microsoft Excel **Formulas** tab, we know that in the **More Functions** > **Statistical** category there is a function called COUNTIF which counts the number of cells within a range that meet a given condition. Criteria for that function are limited to text or numbers. However, using VBA we can create a function to count the number of cells with other criteria, such as cell color.

![COUNTIF](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033122_en_1) 

## More information 

Using VBA, a User Defined Function (UDF) can be created and saved into an add-in file so that it can be used in other workbooks and transferred to other computers.

## How to create a UDF

Here are the steps to create a UDF to count cell color:

1. Open Microsoft Excel, then press Alt+F11 to show the Visual Basic Editor (VBE) window.    
2. On the **Insert** menu, select **Module** to create a module. Then type the following script:   

    ```vb
    Function CountCcolor(range_data As range, criteria As range) As Long     Dim datax As range     Dim xcolor As Long xcolor = criteria.Interior.ColorIndex For Each datax In range_data     If datax.Interior.ColorIndex = xcolor Then         CountCcolor = CountCcolor + 1     End If Next datax End Function
    ```
   ![On Insert menu, select Module to create a module. Then write the following script](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033124_en_1)    
3. Close the VBE window to return to Excel.    
4. In order to test the UDF, create example data that contains a column of cells in various colors.    
5. In cell D3, write the function: 

```
=CountCcolor(range_data,criteria)
```

* In the "range_data" argument, select cell C2 to C51.
* In the "criteria" argument, select cell F1.


  ![At cell D3, write the function: =CountCcolor](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033125_en_1)

6. Press **Enter**. The result in cell F2 is 6. This means the number of cells shaded in blue is 6.

   ![Press Enter and in cell F2 the result is 6. It means the number of cells with Blue cell color is 6 cells](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033126_en_1)    
7. You can test by using other colors. Change the color in cell F1 with any color you want from the data by using **Home** > **Fill Color**.

   ![You can also test another color. Change the color in cell F1 with any color you want from the data by using Format Painter to get same color](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033127_en_1)    
8. You can also zip the UDF so that the function can be used in another workbook or on another computer. To do so, follow these steps:

   **Step 1: Save The Workbook**

    a. Select **File**, and then **Save as**. (Select **Browse** if needed.)

    b. Select **Excel Add-In (.xlam)** as the format and give the file a name, such as CountCcolor.

    > [!NOTE]
    > You can save your Add-In file anywhere you want. But in order for it to be listed as an Add-In within your Excel program, save it to the default location. In Windows 7 the default location for any version of Microsoft Excel is: C:\Users\RADDINI\AppData\Roaming\Microsoft\AddIns
 
    **Step 2: Install the Add-In**

     a. Open Microsoft Excel on the computer where you want to install the Add-In.

    b. Open the Add-Ins dialog box by selecting **Excel Add-Ins** for Excel 2013 and later on the **Developer** tab. (**Add-Ins** on Excel 2010.)

    c. In the **Add-Ins** dialog box, select **Browse**.
   ![On the Add-In dialog box, click Browse button so Browse dialog box is displayed.](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4041376_en_1)

   d. Go to the file location where the Add-In file is saved (such as a USB drive or a cloud-based folder). Choose the file and then select **Open**.

   e. On the Add-Ins dialog box, make sure the add-in checkbox is unchecked. Then select **OK**.
   ![On the Add-Ins dialog box make sure the add-in checkbox is unchecked. Then select OK.](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4041377_en_1)


The Count Cell Color UDF is installed and ready to use. You will be able to access this function anytime by placing your cursor into any cell in the worksheet and typing:

```
=CountCcolor(range_data,criteria)
```

### Community Solutions Content Disclaimer

MICROSOFT CORPORATION AND/OR ITS RESPECTIVE SUPPLIERS MAKE NO REPRESENTATIONS ABOUT THE SUITABILITY, RELIABILITY, OR ACCURACY OF THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN. ALL SUCH INFORMATION AND RELATED GRAPHICS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND. MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH REGARD TO THIS INFORMATION AND RELATED GRAPHICS, INCLUDING ALL IMPLIED WARRANTIES AND CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, WORKMANLIKE EFFORT, TITLE AND NON-INFRINGEMENT. YOU SPECIFICALLY AGREE THAT IN NO EVENT SHALL MICROSOFT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL, CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF USE, DATA OR PROFITS, ARISING OUT OF OR IN ANY WAY CONNECTED WITH THE USE OF OR INABILITY TO USE THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE, EVEN IF MICROSOFT OR ANY OF ITS SUPPLIERS HAS BEEN ADVISED OF THE POSSIBILITY OF DAMAGES.