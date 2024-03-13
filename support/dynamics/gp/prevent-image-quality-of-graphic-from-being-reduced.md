---
title: Prevent image quality of a graphic from being reduced
description: How to prevent the image quality of a graphic from being reduced when you print a graphic from Report Writer in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to prevent the image quality of a graphic from being reduced when you print a graphic from Report Writer in Microsoft Dynamics GP

This article describes how to prevent the image quality of a graphic from being reduced when you print a graphic from Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 854470

## Summary

The imaging model that is used to capture graphics in Report Writer in Microsoft Dynamics GP is based on the number of dots per inch (DPI). The DPI is equal to the number of pixels per inch.  

By default, when a graphic is pasted into the Layout area in Report Writer, the graphic is pasted by using the size 72 DPI. This size is also used to print a graphic from Report Writer. Therefore, when Report Writer prints a graphic, the pixels per inch that are in the Report Writer Layout area do not represent the pixels per inch of the original graphic. Typically, the original graphic has a larger DPI.

When a graphic is printed from Report Writer, pixels must be added to make up the difference between the DPI of the graphic and the DPI of the printer. The difference in DPI is calculated automatically in Microsoft Windows. Windows adds pixels to keep the original image intact. However, when pixels are added, the image quality of the graphic is reduced.

For example, you paste a logo into the Layout area in Report Writer that contains 144 pixels. Because graphics are pasted into the Layout area by using 72 pixels per inch, the logo is pasted in a rectangle that is two inches by two inches. The printer that you print to is a laser printer that prints 300 DPI. The logo has only 144 pixels. But, because the printer uses 300 DPI, the two inch by two inch logo is printed by using 600 pixels. Windows creates the additional pixels. However, the image quality is reduced in the process.

## Prevent the image quality of a graphic from being reduced

To prevent the image quality of a graphic from being reduced when you print a graphic from Report Writer, follow these steps:

1. Paste the graphic in the Layout window. Do not modify the size of the graphic.
2. Determine the DPI of the printer. To do this, click **Start**, point to **Control** **Panel**, point to **Printers** **and** **Faxes**, right-click the printer, and then click **Properties**. On the **General** tab, note the value in the **Maximum** **resolution** field.
3. Determine the current size of the graphic. To do this, follow these steps:
    1. Start Microsoft Paint. To do this, click **Start**, point to **All** **Programs**, point to **Accessories**, and then click **Paint**.
    2. On the **Image** menu, click **Attributes**.
    3. In the **Units** area, verify that the **Pixels** option is selected.
    4. In the **Width** box, enter **200**, and then in the **Height** box, enter **200**.
    5. Click **OK**.

        This will cause the white area in the layout to be much smaller.
    6. Paste your graphic in this white area.
    7. Reduce the white area to fit your graphic by using the **Resize** boxes.
    8. On the **File** menu, click **Save**.
    9. In the **File** **Name** box, enter a name for the graphic, and then click **Save**. Note where the graphic is saved.
    10. In Windows Explorer, locate the directory where you saved the graphic.
    11. Right-click the graphic file that you just saved, and then click **Properties**.
    12. Click the **General** tab, and note the size of the graphic.

4. Determine the reduced size of the logo. To do this, use the following formula:

    (width of graphic * (72/dpi of printer)) = value of reduced width

    (height of graphic * (72/dpi of printer)) = value of reduced height

    For example, the reduced size of the logo that has the size (400, 500) and will be printed on a printer that uses 300 DPI is calculated as follows:

    (400 * (72/300)) = 96  

    (500 * (72/300)) = 120

5. On the **Layout** menu, click to clear the **Grid** check box.

6. In the Layout window, drag one of the corners of the graphic to resize the graphic to the size that you determined in step 4. In the example, the logo graphic is resized to (96,120).

The graphic is now the correct size so that it will print clearly. Be aware that the graphic does not display clearly in the Layout window.

> [!NOTE]
> You must exactly calculate the size of the resized image. For example, if you miscalculate by only two pixels, the image will be distorted when it is printed.

If you want the graphic to print larger, multiply the reduced width and height values by the percentage that you want to increase the graphic. For example, to increase the size of the logo by 30%, use the following formula:

96*1.30 = 124

120*1.30 = 156

The new size of (124,156) will print a larger graphic that has the same quality as the smaller graphic.
