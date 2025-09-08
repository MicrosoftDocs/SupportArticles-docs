---
title: Change telephone format by using Modifier with VB
description: This article provides steps in Modifier with Visual Basic for Applications that you can use to change the telephone format for SmartList and for Letter Writing Assistant.
ms.topic: how-to
ms.reviewer: theley, kvogel
ms.date: 04/17/2025
ms.custom: sap:Developer - Customization and Integration Tools
---
# Change the telephone format for SmartList and for Letter Writing Assistant in Microsoft Dynamics GP by using Modifier with Visual Basic for Applications

This article provides steps in Modifier with Visual Basic for Applications that you can use to change the telephone format for SmartList and for Letter Writing Assistant.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 921632

## Introduction

This article describes how to change the telephone format for SmartList and for Letter Writing Assistant in Microsoft Dynamics GP by using Modifier with Visual Basic for Applications.

## More information

If you want a free-form telephone number, use a format of 20 x characters, and change the fill to use spaces instead of removing the format. The Message resources require the x characters. Therefore, it is more consistent to set the format to x characters instead of removing the format entirely.

To change the telephone format for SmartList and for Letter Writing Assistant in Modifier with Visual Basic for Applications, follow these steps.

### Step 1: Make a change in the Formats window

1. On the **Tools** menu, click **Customize**, and then click **Modifier**.
2. In the **Product** list, click **Microsoft Dynamics GP**, and then click **OK**.
3. In the Microsoft Dynamics GP window, click **Resources**, and then click **Formats**.
4. In the Formats window, click **Phone_Number**, and then click **Open**.
5. In the **Format Strings** area, click the format.
6. Type the format that you want, or click **Remove** for a blank format. Then, click **OK**.
7. Close the Formats window.
8. Repeat step 1 through step 7. In step 4, click **Phone_Number3** instead of **Phone_Number**.

### Step 2: Make a change in the Messages window

#### Microsoft Dynamics GP 9.0 and Microsoft Dynamics GP 10.0

To change the telephone format for SmartList and for Letter Writing Assistant by using Modifier with Visual Basic for Applications, follow these steps:

1. In the Microsoft Dynamics GP window, click **Resources**, and then click **Messages**.
2. In the **Message ID** box, type *6055*, and then press **ENTER**.
3. In the **Message** box, type the telephone format that you want, and then click **Save**.
4. To exit Modifier with Visual Basic for Applications, click **File**, and then click **Microsoft Dynamics GP**.

#### Microsoft Business Solutions - Great Plains 8.0

To change the telephone format for SmartList by using Modifier with Visual Basic for Applications, follow these steps:

1. In the Microsoft Business Solutions-Great Plains window, click **Resources**, and then click **Messages**.
2. In the **Message ID** box, type *22043*, and then press **ENTER**.
3. In the **Message** box, type the telephone format that you want, and then click **Save**.
4. To exit Modifier with Visual Basic for Applications, click **File**, and then click **Microsoft Business Solutions-Great Plains**. To change the telephone format for Letter Writing Assistant by using Modifier with Visual Basic for Applications, follow these steps.

    > [!NOTE]
    > Microsoft Business Solutions - Great Plains 8.0 Service Pack 4 or a later service pack must be installed.

    1. In the Microsoft Business Solutions-Great Plains window, click **Resources**, and then click **Messages**.
    2. In the **Message ID** box, type *6055*, and then press **ENTER**.
    3. In the **Message** box, type the telephone format that you want, and then click **Save**.
    4. To exit Modifier with Visual Basic for Applications, click **File**, and then click **Microsoft Business Solutions-Great Plains**.
