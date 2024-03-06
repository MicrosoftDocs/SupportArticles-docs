---
title: TextChanged event not fire with AutoComplete enabled in Internet Explorer
description: Describes a behavior where the TextChanged event of a TextBox control does not fire when you select the text from the AutoComplete list in the Internet Explorer even if the text in the TextBox control changes.
ms.date: 03/08/2020
---
# TextChanged event of TextBox control may not fire if AutoComplete is enabled in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the workaround to solve the issue that the TextChanged event of a TextBox control does not fire if the AutoComplete feature is enabled in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 873198

## Symptoms

When you enable the AutoComplete feature of forms in Microsoft Internet Explorer and then you select any text from the AutoComplete drop-down list of a TextBox control in a Web application, the TextChanged event of the TextBox control does not fire even though the text in the TextBox control changes.

## Cause

This behavior occurs because Internet Explorer cannot fire the TextChanged event of a TextBox control when you select text from the drop-down list by using the AutoComplete feature.

## Workaround

To work around this behavior, disable the AutoComplete feature of the Web form. To disable the feature, follow these steps:

1. In Solution Explorer, right-click **WebForm1.aspx**, and then click **View Designer**.

2. Switch to the HTML view of WebForm1.aspx.

3. Locate the following code:

   ```aspx
   <form id="Form1" method="post" runat="server">
   ```

4. Replace the code that you located in step 3 with the following code:

   ```aspx
   <form id="Form1" method="post" runat="server" autocomplete="off">
   ```

## Steps to reproduce the behavior

### Step 1: Enable the AutoComplete feature for forms

1. Start Internet Explorer.

2. On the **Tools** menu, click **Internet Options**. The **Internet Options** dialog box appears.

3. On the **Content** tab, click **AutoComplete** under **Personal information**. The **AutoComplete Settings** dialog box appears.

4. Under **Use AutoComplete for**, click to select the **Forms** check box, and then click **OK**.

5. In the **Internet Options** dialog box, click **OK**.

### Step 2: Create a Web application that contains a TextBox control

1. Start Microsoft Visual Studio .NET.

2. On the **File** menu, point to **New**, and then click **Project**. The **New Project** dialog box appears.

3. Click **Visual C# Projects** under **Project Types**, click **ASP.NET Web Application** under **Templates**, type `http://localhost/MyTestAppin` the **Location** box, and then click **OK**.

4. In Solution Explorer, right-click **WebForm1.aspx**, and then click **View Designer**.

5. On the **View** menu, click **Toolbox**.

6. Add a **TextBox** control to the Web form. By default, a TextBox control that is named TextBox1 is created.

7. In the **Properties** window of the TextBox1 TextBox control, set the **AutoPostBack** property to **True**.

8. In the **Properties** window of the TextBox1 TextBox control, click **Events**, and then double-click **TextChanged**. The **TextBox1_TextChanged** procedure is added in the Code view of the WebForm1.aspx file.

9. Insert a breakpoint at the **TextBox1_TextChanged** procedure.

10. On the **File** menu, click **Save All** to save all the files.

### Step 3: Build and then debug the Web application

1. On the **Build** menu, click **Build Solution**.

2. On the **Debug** menu, click **Start**. The **WebForm1 - Microsoft Internet Explorer** Web page appears.

3. In the text box, type *text1*, and then press ENTER. You notice that the debugger stops at the **TextBox1_TextChanged** procedure in the Code view of the WebForm1.aspx file.

4. On the **Debug** menu, click **Continue**.

5. In the text box on the **WebForm1 - Microsoft Internet Explorer** Web page, type *text2*, and then press ENTER. You notice that the debugger stops again at the **TextBox1_TextChanged** procedure in the code view of the WebForm1.aspx file.

6. On the **Debug** menu, click **Continue**.

7. In the text box on the **WebForm1 - Microsoft Internet Explorer** Web page, type *t*. You notice a drop-down list of words that you typed earlier.

8. Use the DOWN ARROW key to select **text1**, and then press ENTER.

   You see that the TextChanged event of the TextBox1 TextBox control does not fire.

## References

For more information, see [TextBox.AutoPostBack Property](/dotnet/api/system.web.ui.webcontrols.textbox.autopostback).
