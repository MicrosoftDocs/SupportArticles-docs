---
title: Upload a file to a Web site by using Visual C#
description: This article describes how to upload a file by using Visual C#.
ms.date: 07/28/2020
ms.custom: sap:General Development
ms.topic: how-to
---
# Use Visual C# to upload a file to a Web site

This article describes how to upload a file by using Microsoft Visual C#.

_Original product version:_ &nbsp; Visual C#, ASP.NET, Internet Information Services  
_Original KB number:_ &nbsp; 816150

## Introduction

This step-by-step article discusses how to upload an existing image file from your local hard disk drive to a Web site. An Input control is used to upload an image from your local computer. This file that is being uploaded is validated against the server to make sure that you do not overwrite an existing file that is already been uploaded. The uploaded file is validated if it exists on the server. This article uses the `EncType` attribute of the form to achieve the functionality.

## Requirements

This article assumes that you are familiar with the following topics:

- Web applications
- ASP.NET

The following list outlines the recommended software and network infrastructure that you need:

- Visual C# .NET or Visual C#
- Internet Information Services (IIS)

## Create an ASP.NET Web form

1. Start Visual Studio .NET or Visual Studio.
2. On the **File** menu, point to **New**, and then click **Project**.

    > [!NOTE]
    > In Visual Studio, point to **New** on the **File** menu, and then click **Web Site**.

3. Under **Project Types**, click **Visual C# Projects**. Under **Templates**, click **ASP.NET Web Application**.

    > [!NOTE]
    > In Visual Studio, select **Visual C#** on the right of **Language**. Under **Templates**, click **ASP.NET Web Site**.

4. In the **Location** box, type the following location, and then click **OK**:  
  `http://WebServerName/ApplicationName`

    > [!NOTE]
    > *WebServerName* is a placeholder for the name of your Web server. *ApplicationName* is a placeholder for the name of your application.

    By default, *WebForm1.aspx* is created.

    > [!NOTE]
    > In Visual Studio, select **HTTP** on the right of **Location**, and then type `<http://WebServerName>`.

5. On the **View** menu, click **HTML source**.

    > [!NOTE]
    > In Visual Studio, click **Code** on the **View** menu.

## Modify the form attributes

In the **HTML** window of *WebForm1*, replace the form tag with the following:

```aspx
<form id="Form1" method="post" runat="server" EncType="multipart/form-data" action="WebForm1.aspx">
```

The `EncType` attribute specifies the format of the data that is posted. The browser uses this attribute to encode the information that is posted to the server. The action attribute in this code specifies that the page will process the request. By default, the method attribute of the form is set to post so that you can send large amounts of data in the transaction.

## Add the Input control to specify the file that you want to upload to the server

1. In the **HTML** window of *WebForm1*, add the following code between the opening and the closing `<form>` tags:

    ```aspx
    <INPUT id="oFile" type="file" runat="server" NAME="oFile">
    ```

    This Input control specifies the file that you want to upload to the server.
2. You can add a text string in front of the control to prompt the user. Type the following text in front of the Input control in the **HTML** window of *WebForm1*:

    *Select the image file to upload to the server:*

## Add a Button control

1. In the **HTML** window of *WebForm1*, add the following code between the opening and closing `<form>` tags, after the Input control code:

    ```aspx
    <asp:button id="btnUpload" type="submit" text="Upload" runat="server"></asp:button>
    ```

2. This Button control is used to upload the file that you specified in the Input control.

## Create a Panel control that contains a single label to display the output

In the **HTML** window of *WebForm1*, add the following code between the opening and closing `<form>` tags, after the Button control code:

```aspx
<asp:Panel ID="frmConfirmation" Visible="False" Runat="server">
    <asp:Label id="lblUploadResult" Runat="server"></asp:Label>
</asp:Panel>
```

This code is used to display the message to indicate whether the file upload is successful. To display this output, a Panel control is created that contains a single label.

## Upload the file on the Button Click event

The code in this section retrieves the file from the local file system, checks to see if the file already exists on the server, and then uploads the file to the Web site. To add this code, follow these steps:

