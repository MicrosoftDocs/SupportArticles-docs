---
title: A picture or an object may not appear in a Word 2010 or Word 2007 document
description: Describes how to troubleshoot a problem in which pictures or objects are not visible in documents. This problem occurs on the screen and in printed documents.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto:
- Word 2010
---

# A picture or an object may not appear in a Word 2010 or Word 2007 document

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

When you open a Microsoft Office Word 2010 or Word 2007 document that contains a picture or an object, the picture or the object may not appear. This problem may occur in a document that contains a picture, a graphic image, an AutoShape object, or another object.

> [!NOTE]
> Newer versions of Microsoft Office Word could potentially exhibit the same symptoms.

## Cause

This problem occurs if you are using a Wrapping style option other than the **In line with text** option with the picture or with the object. And, one of the following conditions is true:

- You are viewing the Word document in Draft view or in Outline view.   
- The **Show drawings and text boxes on screen** option is turned off.   
- The **Print drawings created in Word** option turned off.   
- The **Use draft quality** option is turned on.   
If you are using the **In line with text** option with the picture or with the object, this problem may occur if the **Picture Placeholders** option is turned on. 

This problem may also occur if you are experiencing a problem with the video driver.

## Workaround

### You are using a Wrapping style option other than the "In line with text" option

If you are using a Wrapping style option other than the **In line with text** option, use one of the following workarounds.

#### Use the "In line with text" Wrapping style option

To change the Wrapping style option for a picture or for an object to **In line with text**, follow these steps, as appropriate for your version of Word.

##### Word 2007

1. Click the picture or the object.   
2. On the **Format** tab, click **Text Wrapping** in the **Arrange** group.   
3. Click **In line with text**.   

##### Word 2010

1. Click the picture or the object.   
2. On the **Format** tab, click **Text Wrapping** in the **Arrange** group.   
3. Click **In line with text**.   
When you use the **In line with text** option, the picture or the object will be displayed in any view. 

If you want to use a Wrapping style option other than the **In line with text** option, use one of the following workarounds.

#### Change the view
This problem may occur if you are viewing the document in Draft view or in Outline view. To work around this problem, view the document in one of the following views:

- Print Layout   
- Full Screen Reading   
- Web Layout   
- Print Preview for Word 2007. For 

Word 2010: Click **File**, and then click **Print**.   
Word 2010 and Word 2007 documents consist of separate text and drawing layers. When you use a Wrapping style option other than the **In line with text** option with a picture or with an object, the picture or the object is inserted into the drawing layer. Word 2010 and Word 2007 do not display the drawing layer when you view the document in Draft view or in Outline view. The drawing layer is displayed in a Word 2010 and in a Word 2007 document when you use any one of the views that are mentioned in this workaround.

#### Turn on the "Show drawings and text boxes on screen" option

When you turn on the **Show drawings and text boxes on screen** option, you can view the picture or the object in Print Layout view or in Web Layout view. To turn on the **Show drawings and text boxes on screen** option, follow these steps, as appropriate for your version of Word.

##### Word 2007

1. Click the **Microsoft Office Button**, and then click **Word Options**.   
2. Click **Advanced**.   
3. Under **Show document content**, click to select the **Show drawings and text boxes on screen** check box.   
4. Click **OK**.   

##### Word 2010

1. Click **File**, and then click **Options**.   
2. Click **Advanced**.   
3. Under **Show document content**, click to select the **Show drawings and text boxes on screen** check box. 
4. Click **OK**.   

#### Turn on the "Print drawings created in Word" option

When you turn on the **Print drawings created in Word** option, you can view the picture or the object in Print Preview. And, you can print the picture or the object. To turn on the **Print drawings created in Word** option, follow these steps, as appropriate for your version of Word.

##### Word 2007

1. Click the **Microsoft Office Button**, and then click **Word Options**.   
2. Click **Display**.   
3. Under **Printing options**, click to select the **Print drawings created in Word** check box.   
4. Click **OK**.   

##### Word 2010

1. Click **File**, and then click **Options**.   
2. Click **Display**.   
3. Under **Printing options**, click to select the **Print drawings created in Word ** check box.   
4. Click **OK**.   

