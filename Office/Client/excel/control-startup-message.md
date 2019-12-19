---
title: Control the startup message about updating linked workbooks
description: Discusses how to control the startup message that is prompted for updating linked workbooks in Excel 2002 and in later versions of Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: v-raddis
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Microsoft Office Excel 2003
- Microsoft Office Excel 2007
- Excel 2010
---

# How to control the startup message about updating linked workbooks in Excel

## Summary

This step-by-step article describes how to control the startup message about updating linked workbooks in Microsoft Office Excel.

When you open a workbook that contains links to cells in other workbooks, you may receive the following message: This workbook contains links to other data sources. If you update the links, Excel attempts to retrieve the latest data. If you don't update, Excel uses the previous information. You can click either **Update** or **Don't Update**.

By default, Excel displays this message. You can control if it appears, and if Excel updates the links manually or automatically. To make these changes, use the following methods.

**Notes**

Regardless of the options that you choose, Excel still displays a message if the workbook contains links that are not valid or links that are broken.

To find information about the links in a workbook in Microsoft Excel 2002 or in Microsoft Office Excel 2003, click **Links** on the **Edit** menu.

To find information about the links in a workbook in Microsoft Office Excel 2007/2010, click **Edit Links** in the **Connections** group on the **Data** tab.

Additionally, the following options apply only when the workbook that contains the basic data is closed. If the workbook with the basic data is already open when you open the workbook that contains the links, the links are updated. 

### Automatic update and no message
 
To suppress the message and to automatically update the links when you open a workbook in Excel 2002 or in Excel 2003, follow these steps: 
 
1. On the **Tools** menu, click **Options**, and then click the **Edit** tab.  
2. Click to clear the **Ask to update automatic links** check box.    
 
To suppress the message and to automatically update the links when you open a workbook in Excel 2007, follow these steps: 
 
1. Click **Microsoft Office Button**, and then click **Excel Options**.    
2. Click **Advanced**.    
3. Under **General**, click to clear the **Ask to update automatic links** check box.    
 
**Notes**

When the **Ask to update automatic links** check box is cleared, the links are automatically updated. Additionally, no message appears.

This option applies to the current user only and affects every workbook that the current user opens. Other users of the same workbooks are not affected.
 
### Manual update and no message

If you are sharing this workbook with other people who will not have access to the sources of the updated links, you can turn off updating and the prompt for updating. To suppress the message and leave the links (not updated) until you choose to update them, follow these steps: 
 
1. On **Edit** menu, click **Links**.

   **Note** In Excel 2007/2010, click **Edit Links** in the **Connections** group on the **Data** tab.    
2. Click **Startup Prompt**.    
3. Click the **Don't display the alert and don't update automatic links** option.    
 
   > [!WARNING]
   > If you choose not to update the links and not to receive the message, users of the workbook will not know that the data is out of date. This choice affects all users of the workbook. However, this choice applies only to that particular workbook.

To update the links manually, follow these steps: 
 
1. On **Edit** menu, click **Links**.

   **Note** In Excel 2007/2010, click **Edit Links** in the **Connections** group on the **Data** tab.    
2. Click **Update Values**.    
3. Click **Close**.    
 
### Do not display the alert and update links
 
If you select the option **Don't display the alert and update links** on a workbook, this choice affects all users of the workbook. However, this choice applies only to that particular workbook. If the person who opens the workbook has the **Ask to update automatic links** check box selected, the message appears. The users who set in the options page override the workbook setting. 

### Let users choose to display links
 
If you select the option **Don't display the alert and update links** on a workbook, this choice is ignored. If the person who opens the workbook has the **Ask to update automatic links** check box selected, the message appears. Otherwise, the links are updated automatically. 
