---
title: Read and display binary data by using ServerXMLHTTP
description: This article describes how to read and display binary data in ASP using ServerXMLHTTP.
ms.date: 09/24/2020
ms.custom: sap:Active Server Pages
---
# Read and display binary data in ASP using ServerXMLHTTP

This article shows how to read and display binary data in Active Server Pages (ASP) using `ServerXMLHTTP`.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 303982

## Summary

`ServerXMLHTTP` provides methods and properties for server-safe HTTP access between different Web servers. You can use this object to exchange binary data between these servers through ASP.

## More information

The ASP page receives and then displays the binary data using the appropriate Multipurpose Internet Mail Extensions (MIME) type. For example, for .gif images, change the MIME type by using the following:

```vbscript
Response.ContentType = "image/gif"
```

> [!NOTE]
> For Adobe Acrobat files, use `application/pdf`, or for .jpg images, use `image/jpg`.

The default behavior for MIME types is to open the document in Microsoft Internet Explorer. Adding the following code prompts the user to save the file or open the file with the associated program:

```vbscript
Content-disposition: attachment; filename=fname.ext
```

For more information, see [How to raise a File Download dialog box for a known MIME type](/troubleshoot/browsers/raise-file-download-for-mime-types).

The following steps illustrate how to use `ServerXMLHTTP` to stream a .jpg file to the browser. `ServerXMLHTTP` retrieves an XML response from an ASP page over HTTP. By using GET, the example sends a request without transferring any data to the Web server. The example writes this response to the browser's output by first informing the browser that the response is an image (`image/jpg`) and then passing the response directly from the Response object to display it onscreen.

1. Create a new ASP page, and paste the following code in the page:

    ```vbscript
    <%@ Language=VBScript %>
    <%
    Response.ContentType = "image/jpeg"
    ' Uncomment to prompt user for download or run with associated program.
    ' Response.AddHeader "content-disposition","attachment;filename=ReadMe.jpg"
    Set objHTTP = Server.CreateObject("Msxml2.ServerXMLHTTP")' Point to an image file with adequate access permissions granted
    objHTTP.open "GET", "http://servername/picture.jpg",false
    objHTTP.send
    Response.BinaryWrite objHTTP.ResponseBody
    Set objHTTP = Nothing
    %>
    ```

2. Save the file to the Web server.
3. Browse to the file.

When you use the `ServerXMLHTTP` object, be aware of the following:

- Due to threading issues, the ASP page and the file that is being accessed should be in different virtual folders.
- MSXML 3.0 parser or later should be installed on the server and the proxy configuration utility should be run with appropriate settings.

## References

- [XML Extended Data Type](/previous-versions/dynamics/ax-2012/reference/gg920029(v=ax.60))
- [Frequently asked questions about ServerXMLHTTP](https://support.microsoft.com/help/290761/frequently-asked-questions-about-serverxmlhttp)