#### Turn off the "Use draft quality" option

When you turn off the **Use draft quality** option, you can view the picture or the object in Print Preview. And, you can print the picture or the object. To turn off the **Use draft quality** option, follow these steps, as appropriate for your version of Word.

##### Word 2007

1. Click the **Microsoft Office Button**, and then click **Word Options**.   
2. Click **Advanced**.   
3. Under **Print**, click to clear the **Use draft quality** check box.   
4. Click **OK**.   

##### Word 2010

1. Click **File**, and then click **Options**.   
2. Click **Advanced**.   
3. Under **Print**, click to clear the **Use draft quality** check box.
4. Click **OK**.   

### You are using the "In line with text" Wrapping style option

#### Turn off the "Picture Placeholders" option

When you turn off the **Picture Placeholders** option, you can view the picture or the object in all views. To turn off the **Picture Placeholders** option, follow these steps, as appropriate for your version of Word.

##### Word 2007

1. Click the **Microsoft Office Button**, and then click **Word Options**.   
2. Click **Advanced**.   
3. Under **Display document content**, click to clear the **Picture Placeholders** check box.   
4. Click **OK**.   

##### Word 2010

1. Click **File**, and then click **Options**.   
2. Click **Advanced**.   
3. Under **Show document content**, click to clear the **Show Picture Placeholders** check box.   
4. Click **OK**.   

> [!NOTE]
> The **Picture Placeholders** option does not affect pictures or objects when you use a Wrapping style option other than the **In line with text** option. The **Picture Placeholders** option affects pictures and objects when you use the **In line with text** option in all views except the Full Screen Reading view.

### You are experiencing problems with the video driver

If you experience this problem frequently, you may have a problem with the video driver settings or with the Windows Display Properties settings. If the previous workarounds do not resolve the problem, try the following workarounds.

#### Change the Color quality setting or the screen resolution of the current video driver

To change the color quality setting, follow these steps, as appropriate for your situation.

##### Windows XP

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**.
2. Click the **Settings** tab.
3. If the **Color quality** setting is set to **Highest (32 bit)**, change this setting to **Medium (16 bit)**, and then click **OK**.   

If you are still experiencing the problem, change the screen resolution. To do this, follow these steps:

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**.
2. Click the **Settings** tab.
3. Under **Screen resolution**, move the slider to the left, and then click **OK**.   

##### Windows Vista


1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**.
2. If the **Colors** setting is set to **Highest (32 bit)**, change this setting to **Medium (16 bit)**, and then click **OK**.   

If you are still experiencing the problem, change the screen resolution. To do this, follow these steps:

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**.
2. Under **Resolution**, move the slider to the left, and then click **OK**.   

##### Windows 7

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**.
2. Click the **Advanced Settings** tab.
3. Click **Monitor**.   
4. If **Colors** is set to **Highest (32 bit)**, change this setting to **Medium (16 bit)**, and then click **OK**.   

If you are still experiencing the problem, change the screen resolution. To do this, follow these steps:

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**.
2. Under **Resolution**, click the arrow and try another resolution, and then click **OK**.   

#### Change the hardware acceleration setting

##### Windows XP

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**. 
2. On the **Settings** tab, click **Advanced**.   
3. Click the **Troubleshoot** tab.   
4. Move the slider to the left to reduce the hardware acceleration, and then click **OK** two times.   
5. When you are asked if you want to restart the computer, click **Yes**.  

##### Windows Vista and Windows 7

1. Click **Start**, click **Run**, type desk.cpl, and then click **OK**. 
2. Click **Advanced Settings**.   
3. Click the **Troubleshoot**.   
4. If your display driver allows changes, click **Change Settings**. Move the slider to the left to reduce the hardware acceleration, and then click **OK** two times.   
5. When you are asked if you want to restart the computer, click **Yes**.   
#### Obtain an updated video card

If the workarounds that are described in this section help resolve this problem, contact your computer manufacturer for updated video drivers. If you have already upgraded your video card, contact the video card's manufacturer.
