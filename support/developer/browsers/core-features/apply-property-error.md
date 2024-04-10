---
title: Apply Property Error in Internet Explorer
description: Describes the error message that occurs when you modify either the Rating, Description, or Notes fields of a Favorite shortcut on Windows 7. Also provides the workaround to solve this issue.
ms.date: 03/23/2020
---
# Apply Property Error when modifying Ratings, Description or Notes of a Favorite shortcut

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the workaround to help you to solve the problem that an error message **Apply Property Error** occurs when you change the **Ratings**, **Description**, or **Notes** fields of a Favorite shortcut in Internet Explorer.

Microsoft has confirmed this to be a problem with Microsoft Windows 7 including Microsoft Windows 7 with Service Pack 1.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 2568750

## Symptoms

When you try to modify the **Rating**, **Description** and/or **Notes** fields from the **Details** tab of an Internet Explorer shortcut URL (for example, support.microsoft.com.url, which is located in the Favorites folder), an error message **Apply Property Error** appears when clicking **Apply** or **OK** (see the error message below):

> Apply Property Error
>
> An error occurred when writing the property 'Rating' to the file 'support.microsoft.com'.
>
> Support.microsoft.com  
> Description of the default settings for the MimeMap property and for the ScriptMaps property in IIS  
> [https://support.microsoft.com](https://support.microsoft.com/)?...

:::image type="content" source="media/apply-property-error/property-details-apply-property-error.png" alt-text="Screenshot of the support.microsoft.com Properties details and the apply property error.":::

Depending on the following setting(s) modified, the text of the **Apply Property Error** will change:

- Description
- Notes
- Rating

**For the Description setting**  
The text of the error message is:

> An error occurred when writing the property 'Description' to the file 'support.microsoft.com'.  
> Support.microsoft.com  
> [https://support.microsoft.com/](https://support.microsoft.com/) **?...**

:::image type="content" source="media/apply-property-error/error-writing-description.png" alt-text="Screenshot of the apply property error when changing Description property." border="false":::

**For the Notes setting**  
The text of the error message is:

> An error occurred when writing the property 'Notes' to the file 'support.microsoft.com'.  
> Support.microsoft.com  
> [https://support.microsoft.com/](https://support.microsoft.com/) **?...**

:::image type="content" source="media/apply-property-error/error-writing-notes.png" alt-text="Screenshot of the apply property error when changing Notes property." border="false":::

**For the Rating setting**  
The text of the error message is:

> An error occurred when writing the property 'Rating' to the file 'support.microsoft.com'.  
> Support.microsoft.com  
> [https://support.microsoft.com/?](https://support.microsoft.com/) **...**

:::image type="content" source="media/apply-property-error/error-writing-rating.png" alt-text="Screenshot of the apply property error when changing Rating property." border="false":::

## Resolution

The issue can be alleviated by manually editing the shortcut URL in a text editor such as notepad.exe. Simply copy and paste the desired setting (**Description**, **Notes**, and **Ratings**).

:::image type="content" source="media/apply-property-error/edit-url-in-notepad.png" alt-text="Screenshot of a notepad. The Description, Notes and Ratings fields are marked." border="false":::

**For the Description Field**  
[{5CBF2787-48CF-4208-B90E-EE5E5D420294}]  
Prop21=31,<<< Add Description Field Text Here >>>

For the **Description** and **Notes** Fields, the text will need to be manually edited. The **Description** field outlined in Indigo in the image above. To add description text, start to the right of the comma after Prop21=31 (replacing <<< Add Description Field Text Here >>> highlighted in Red in the image above with the desired text).

**For the Notes Field**  
[{B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}]  
Prop5=31,<<< Add Notes Field Text Here >>>

Likewise, the **Notes** Field outlined in Gree in the image above will also need to be manually edited. To add text to the **Notes** field, start to the right of the comma after Prop5=31 (replacing <<< Add Notes Field Text Here >>> highlighted in Red in the image above with the desired text).

**For Star Ratings**, all that is needed is to copy and paste the desired value, that is, **1 star**, **2 star**, **3 star**, **4 star**, and **5 star**.

> [!NOTE]
> A 5 star rating was copied in the sample image above.

1 Star:  
[{64440492-4C8B-11D1-8B70-080036B11A03}]  
Prop9=19,1

2 Star:  
[{64440492-4C8B-11D1-8B70-080036B11A03}]  
Prop9=19,25

3 Star:  
[{64440492-4C8B-11D1-8B70-080036B11A03}]  
Prop9=19,50

4 Star:  
[{64440492-4C8B-11D1-8B70-080036B11A03}]  
Prop9=19,75

5 Star:  
[{64440492-4C8B-11D1-8B70-080036B11A03}]  
Prop9=19,99

Example of support.microsoft.com.url:

|Field|Value|
|---|---|
|Description Field|Support.microsoft.com|
|Notes Filed|Support URLs|
|Star Rating|5 Stars|

[{000214A0-0000-0000-C000-000000000046}]  
Prop3=19,2  
[InternetShortcut]  
URL= [https://go.microsoft.com/fwlink/?LinkId=121315](https://go.microsoft.com/fwlink/?LinkId=121315)  
IDList=  
[MonitoredItem]  
FeedUrl= [https://go.microsoft.com/fwlink/?LinkId=121315](https://go.microsoft.com/fwlink/?LinkId=121315)  
IsLivePreview=true  
[{5CBF2787-48CF-4208-B90E-EE5E5D420294}]  
Prop21=31, support.microsoft.com  
[{B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}]  
Prop5=31, Support URLs  
[{64440492-4C8B-11D1-8B70-080036B11A03}]  
Prop9=19,99

**ORIGINAL FILE: support.microsoft.com.url**  
Without modifying Description, Notes, or Ratings.

:::image type="content" source="media/apply-property-error/original-file.png" alt-text="Screenshot of the original file and the Properties window where no Description, Notes or Rating.under the Details tab." border="false":::

**MODIFIED FILE (Description and Notes): support.microsoft.com.url**  
After manually modified with the description text **Add Text Here for Description Field** and the **Notes** Field **Add Text Here for Notes field** and 5 Star Rating.

:::image type="content" source="media/apply-property-error/modified-file.png" alt-text="Screenshot of the modified file and the Properties window with Description, Notes and Rating under the Details tab." border="false":::

## More information

Here is all the manual settings that are introduced above:

|Field|Value|
|---|---|
|Description Field|[{5CBF2787-48CF-4208-B90E-EE5E5D420294}]</br>Prop21=31,<<< Add Description Field Text Here >>>|
|Notes Field|[{B9B4B3FC-2B51-4A42-B5D8-324146AFCF25}]</br>Prop5=31,<<< AddNotes Field Text Here >>>|
|Star Ratings|1 Star:</br>[{64440492-4C8B-11D1-8B70-080036B11A03}]</br>Prop9=19,1</br>2 Star:</br>[{64440492-4C8B-11D1-8B70-080036B11A03}]</br>Prop9=19,25</br>3 Star:</br>[{64440492-4C8B-11D1-8B70-080036B11A03}]</br>Prop9=19,50</br>4 Star:</br>[{64440492-4C8B-11D1-8B70-080036B11A03}]</br>Prop9=19,75</br>5 Star:</br>[{64440492-4C8B-11D1-8B70-080036B11A03}]</br>Prop9=19,99|
  