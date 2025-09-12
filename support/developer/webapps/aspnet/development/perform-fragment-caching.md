---
title: Perform Fragment Caching by Using Visual C# .NET
description: This article describes how to perform Fragment Caching in ASP.NET by using Visual C# .NET.
ms.date: 08/06/2020
ms.topic: how-to
ms.custom: sap:General Development
---
# Perform Fragment Caching in ASP.NET by Using Visual C# .NET

This article describes how to perform Fragment Caching in ASP.NET by using Visual C# .NET.

_Original product version:_ &nbsp; Microsoft ASP.NET  
_Original KB number:_ &nbsp; 308378

## Summary

This article demonstrates how to implement fragment caching in ASP.NET. Fragment caching does not actually cache a Web Form's code fragments directly; fragment caching refers to the caching of individual user controls (.ascx) within a Web Form. Each user control can have independent cache durations and implementations of how the caching behavior is to be applied. The sample code in this article illustrates how to achieve this functionality.

Fragment caching is useful when you need to cache only a subset of a page. Navigation bars, header, and footers are good candidates for fragment caching.

## Requirements

- Windows 2000
- Internet Information Server (IIS)
- .NET Framework
- ASP.NET

## Create an ASP.NET Web application using C# .NET

The following steps demonstrate how to create a new ASP.NET Web application named *FragmentCache*.

1. Open **Visual Studio .NET**

1. On the **File** menu, point to **New**, and then click **Project**.

1. In the **New Project** dialog box, click **Visual C# Projects** under **Project Types**, and then click **ASP.NET Web Application** under **Templates**.

1. In the **Name** box, type *FragmentCache*. In the **Location** box, select the appropriate server. If you are using the local server, you can leave the server name as `http://localhost`.

## Create the user controls

This section provides the sample code and explanations of each user control that you will use in this article. You can copy and paste the sample code into the *associated.ascx* file and code-behind page as described.

## User control 1 (FragmentCtrl1.ascx)

The following user control, **FragmentCtrl1.ascx**, is simple. **FragmentCtrl1.ascx** writes out the time that the cache entry for the item occurs. As with all of the controls that are created for this article, a basic description is provided for the control to make it easier to distinguish the settings and the associated behaviors at run time in the later sections.

1. In **Visual Studio .NET**, create a new user control as follows:

    1. In **Solution Explorer**, right-click the **project** node, point to **Add**, and then click **Add Web User Control**.
    2. Name the control **FragmentCtrl1.ascx**, and then click **Open**.

1. Make sure that the **Design** tab is selected. Click and drag a Web Form Label control from the **Web Forms** section of the toolbox, and drop the Label control onto the page.

1. Click the Label control. In the **Properties** pane of the **Visual Studio .NET** integrated development environment (IDE), type *CacheEntryTime* in the **ID** property, and leave the **Text** property blank.

1. Switch to **HTML** view, and add the following `@ OutputCache` directive to the top of the page:

    ```aspx
    <%@ OutputCache Duration="40" VaryByParam="none"%>
    ```

1. Right-click the *.ascx* file, and then click **View Code** to display the code-behind page source.

1. Add the following code to the `Page_Load` event, which sets the `CacheEntryTime` label's `Text` property:

    ```csharp
    private void Page_Load(object sender, System.EventArgs e)
    {
        CacheEntryTime.Text ="FragmentCtrl1: " + DateTime.Now.TimeOfDay.ToString();
    }
    ```

## User control 2 (FragmentCtrl2.ascx)

Although you can simply create another version of the first control with a different cache duration to show how multiple user controls can have independent behaviors in the same page, this section makes the second control, **FragmentCtrl2.ascx**, more interesting. **FragmentCtrl2.ascx** is used to introduce the **VaryByControl** attribute. **VaryByControl** allows different cache entries to be made based on the values for a specified control. This functionality is made much clearer at run time in the next section.

