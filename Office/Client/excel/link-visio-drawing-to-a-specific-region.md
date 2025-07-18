---
title: How to link a Visio drawing to a specific region in an Excel worksheet
description: Explains how to embed a link in a Visio drawing to a named region in an Excel worksheet. Introduces the concepts of linking and embedding.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Editing\Embedding
  - CSSTroubleshoot
appliesto: 
  - Microsoft Excel
ms.date: 05/26/2025
---

# How to link a Visio drawing to a specific region in an Excel worksheet

## Summary

This article describes how to embed a link in a Microsoft Office Visio drawing to a named region within a Microsoft Office Excel Worksheet.

## More Information

### About linking and embedding

Embed an object in your Visio drawing if you want to keep all the data that you want to work with in one file, or if you want to transfer the file to other computers. You can embed data from programs that support the OLE 2 standard.

For example, if you want to distribute Excel worksheet data along with a Visio diagram, you can embed an Excel worksheet into the drawing. 

When you embed data from another program, Visio becomes the container for that data. The object embedded in the Visio drawing becomes part of the Visio file and, when you edit the data, you open the object's program from within the Visio drawing.

In addition, you can link the embedded data to maintain a connection between the embedded objects from other programs and their original files. You can view the links and choose whether to update an object manually or automatically as you edit or update the linked file in its original program. You can also change the file reference for the linked object.

### Example

To embed and link a named portion of an Excel worksheet into a Visio drawing, follow these steps:

1. Open your worksheet in Microsoft Excel.
2. Select the range of cells that you want to link to.
3. On the **Formulas** menu, click **Define Name**.
4. In the **Define Name** dialog box, type a unique name, and then click **OK**.
5. Save the Microsoft Excel Workbook.
6. Start Microsoft Visio, and open your drawing.
7. On the **Insert** menu, click **Object**.
8. In the **Insert Object** dialog box, click **Create from file**, and then click **Browse**. Navigate to your Excel workbook, select it, and click **Open**.
9. Select the **Link to file** check box, and then click **OK**.

   > [!NOTE]
   > Selecting the **Link to file** check box establishes a dynamic connection between the Visio drawing and another program's file. When changes occur in the original file, you can update the linked file so that the most current version of the object appears in the linked file.

10. In the **Tell me what you want to do** box, type and click **Links**.
11. In the **Links** dialog box, select the link to the Excel worksheet, click **Automatic** under **Update**, and then click **Change Source**.
12. In the **Item Name** box, type the name defined in step 4, and then click **Open**.
13. Click **Update Now**, and then click **Close**.

Now, only the named area of the Excel worksheet is dynamically linked to the Visio drawing.

You can perform a similar process with a Microsoft Word document. In Word, you can use a unique bookmark name to identify a portion of a document.

## References

For more information about Visio, visit the following Microsoft Web site:

[https://www.microsoft.com/office/visio](https://www.microsoft.com/office/visio)
