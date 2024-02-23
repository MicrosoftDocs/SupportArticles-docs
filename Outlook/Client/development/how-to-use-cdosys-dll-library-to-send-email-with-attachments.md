---
title: How to use Cdosys.dll to send emails with attachments
description: Describes how to use the CDO library to send an e-mail message with attachments. You can send text, HTML, or a Web page in the body of the e-mail message by using Visual C#.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: 
appliesto: 
  - Outlook
search.appverid: MET150
ms.date: 10/30/2023
---
# How to use the Cdosys.dll library to send an e-mail message with attachments

_Original KB number:_ &nbsp; 310212

## Summary

This article describes how to use the Collaboration Data Objects (CDO) for Windows 2000 library (Cdosys.dll) to send an e-mail message with attachments. You can send text or HTML or a Web page in the body of the e-mail message by using the local SMTP server or by using a smart host server in Microsoft Visual C#.

> [!NOTE]
> The Cdosys.dll library is also known as CDOSYS.

## More information

To use CDOSYS as described in the Summary section, follow these steps:

1. Start Microsoft Visual Studio.
2. On the **File** menu, select **New**, and then select **Project**.
3. Under **Project Types**, select **Visual C#**, and then select **Console Application** under **Templates**. By default, Program.cs is created.

    > [!NOTE]
    > In Microsoft Visual C# .NET 2003, **Visual C#** is changed to **Visual C# Projects**. By default, Class1.cs is created.
4. Add a reference to the **Microsoft CDO For Windows 2000 Library**. To do this, follow these steps:
      1. On the **Project** menu, select **Add Reference**.
      2. On the **COM** tab, locate **Microsoft CDO For Windows 2000 Library**.

         > [!NOTE]
         > In Visual C# .NET 2003, select **Select**.
      3. To accept your selections, select **OK** in the **Add References** dialog box.

         If you receive a dialog box to generate wrappers for the libraries that you selected, select **Yes**.
5. In the code window, replace all the code with the following code:

    ```cs
    namespace CdoSys {
        using System;
        class Class1 {
            static void Main (string[] args) {
                try {
                    CDO.Message oMsg = new CDO.Message ();
                    CDO.IConfiguration iConfg;

                    iConfg = oMsg.Configuration;

                    ADODB.Fields oFields;
                    oFields = iConfg.Fields;

                    // Set configuration.
                    ADODB.Field oField = oFields["http://schemas.microsoft.com/cdo/configuration/sendusing"];

                    //TODO: To send by using the smart host, uncomment the following lines:
                    //oField.Value = CDO.CdoSendUsing.cdoSendUsingPort;
                    //oField = oFields["http://schemas.microsoft.com/cdo/configuration/smtpserver"];
                    //oField.Value = "smarthost";

                    // TODO: To send by using local SMTP service.
                    //oField = oFields["http://schemas.microsoft.com/cdo/configuration/sendusing"];
                    //oField.Value = 1;

                    oFields.Update ();

                    // Set common properties from message.

                    //TODO: To send text body, uncomment the following line:
                    //oMsg.TextBody = "Hello, how are you doing?";

                    //TODO: To send HTML body, uncomment the following lines:
                    //String sHtml;
                    //sHtml = "<HTML>\n" +
                    //"<HEAD>\n" +
                    //"<TITLE>Sample GIF</TITLE>\n" +
                    //"</HEAD>\n" +
                    //"<BODY><P>\n" +
                    //"<h1><Font Color=Green>Inline graphics</Font></h1>\n" +
                    //"</BODY>\n" +
                    //"</HTML>";
                    //oMsg.HTMLBody = sHtml;

                    //TOTO: To send WEb page in an e-mail, uncomment the following lines and make changes in TODO section.
                    //TODO: Replace with your preferred Web page
                    //oMsg.CreateMHTMLBody("http://www.microsoft.com",
                    //CDO.CdoMHTMLFlags.cdoSuppressNone,
                    //"", "");
                    oMsg.Subject = "Test SMTP";

                    //TODO: Change the To and From address to reflect your information.
                    oMsg.From = "someone@example.com";
                    oMsg.To = "someone@example.com";
                    //ADD attachment.
                    //TODO: Change the path to the file that you want to attach.
                    oMsg.AddAttachment ("C:\\Hello.txt", "", "");
                    oMsg.AddAttachment ("C:\\Test.doc", "", "");
                    oMsg.Send ();
                } catch (Exception e) {
                    Console.WriteLine ("{0} Exception caught.", e);
                }
                return;
            }
        }
    }
    ```

6. Where TODO appears in the code, modify the code as indicated.
7. To build and run the program, press F5.
8. Verify that the e-mail message has been both sent and received.

## References

For more information about Microsoft Office development with Visual Studio, see [Microsoft Office Development with Visual Studio](/previous-versions/office/developer/office-xp/aa188489(v=office.10)).