1. In **Visual Studio .NET**, create a new user control as follows:

    1. In **Solution Explorer**, right-click the **project** node, point to **Add**, and then click **Add Web User Control**.
    2. Name the control **FragmentCtrl2.ascx**, and then click **Open**.

1. Make sure that the **Design** tab is selected. Click and drag a Web Form Label control from the **Web Forms** section of the toolbox, and then drop the Label control onto the page.

1. Click the Label control. In the **Properties** pane, type *CacheEntryTime* in the **ID** property, and leave the **Text** property blank.

1. Position the cursor directly after the Label control, and then press **ENTER** to move to the next line in the page.

1. Click and drag a Web Form RadioButtonList control from the **Web Forms** section of the toolbox, and drop it onto the page. The RadioButtonList control should appear by itself on the line after the Label control.

1. Click the RadioButtonList control. In the **Properties** pane, type *MyRadioButtonList* in the **ID** property.

1. In the **Properties** pane, locate the **Items** property for the **MyRadioButtonList** control, click **Collection**, and then click the **ellipsis** (...) button that appears next to **Collection**.

1. In the **ListItem Collection Editor** window, add **ListItem** members as follows:
    1. Under **Members**, click **Add**.
    2. In the **ListItem** properties section, set **Text** and **Value** to **Yes**, and set **Selected** to **True**.
    3. Under **Members**, click **Add** again.
    4. In the **ListItem** properties section, set **Text** and **Value** to **No**, and set **Selected** to **False**.
    5. Under **Members**, click **Add** one last time.
    6. In the **ListItem** properties section, set **Text** and **Value** to **Maybe**, and set **Selected** to **False**.
    7. Click **OK** to return to the *.ascx* file in **Design** view. Notice that three radio buttons appear that are contained within the RadioButtonList control: **Yes**, **No**, and **Maybe**.

1. Position the cursor directly after the RadioButtonList control, and press **ENTER** to move to the next line in the page.

1. Click and drag a Web Form Button control from the **Web Forms** section of the toolbox, and drop it onto the page. The Button control should appear by itself on the line after the RadioButtonList control.

1. Click the Button control. In the **Properties** pane, type *Submit* in the **Text** property.

1. Switch to **HTML** view, and add the following `@OutputCache` directive to the top of the page:

    ```aspx
    <%@ OutputCache Duration="60" VaryByParam="none" VaryByControl="MyRadioButtonList"%>
    ```

1. Right-click the *.ascx* file, and then click **View Code** to display the code-behind page source.

1. Add the following code to the `Page_Load` event, which sets the `CacheEntryTime` label's `Text` property:

    ```csharp
    private void Page_Load(object sender, System.EventArgs e)
    {
        CacheEntryTime.Text = "FragmentCtrl2: " + DateTime.Now.TimeOfDay.ToString();
    }
    ```

## Create the Web Form to contain the user controls

You can now create the Web Form (.aspx) to contain the newly developed user control. To create the Web Form, follow these steps:

1. Add a new Web Form named **FragmentCaching.aspx** to your project in **Visual Studio .NET** as follows:

    1. In **Solution Explorer**, right-click the **project** node, point to **Add**, and then click **Add Web Form**.
    1. Name the Web Form **FragmentCaching.aspx**, and then click **Open**.

2. Make sure that the **Design** tab is selected. Click and drag a Web Form Label control from the **Web Forms** section of the toolbox, and drop it onto the page.

3. Click the Label control. In the **Properties** pane, type *Time* in the **ID** property, and leave the **Text** property blank.

4. Position the cursor directly after the Label control, and press **ENTER** to move to the next line in the page.

5. Drag **FragmentCtrl1.ascx**, and drop it onto the Web Form so that it is positioned after the Label control on a line by itself. Position the cursor directly after the control, and press **ENTER** to move to the next line in the page.

6. Drag **FragmentCtrl2.ascx**, and drop it onto the Web Form so that it is positioned after **FragmentCtrl1.ascx** on a line by itself.

