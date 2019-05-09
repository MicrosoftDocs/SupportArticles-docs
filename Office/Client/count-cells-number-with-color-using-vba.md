---
title: Count The Number of Cells With Specific Cell Color By Using VBA
description: Create User Defined Function (UDF) to count the number of cells with spesific cell color and pack it into Add-In file, so the UDF can be used in every workbook and other computer.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# Count The Number of Cells With Specific Cell Color By Using VBA

## Symptoms 

On the Microsoft Excel Formula, we know that in Statisticalcategory there is a function to counts the number of cells within a range that meet the give condition, called COUNTIF. Criteria on that function can be formatted as text or number. But in fact, it could be not only text or number, but also cell colors. Then, how we can get the results with that criteria while COUNTIFfunction can not be the solutions.

![COUNTIF](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033122_en_1) 

## Resolution 

Altough without using COUNTIFfunction, we can still get the results with using VBA. With VBA, we can create a UDF (User Defined Function)and save it into Add-Infile so it can be used to every workbook and other computer.

## What To Do 

Here the steps to create the count cell color UDF:

1. Open Microsoft Excelthen press Alt+F11to show Visual Basic Editorwindow.    
2. On Insertmenu, select Module to create a module. Then write the following script:   

    ```vb
    Function CountCcolor(range_data As range, criteria As range) As Long     Dim datax As range     Dim xcolor As Long xcolor = criteria.Interior.ColorIndex For Each datax In range_data     If datax.Interior.ColorIndex = xcolor Then         CountCcolor = CountCcolor + 1     End If Next datax End Function
    ```
   ![On Insert menu, select Module to create a module. Then write the following script](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033124_en_1)    
3. Close VBE window and back to Excel.    
4. To test the UDF, create some example data.    
5. At cell D3, write the function: =CountCcolor(range_data,criteria)
 in range_data argumen, select cell C2 to C51
 in criteria argumen, select cell F1
  ![At cell D3, write the function: =CountCcolor](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033125_en_1)

6. Press Enter and in cell F2 the result is 6. It means the number of cells with Blue cell color is 6 cells.

   ![Press Enter and in cell F2 the result is 6. It means the number of cells with Blue cell color is 6 cells](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033126_en_1)    
7. You can also test another color. Change the color in cell F1 with any color you want from the data by using Format Painterto get same color.

   ![You can also test another color. Change the color in cell F1 with any color you want from the data by using Format Painter to get same color](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4033127_en_1)    
8. You can also pack the UDF, so that function can be used in another workbook and machine. Please following this steps:

   **Step 1: Save The Workbook**

   1. Fill the name that you want named to at the File Namebox. Here I name it Count Cell Color.    
   2. For the file type, choose Excel Add-In (.xlam)format.

    > [!NOTE]
    > You can save your Add-In file anywhere you want. But if you want it to be listed on Excel built-in, you should save it into the default location. On my computer with Windows 7 operating system, the default location for any versions of Microsoft Excel is: C:\Users\RADDINI\AppData\Roaming\Microsoft\AddIns    
 
    **Step 2: Install the Add-In**

   1. Open Microsoft Excelon computer that you want install the Add-In. Open Add-Insdialog box by clicking Add-In on the Developer tab.    
   2. On the Add-Indialog box, click Browse button so Browse dialog box is displayed.
   ![On the Add-In dialog box, click Browse button so Browse dialog box is displayed.](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4041376_en_1)

   3. Go to file location that Add-In file is saved. Choose the file and then click Open.    
   4. On the Add-Insdialog box make sure the add-in checkbox is unchecked. Then click OK.
   ![On the Add-Ins dialog box make sure the add-in checkbox is unchecked. Then click OK](https://msegceporticoprodassets.blob.core.windows.net/asset-blobs/4041377_en_1)


Now the Count Cell Color UDF has installed and ready to use.  

### Community Solutions Content Disclaimer

MICROSOFT CORPORATION AND/OR ITS RESPECTIVE SUPPLIERS MAKE NO REPRESENTATIONS ABOUT THE SUITABILITY, RELIABILITY, OR ACCURACY OF THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN. ALL SUCH INFORMATION AND RELATED GRAPHICS ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND. MICROSOFT AND/OR ITS RESPECTIVE SUPPLIERS HEREBY DISCLAIM ALL WARRANTIES AND CONDITIONS WITH REGARD TO THIS INFORMATION AND RELATED GRAPHICS, INCLUDING ALL IMPLIED WARRANTIES AND CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, WORKMANLIKE EFFORT, TITLE AND NON-INFRINGEMENT. YOU SPECIFICALLY AGREE THAT IN NO EVENT SHALL MICROSOFT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY DIRECT, INDIRECT, PUNITIVE, INCIDENTAL, SPECIAL, CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF USE, DATA OR PROFITS, ARISING OUT OF OR IN ANY WAY CONNECTED WITH THE USE OF OR INABILITY TO USE THE INFORMATION AND RELATED GRAPHICS CONTAINED HEREIN, WHETHER BASED ON CONTRACT, TORT, NEGLIGENCE, STRICT LIABILITY OR OTHERWISE, EVEN IF MICROSOFT OR ANY OF ITS SUPPLIERS HAS BEEN ADVISED OF THE POSSIBILITY OF DAMAGES.