1. Double-click the **Upload** button that was created in the **Add a Button control** section of this article to create an event handler for the `Click` event of the button control.
2. Add the following code at the top of the **Code** window:

    ```csharp
    using System.IO;
    ```

3. Add the following code to the `Click` event handler for the **Upload** button:

    ```csharp
    string strFileName;
    string strFilePath;
    string strFolder;
    strFolder = Server.MapPath("./");
    // Retrieve the name of the file that is posted.
    strFileName = oFile.PostedFile.FileName;
    strFileName = Path.GetFileName(strFileName);
    if(oFile.Value != "")
    {
        // Create the folder if it does not exist.
        if(!Directory.Exists(strFolder))
        {
            Directory.CreateDirectory(strFolder);
        }
        // Save the uploaded file to the server.
        strFilePath = strFolder + strFileName;
        if(File.Exists(strFilePath))
        {
            lblUploadResult.Text = strFileName + " already exists on the server!";
        }
        else
        {
            oFile.PostedFile.SaveAs(strFilePath);
            lblUploadResult.Text = strFileName + " has been successfully uploaded.";
        }
    }
    else
    {
        lblUploadResult.Text = "Click 'Browse' to select the file to upload.";
    }
    // Display the result of the upload.
    frmConfirmation.Visible = true;
    ```

4. On the **File** menu, click **Save All**.

## Verify that the upload action works

1. On the **Debug** menu, click **Start** to build and to run the application. A text box and a command button appear.

1. Type the path of the image file in the text box, or click **Browse** to locate the image file on your local computer.

1. Click **Upload** to send the file to the server. If the file is unique, you receive a message that the upload succeeded. If the file already exists on the server, you receive an appropriate message. The files that you upload from this application are saved in the location: `C:\inetpub\wwwroot\ApplicationName` on the local hard disk.

1. To make this application work in the .NET Framework, allow **Full Control** access to the *ASPNET* user. To do this, follow these steps:

    1. Locate the application folder in Windows Explorer. The path is `C:\inetpub\wwwroot\ApplicationName`.
    2. Right-click the **ApplicationName** folder, and then click **Properties**. The **ApplicationName Properties** dialog box appears.
    3. Click the **Security** tab.
    4. Click **Add**. The **Select Users or Groups** dialog box appears.

       > [!NOTE]
       > In Visual Studio, the **Select Users, Computers, or Groups** dialog box appears.

    5. Type *ASPNET* in the **Enter the object names to select** box, and then click **OK**.
    6. In the **ApplicationName Properties** dialog box, click the *ASPNET* user in the **Group or user names** list.
    7. Under **Allow**, click to select the **Full Control** check box, and then click **OK**.

## Complete code listing

- WebForm1.aspx

    ```aspx
    <%@ Page language="c#" Codebehind="WebForm1.aspx.cs" AutoEventWireup="false"
       Inherits="Howto.WebForm1" %>
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" >
    <HTML>
       <HEAD>
          <title>WebForm1</title>
          <meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
          <meta name="CODE_LANGUAGE" Content="C#">
          <meta name="vs_defaultClientScript" content="JavaScript">
          <meta name="vs_targetSchema" content="http://schemas.microsoft.com/intellisense/ie5">
       </HEAD>
       <body MS_POSITIONING="GridLayout">
          <form id="Form1" method="post" runat="server" EncType="multipart/form-data" action="WebForm1.aspx">
             Image file to upload to the server: <INPUT id="oFile" type="file" runat="server" NAME="oFile">
             <asp:button id="btnUpload" type="submit" text="Upload" runat="server"></asp:button>
             <asp:Panel ID="frmConfirmation" Visible="False" Runat="server">
                <asp:Label id="lblUploadResult" Runat="server"></asp:Label>
             </asp:Panel>
          </form>
       </body>
    </HTML>
    ```

