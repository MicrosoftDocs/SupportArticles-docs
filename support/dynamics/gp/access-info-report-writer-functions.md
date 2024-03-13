---
title: Access info about Report Writer functions
description: Describe how to access information about Report Writer functions that can be used to customize Report Writer. The information is available in the Microsoft Dynamics GP SDK.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# How to access information about Report Writer functions in the Microsoft Dynamics GP SDK

This article describes how to access information about Report Writer functions that can be added to Report Writer in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 928172

## Introduction

Report Writer functions are Dexterity functions that were created to do functions that aren't typically available in Report Writer. These functions can be added to reports by using a Calculated field as a user-defined function. For more information about these functions, see the Report Writer Programmer's Interface document in the Microsoft Dynamics GP Software Development Kit (SDK). To do it, follow the appropriate steps.

## Microsoft Dynamics GP 9.0

1. Install the SDK.
2. Select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, and then select **GP & SBF SDK**.
3. In the left Navigation Pane, double-click **Microsoft Dynamics GP SDK**, double-click **Procedures and functions**, double-click **The Foundation Series**, and then select **Report Writer (RW) Programmer's Interface**.

## Microsoft Business Solutions - Great Plains 8.0

1. Install the SDK.
2. Select **Start**, point to **All Programs**, point to **Microsoft Business Solutions**, point to **Great Plains & SBM SDK**, and then select **Release 8.0 Developer Resources**.
3. In the left Navigation Pane, expand **Great Plains**, and then select **Procedures and Functions**.
4. In the right Navigation Pane, select **Report Writer (RW) Programmer's Interface** in the **System Manager** area.

## More information

You can also access the parameter list for these Report Writer functions in the Report Writer Programmer's Interface document. To do it, follow the appropriate steps.

### Dynamics GP 9.0

1. Select **Start**, point to **All Programs**, point to **Microsoft Dynamics**, and then select **GP & SBF SDK**.
2. In the left Navigation Pane, double-click **Microsoft Dynamics GP SDK**, double-click **Parameters for Microsoft Dynamics GP**, double-click **Parameters for Release 9.0**, and then select **Main Dictionary Parameters**.
3. Open the parameter list in Notepad, and then select **Find** on the **Edit** menu.
4. Type the name of the function for which you want to search, and then select **Find Next**.

    The function line displays the information that is returned and the data type of this information. The "in" parameters display the information that must be passed in from Report Writer.

### Business Solutions - Great Plains 8.0

1. Select **Start**, point to **All Programs**, point to **Microsoft Business Solutions**, point to **Great Plains & SBM SDK**, and then select **Release 8.0 Developer Resources**.
2. In the left Navigation Pane, expand **Great Plains**, and then select **Parameters**.
3. In the right Navigation Pane, select **Great Plains 8.0 Parameters**, right-click the text in the right Navigation Pane, and then select **View Source**.