7. In **HTML** view, the Web Form should appear similar to the following code:

    ```aspx
    <%@ Page language ="c#" Codebehind="FragmentCaching.aspx.cs"
       AutoEventWireup="false" Inherits="FragmentCache.FragmentCaching" %>
    <%@ Register TagPrefix="uc1" TagName="FragmentCtrl1" Src="FragmentCtrl1.ascx" %>
    <%@ Register TagPrefix="uc1" TagName="FragmentCtrl2" Src="FragmentCtrl2.ascx" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
    <HTML>
       <HEAD>
          <meta name="GENERATOR" Content="Microsoft Visual Studio 7.0">
          <meta name="CODE_LANGUAGE" Content="C#">
          <meta name="vs_defaultClientScript" content="JavaScript (ECMAScript)">
          <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
       </HEAD>
       <body>
          <form id="FragmentCaching" method="post" runat="server">
             <P>
                WebForm Time:
                <asp:Label id="Time" runat="server" ForeColor="Blue"></asp:Label>
             </P>
             <P>
                <uc1:FragmentCtrl1 id="FragmentCtrl11" runat="server">
                </uc1:FragmentCtrl1>
             </P>
             <P>
                <uc1:FragmentCtrl2 id="FragmentCtrl21" runat="server">
                </uc1:FragmentCtrl2>
             </P>
          </form>
       </body>
    </HTML>
    ```

    > [!NOTE]
    > Make sure that the controls are placed inside the

8. Right-click the **.aspx** file, and then click **View Code** to display the code-behind page source.

9. Add the following code to the `Page_Load` event, which sets the `Time` label's `Text` property:

    ```csharp
    private void Page_Load(object sender, System.EventArgs e)
    {
        Time.Text = "WebFormTime: " + DateTime.Now.TimeOfDay.ToString();
    }
    ```

10. From the **File** menu, click **Save All** to save the user controls, the Web Form, and other associated project files.

11. From the **Build** menu in the **Visual Studio .NET integrated development environment** (IDE), click **Build** to build the project.

## Run the sample

This section demonstrates how to view the code at run time to witness the caching behavior and then briefly describes why the code performs the way that it does.

1. In the **Visual Studio .NET IDE Solution Explorer**, right-click the **FragmentCaching.aspx** Web Form, and then click **View in Browser** to run the code.

2. After the page appears in the browser, right-click the page, and then click **Refresh** to refresh the page. You can also press the **F5** key to refresh the page if you are viewing the page in a browser that is external to the **Visual Studio .NET IDE**.

    > [!NOTE]
    > The time on the Web Form has been updated, but the user controls still display the time when their associated cache entry was made.

3. In the second control, click **Submit**. Notice that the control displays an updated time. This is in response to the **VaryByControl** attribute setting for the user control that references the RadioButtonList control.

4. Click **No**, and then click **Submit** again.

    > [!NOTE]
    > The time is updated again in the user control's display. This is because a new cache entry is made for the control based on this **No** value setting. Repeat this step except with the **Maybe** option. You see the same behavior.

5. Click **Yes**, and then click **Submit** again. Repeat this operation with the **No** and **Maybe** options.

    These selections for the control are cached and that they display the previous cache entry time. If you continue to click **Submit** past the **@ OutputCache** directive's duration setting, the user control's time is updated for each specific value selection for the RadioButtonList control.

> [!NOTE]
> It is not the goal of this article to cover all of the possible settings and scenarios for fragment caching.

## Troubleshooting

- Do not try to programmatically manipulate a user control that is output-cached. This is because the control is only dynamically created when it is run the first time before the cache entry occurs. The output cache satisfies all other requests until the control expires.

- If the Web Form in which user controls are hosted has an output cache duration that is longer than the duration times of the user controls, the Web Form's setting dictates the caching behavior of the controls.
