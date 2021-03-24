---
title: Register or unregister ActiveX controls
description: Describes two methods to register or to unregister ActiveX controls in Access 2007.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
- CI 111294
- CSSTroubleshoot
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: acc12b
appliesto:
- Access 2007
---

# How to register or unregister ActiveX controls in Access 2007

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

This article applies to a Microsoft Access database (.mdb), a Microsoft Access project (.adp), and a Microsoft Access 2007 database (.accdb).

Moderate: Requires basic macro, coding, and interoperability skills.

## Introduction 

This article describes how to register or unregister an ActiveX control in Microsoft Office Access 2007.

## More information

In earlier versions of Access than Access 2007, you could register or unregister an ActiveX control by clicking **ActiveX Controls** on the **Tools** menu. In Access 2007, you cannot use this method. If you want to register or unregister an ActiveX control, use one of the following methods.

### Method 1: Use Visual Basic code

To use Visual Basic code to register or unregister an ActiveX control, run the code directly in the Immediate window, or create a module that contains the code. 

To run the Visual Basic code directly in the Immediate window, follow these steps:

1. In Access 2007, open a trusted database, or enable macros in the database.  
2. Press CTRL+G to open the Immediate window.   
3. Type the following code, and then press ENTER. 
    ```vb
    DoCmd.RunCommand acCmdRegisterActiveXControls
    ```

To create a module that contains the Visual Basic code, follow these steps:

1. In Access 2007, open a trusted database, or enable macros in the database.  
2. On the **Create** tab, click **Macro** in the **Other** group, and then click **Module**.   
3. Create a subroutine that includes the following Visual Basic code.
    ```vb
    DoCmd.RunCommand acCmdRegisterActiveXControls
    ```
4. Press F5 to run the code.   

### Method 2: Use the RunCommand macro action

1. In Access 2007, open a trusted database, or enable macros in the database.  
2. On the **Create** tab, click **Macro** in the **Other** group, and then click **Macro**.   
3. On the **Design** tab, click **Show All Actions** in the **Show/Hide** group.   
4. In the **Action** column, click **RunCommand**, and then click **RegisterActiveXControls** in the **Command** list.   
5. Click **Save**.   
6. In the **Tools** group, click **Run**.   
