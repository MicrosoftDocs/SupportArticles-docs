---
title: Make a field conditionally required
description: Describes how to make a field conditionally required in Microsoft Dynamics GP 9.0.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# How to make a field conditionally required in Microsoft Dynamics GP 9.0

This article discusses a customization that can be used to make a field conditionally required in Microsoft Dynamics GP 9.0. When you make this customization, the **User Defined 1** field must be set to a value if the customer is on hold.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 934695

## Introduction

The following code uses a **ValidateBeforeOriginal** event on the **SaveRecord** field instead of on the **Save** button. The **SaveRecord** field is selected because the **SaveRecord** event is called by the Customer Maintenance window from multiple locations. The **SaveRecord** event is always invoked when you save a record in this window.

The following code is the C# code for Visual Studio Tools in Microsoft Dynamics GP.

```csharp
using System; using System.Collections.Generic; using System.Text; using Microsoft.Dexterity.Bridge; using Microsoft.Dexterity.Applications; using Microsoft.Dexterity.Applications.DynamicsDictionary; using System.Windows.Forms; namespace CustomerSaveTest { public class GPAddIn : IDexterityAddIn { //Declare a static variable that has an instance of the Customer Maintenance window. static Microsoft.Dexterity.Applications.DynamicsDictionary.RmCustomerMaintenanceForm.RmCustomerMaintenanceWindow cust = Microsoft.Dexterity.Applications.Dynamics.Forms.RmCustomerMaintenance.RmCustomerMaintenance; public void Initialize() { //Declare an event handler that will run before Microsoft Dynamics GP saves the customer record. cust.SaveRecord.ValidateBeforeOriginal += new System.ComponentModel.CancelEventHandler(SaveRecord_ValidateBeforeOriginal); } void SaveRecord_ValidateBeforeOriginal(object sender, System.ComponentModel.CancelEventArgs e) { //Implement the following business logic: If the customer is on hold, a reason must be entered in the "User Defined 1" field. if (cust.Hold == true && cust.UserDefined1.Value == "") { MessageBox.Show("For customers on hold, User Defined 1 is required."); //Cancel the Save event. e.Cancel = true; cust.UserDefined1.Focus(); } } } }
```

The following code is the code for Microsoft Visual Basic .NET.

```vb
Imports System Imports System.Collections.Generic Imports System.Text Imports Microsoft.Dexterity.Bridge Imports Microsoft.Dexterity.Applications Imports Microsoft.Dexterity.Applications.DynamicsDictionary Imports System.Windows.Forms Namespace ButtonEventTest Public Class GPAddIn Implements IDexterityAddIn ' IDexterityAddIn interfac 
```

## More information

This code typically works correctly. But, in some cases, the code clears the window without saving the record. The **SaveRecord** field acts as a flag. If the **SaveRecord** event is canceled, the record isn't saved. But the flag is still set from when the previous customer was successfully saved. If this scenario occurs, use Modifier in Microsoft Dynamics GP to save the record. To do it, follow these steps:

1. Open the Customer Maintenance window. To do it, select **Cards**, point to **Sales**, and then select **Customer**.
2. Select **Tools**, point to **Customize**, and then select **Modify Current Window**. The **Window:RM_Customer_Maintenance** window is now displayed in Modifier.
3. Select **Layout**, and then select **Show Field Names**.
4. Select **Layout**, and then select **Show Invisible Fields**.
5. In the **Window:RM_Customer_Maintenance** window, select the **Save Record** field.
6. Select **Layout**, and then select **Properties**.
7. In the **Properties** dialog box, double-click the **SaveOnRestart** field to change the value from **True** to **False**.
8. To return to Microsoft Dynamics GP, select **File**, and then select **Microsoft Dynamics GP**. Select **Save** when you are prompted to save the changes.
9. Assign security permissions to the modified version of the Customer Maintenance window. To do it, refer to Chapter 2 of the Advanced Security manual (AdvancedSecurity.pdf). By default, the Advanced Security manual is located in the following folder: </Br>`C:\Program Files\Microsoft Dynamics\GP\Documentation`

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
