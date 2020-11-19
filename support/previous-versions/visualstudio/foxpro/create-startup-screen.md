---
title: Create a Startup Screen in Visual FoxPro
description: This article describes how to create a Startup Screen in Visual FoxPro.
ms.date: 09/08/2020
ms.prod-support-area-path: 
ms.topic: how-to 
ms.prod: visual-studio-family
---
# Create a Startup Screen in Visual FoxPro

This article describes how to create a Startup Screen in Visual FoxPro.

_Original product version:_ &nbsp; Visual FoxPro  
_Original KB number:_ &nbsp; 138497

## Summary

Many Windows-based applications display a startup screen or splash screen during the initialization phase of the application. This startup screen provides a means of displaying information such as product name, product logo, product version information, company name, and so on. In addition, it gives the user the perception of quicker application startup time.

This article gives the steps for creating a custom application startup screen that will display for a specified interval of time during application initialization. This form will not suppress the FoxPro system menu or the FoxPro title bar when running within an executable file.

## Step-by-Step Procedure for Creating a Custom Startup Screen

You can use the Visual FoxPro Forms Designer to create the custom application startup screen.

1. Create a new form.

2. Set the following properties of the form:

    ```console
    AutoCenter=.T.
    BorderStyle=1
    Caption=<set the caption to be blank>
    Closable=.F.
    ControlBox=.F.
    MaxButton=.F.
    MinButton=.F.
    Movable=.F.
    WindowType=1
    ```  

3. Add a timer control to the form.

4. Set the timer's Interval property to the length of time (in milliseconds) that the startup screen should display. For example, if the startup screen should display for 3 seconds, set the timer's Interval property to 3000.

5. Place the following code in the timer's Timer event:

    ```console
    ThisForm.Release
    ```  

6. Add image, label, and other controls to customize the form as needed.

7. Save and run the form.

The form should display for the amount of time specified in the timer's Interval property and then disappear.

To incorporate this startup screen into an application, add the following code to the beginning of the applications main program:

```console
DO FORM <startup screen form name>
```  

Now when the application is run, the startup screen should display for the amount of time specified in the timer's Interval property.
