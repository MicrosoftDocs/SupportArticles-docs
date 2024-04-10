---
title: Use FTP WinInet APIs in VB with SimpleFtp
description: Provides the sample file that describes how to use FTP WinInet APIs in a Visual Basic (VB) application with SimpleFtp.
ms.date: 02/26/2020
ms.reviewer: sangchoe
---
# How to use FTP WinInet APIs in Visual Basic with SimpleFtp

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the sample file that demonstrates how to use WinInet FTP APIs in a Visual Basic (VB) application.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 195653

## More Information

The sample demonstrates the following concepts:

- How to enumerate a directory on the FTP server and return file information such as creation date and size.
- How to upload large files to the FTP server without blocking the entire application and with reporting transfer progress. There are two ways of uploading a file:
  - By using the `FtpPutFile()` API. However, this API blocks until the entire file has been uploaded. Upon clicking the **Put** button, the sample will use this method.
  - By using `FtpOpenFile` and `InternetWriteFile`. Once the file is open, it can be uploaded in chunks. This enables the application to report upload status and avoid blocking. It does this by calling `DoEvents()` between calling `InternetWriteFile`. Upon clicking the **Put Large File** button, the sample will use this method.
- How to get text information for WinInet errors and how to retrieve extended error information. For simplicity, the sample does not implement downloading of the large files. This functionality is similar to the second method above; however, you should use the `InternetReadFile` API instead of `InternetWriteFile`.

> [!NOTE]
> This sample uses pre-configured access to the Internet. WinInet FTP APIs do not work if Internet access is accomplished via CERN type proxy.  
> This sample was created with Visual Basic 6.0. There may be an error if the project is opened in Visual Basic 5.0.

The following file is available for download from the Microsoft Download Center:

[Vbsmpftp.exe](https://download.microsoft.com/download/ie4095/vbsmpftp/1/w9xnt4/en-us/vbsmpftp.exe)

For more information about how to download Microsoft Support files, see [How to Obtain Microsoft Support Files from Online Services](https://support.microsoft.com/help/119591/how-to-obtain-microsoft-support-files-from-online-services).

Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help to prevent any unauthorized changes to the file.

Vbsmpftp.exe contains the following files:

```console
FileName               Size
---------------------------------------------------------
ErrorForm.frm           1,216
ErrorForm.frx           6
readme.txt              1,869
SimpleFtp.bas           5,364
SimpleFtp.exe           40,960
SimpleFtp.frm           13,491
SimpleFtp.vbp           646
SimpleFtp.vbw           118
```

## References

For more information, see the following articles:

- [How to FTP with CERN-Based Proxy Using WinInet API](https://support.microsoft.com/help/166961/how-to-ftp-with-cern-based-proxy-using-wininet-api)
- [WinInet Error Codes (12001 through 12156)](https://support.microsoft.com/help/193625/info-wininet-error-codes-12001-through-12156)
