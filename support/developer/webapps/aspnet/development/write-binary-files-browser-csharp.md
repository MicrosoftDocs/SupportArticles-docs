---
title: Write binary files to the browser
description: This article creates a sample page that demonstrates how to use Visual C# .NET to retrieve binary data from a file and then write the data out to the browser. 
ms.date: 07/28/2020
ms.custom: sap:General Development
ms.topic: how-to
---
# Use ASP.NET and Visual C# .NET to write binary files to the browser

This article creates a sample page that demonstrates how to use Visual C# .NET to retrieve binary data from a file and then write the data out to the browser. Although this demonstration uses an Adobe Acrobat (.pdf) file, you can apply this procedure to other binary file formats.

_Original product version:_ &nbsp; ASP.NET  
_Original KB number:_ &nbsp; 306654

## Requirements

- Microsoft .NET Framework
- Windows
- Internet Information Server (IIS)

## Use Visual C# to create an ASP.NET web application

This section demonstrates how to create a new ASP.NET web application named *BinaryDemo*:

1. Open Visual Studio .NET
2. From the **File** menu, point to **New**, and then click **Project**.
3. Under **Project** types, click **Visual C# Projects**. Under **Templates**, click **ASP.NET Web Application**.
4. In the **Name** text box, type *BinaryDemo*. In the **Location** text box, type the *ServerName*. If you are using the local server, leave the location as `http://localhost`.

## Add the PDF file to the project

To set up your project so that you can add and run the code in the [Create the ASPX page](#create-the-aspx-page) section to follow, you must first add an Adobe Acrobat (.pdf) file to your current project.

To do this in Visual Studio .NET, follow these steps:

1. In **Solution Explorer**, right-click the project node, click **Add**, and then click **Add Existing Item**.
2. Browse to the location of a .pdf file on your system.
3. Click to highlight the file, and then click **Open**.
4. In Visual Studio .NET **Solution Explorer**, right-click the file, and then click **Rename**. Rename the .pdf file so that it matches the file name *Acrobat.pdf* that is used in the code that follows.

In addition, ensure that Adobe Acrobat Reader is installed on the client computer from which the .aspx page is viewed so that the browser can properly read and render the binary data. You can download the Adobe Acrobat Reader from [Adobe Web site](https://www.adobe.com/).

## Create the ASPX page

1. Add a new .aspx page named *BinaryData.aspx* to the current project as follows:

    1. In **Solution Explorer**, right-click the project node, click **Add**, and then click **Add Web Form**.
    2. Name the page BinaryData.aspx, and then click **Open**.

        > [!NOTE]
        > Make sure that your page is added to the project at the same level as the .pdf file that you added in the previous section. This is very important because the code uses the relative path to initially reference the .pdf file.

2. In the editor, right-click BinaryData.aspx, and then click **View Code**.
3. Highlight the following code, right-click the code, and then click **Copy**. In the `Page_Load` event in the code-behind page, click **Paste** on the **Edit** menu to paste the code:

    ```csharp
    private void Page_Load(object sender, System.EventArgs e)
    {
        //Set the appropriate ContentType.
        Response.ContentType = "Application/pdf";
        //Get the physical path to the file.
        string FilePath = MapPath("acrobat.pdf");
        //Write the file directly to the HTTP content output stream.
        Response.WriteFile(FilePath);
        Response.End();
    }
    ```

4. On the **File** menu, click **Save All**.
5. On the **Build** menu, click **Build**.
6. To run the code, right-click BinaryData.aspx in **Solution Explorer**, and then click **View In Browser**. If you are prompted, click **Open** to open and render the file in the browser.

If you want to use the preceding code to support other binary file types, you must modify the value in the `ContentType` string so that it specifies the appropriate file format. The syntax of this string is formatted as `type/subtype`, where `type` is the general content category and `subtype` is the specific content type.

For a full list of supported content types, refer to your web browser documentation or the current HTTP specification. The following list outlines some common `ContentType` values:

- `text/HTML`
- `image/GIF`
- `image/JPEG`
- `text/plain`
- `Application/msword` (for Word files)
- `Application/x-msexcel` (for Excel files)

## References

For more information, visit below sites:

- [HttpResponse.WriteFile Method](/dotnet/api/system.web.httpresponse.writefile)

- [HttpResponse Class](/dotnet/api/system.web.httpresponse)

- [.NET Framework Class Library](/previous-versions/gg145045(v=vs.110))

For a Visual Basic .NET version of this article, see [How To Write Binary Files to the Browser Using ASP.NET and Visual C# .NET](https://support.microsoft.com/help/306654/how-to-write-binary-files-to-the-browser-using-asp-net-and-visual-c-ne).

[!INCLUDE [Third-party disclaimer](../../../../includes/third-party-disclaimer.md)]
