---
title: Use app .resx to create a ASP.NET web app
description: This article provides instructions that how to use resource files (.resx) to efficiently create a localizable ASP.NET Web application.
ms.date: 04/09/2020
ms.custom: sap:General Development
ms.topic: how-to
---
# Use application resource files (.resx) to efficiently create a localizable ASP.NET Web application

This article describes how to use the resource file to create a localizable ASP.NET Web application that you can view in two languages. The method in this article uses Microsoft Visual Studio to populate the resource file by using values that are based on control properties for each page.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 917414

## Summary

You can use application resource files (.resx) to efficiently create a localizable Microsoft ASP.NET Web application. By using resource files, you can store localized values for controls. The localized values are based on a user's language and culture. When you store localized values in resource files, ASP.NET can select the appropriate value at run time.

A localizable ASP.NET Web application must contain the following ones:

- A resource file (.resx) to store the localized values
- Coding to associate specific controls with specific localized values

This article contains an implicit location sample that uses a combination of designer resources and editor resources to produce a resource file.

> [!NOTE]
> It is best to generate the resource files after you create the ASP.NET Web application and after you add controls to the page.

## Step 1: Prepare the application

To prepare a new ASP.NET Web application to use localized values, follow these steps:

1. Create a Web application by using Visual Studio. Follow these steps:
    1. Start Visual Studio.
    2. On the **File** menu, select **Web Site**.
    3. Select **ASP.NET Web Site**, select **Visual Basic** in the **Language** list, and then select **OK**.
  
        > [!NOTE]
        > A new Web site is created, and the *Default.aspx* file is displayed in Source view.

    4. To switch to Design view, select **Design**.

2. To display static text, add controls to the page. Follow these steps:
    1. In the Toolbox, double-click the **Label** control to add a Label control to the page.
    2. Select **Label**.
    3. In the **Properties** window, type *Date* in the **Text** box.
    4. In the **Toolbox**, double-click the **Label** control to add a Label control to the page.
    5. Arrange this control to appear under the **Date** label.
    6. Select **Label**.
    7. In the **Properties** window, type Time in the **Text** box.

3. To display dynamic text, add controls to the page. Follow these steps:
    1. In the **Toolbox**, double-click the **Label** control to add a Label control to the page.
    2. Arrange this control to appear to the right of the **Date** label.
    3. In the Toolbox, double-click the **Label** control to add a Label control to the page.
    4. Arrange this control to appear to the right of the **Time** label.
    5. Double-click the page, and then add the following code to the `Page_Load` method.

        ```aspx-vb
         Label3.Text = Format(Now(), "H:mm")
         Label4.Text = Date.Now.Date
        ```

## Step 2: Generate the resource files automatically

To generate the resource files automatically, follow these steps:

1. In Solution Explorer, double-click the *Default.aspx* file.

    > [!NOTE]
    > The *Default.aspx* file opens in Design view.

2. On the **Tools** menu, select **Generate Local Resources**.

    > [!NOTE]
    > By default, a new folder that is named *App_LocalResources* is created. Additionally, a resource file that is named *Default.aspx.resx* is created. This file contains information about each Label control on the page. The values in the resource file match the values that you entered for each Label control in Design view.

3. In Solution Explorer, right-click the *Default.aspx.resx* file, and then select **Copy**.

4. In Solution Explorer, right-click the **App_LocalResources** folder, and then select **Paste**.

5. In Solution Explorer, right-click the *Copy of Default.aspx.resx* file, and then select **Rename**.

6. Type *Default.aspx.es-mx.resx*, and then press **ENTER**.

    > [!NOTE]
    > - Steps 3 through 6 create a localized resource file for the Spanish language. You can create a localized resource file by including the language and the culture between *.aspx* and *.resx* in the file name.
    > - To edit the localized values in various resource files, open the resource files in Visual Studio, and then change the properties for each localized control.

## Step 3: Test the application

To test the application, follow these steps:

1. On the **Debug** menu, select **Start Debugging**.

    > [!NOTE]
    > By default, Microsoft Internet Explorer starts, and the *Default.aspx* file of the ASP.NET web application is displayed.

2. On the **Tools** menu in Internet Explorer, select **Internet Options**.

3. In the **Internet Options** dialog box, select the **General** tab, and then select **Languages**.

4. In the **Language Preferences** dialog box, select **Add**.

5. In the **Add Language** dialog box, select **Spanish (Mexico) [es-mx]**, and then click **OK**.

6. In the **Language Preferences** dialog box, select **Spanish (Mexico) [es-mx]**, select **Move Up**, and then select **OK**.

7. To close the **Internet Options** dialog box, select **OK**.

8. To view the localized content on the page by using the new language settings, select **Refresh** on the **View** menu.

## References

- [Resources in ASP.NET Applications](/previous-versions/dotnet/netframework-1.1/1ztca10y(v=vs.71))

- [Globalization issues in ASP and ASP.NET](https://support.microsoft.com/help/893663)

- [HOW TO: Set Current Culture Programmatically in an ASP.NET Application](https://support.microsoft.com/help/306162)