- WebForm1.aspx.cs

    ```csharp
    using System;
    using System.Collections;
    using System.ComponentModel;
    using System.Data;
    using System.Drawing;
    using System.Web;
    using System.Web.SessionState;
    using System.Web.UI;
    using System.Web.UI.WebControls;
    using System.Web.UI.HtmlControls;
    using System.IO;
    namespace **ApplicationName** {
    /// <summary>
    /// Summary description for WebForm1.
    /// </summary>
    public class WebForm1 : System.Web.UI.Page
    {
        protected System.Web.UI.WebControls.Button btnUpload;
        protected System.Web.UI.WebControls.Label lblUploadResult;
        protected System.Web.UI.WebControls.Panel frmConfirmation;
        protected System.Web.UI.HtmlControls.HtmlInputFile oFile;

        private void Page_Load(object sender, System.EventArgs e)
        {
        // Put user code to initialize the page here
        }
        #region Web Form Designer generated code
        override protected void OnInit(EventArgs e)
        {
        // CODEGEN: This call is required by the ASP.NET Web Form Designer.
            InitializeComponent();
            base.OnInit(e);
        }
        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnUpload.Click += new System.EventHandler(this.btnUpload_Click);
            this.Load += new System.EventHandler(this.Page_Load);
        }
        #endregion

        private void btnUpload_Click(object sender, System.EventArgs e)
        {
            string strFileName;
            string strFilePath;
            string strFolder;
            strFolder = Server.MapPath("./");
            // Get the name of the file that is posted.
            strFileName = oFile.PostedFile.FileName;
            strFileName = Path.GetFileName(strFileName);
            if(oFile.Value != "")
            {
                // Create the directory if it does not exist.
                if(!Directory.Exists(strFolder))
                {
                    Directory.CreateDirectory(strFolder);
                }
                // Save the uploaded file to the server.
                strFilePath = strFolder + strFileName;
                if(File.Exists(strFilePath))
                {
                    lblUploadResult.Text = strFileName + " already exists on the server!";
                }
                else
                {
                    oFile.PostedFile.SaveAs(strFilePath);
                    lblUploadResult.Text = strFileName + " has been successfully uploaded.";
                }
            }
            else
            {
                lblUploadResult.Text = "Click 'Browse' to select the file to upload.";
            }
            // Display the result of the upload.
            frmConfirmation.Visible = true;
        }
    }
    ```

> [!NOTE]
> The code generated in Visual Studio is different from the code generated in Visual Studio .NET.

## Troubleshooting

1. Open the *Machine.config* file that is located on your computer in the *CONFIG* folder under the path where you installed the runtime.
2. Find the `<processModel>` section in the *Machine.config* file, change the `user` and the `password` attributes to the name and the password of the user who you want W3wp.exe or Aspnet_wp.exe to run under, and then save the *Machine.config* file.
3. Locate the Temporary *ASP.NET* Files folder that is located in the *CONFIG* folder. Right-click the **Temporary ASP.NET Files** folder, and then click **Properties**.
4. In the **Temporary ASP.NET Files Properties** dialog box, click the **Security** tab.
5. Click **Advanced**.
6. In the **Access Control Settings for Temporary ASP.NET Files** dialog box, click **Add**.
7. In the dialog box, type the user name in the **Name** box, and then click **OK**.
8. In the **Permission Entry for Temporary ASP.NET Files** dialog box, give the user full permissions, and then click **OK** to close the **Temporary ASP.NET Files Properties** dialog box.

## References

- [\<input type = "file">](https://developer.mozilla.org/docs/Web/HTML/Element/input/file)

- [HtmlInputFile Class](/dotnet/api/system.web.ui.htmlcontrols.htmlinputfile?view=netframework-4.8&preserve-view=true)

- [HtmlInputFile.PostedFile Property](/dotnet/api/system.web.ui.htmlcontrols.htmlinputfile.postedfile?view=netframework-4.8&preserve-view=true#System_Web_UI_HtmlControls_HtmlInputFile_PostedFile)

- [PRB: Cannot Upload Large Files When You Use the HtmlInputFile Server Control](https://support.microsoft.com/help/295626/prb-cannot-upload-large-files-when-you-use-the-htmlinputfile-server-co)
