---
title: Permission denied if reading Location object property
description: This article provides the methods that help you to solve the Permission denied error message that occurs when you read properties of the Location object that is inside an HTML Application.
ms.date: 03/05/2020
ms.reviewer: v-vmaru
---
# Permission denied error when reading properties of an HTML Application Location object

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides many methods for you to solve the **Permission denied** error message that occurs if you read properties of the Location object that is inside an HTML Application (HTA).

_Original version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 816885

## Symptoms

When you read certain properties of the Location object that is inside an HTML Application (HTA), you may receive a **Permission denied** error message. The relevant properties of the
Location object include:

- Location.href
- Location.hostname
- Location.reload

> [!NOTE]
> You may notice this error only if you use an automatic configuration script in the Local Area Network (LAN) settings of Microsoft Internet Explorer.

If debugging tools are installed on your computer, you may receive the following error message:

> A Runtime Error has occurred. Do you wish to Debug? Line 12 Error: Permission denied

If debugging tools are not installed on your computer, you may receive the following error message:

> An error has occurred in the script on this page. Line: 13 Char: 2 Error: Permission denied Code: 0 URL: `http://WebServer/FileName.hta` Do you want to continue running scripts on this page?

> [!NOTE]
> You may notice this problem only if your automatic configuration script has the DIRECT value.

## Resolution

To resolve this problem, use any of the following methods:

> [!NOTE]
> The following methods are based on the sample that is mentioned in the Steps to reproduce the behavior section of this article. Therefore, the code and the file names in these methods may differ from your code and from your file names.

- Hard code a proxy server in the Proxy server settings of Internet Explorer instead of using an automatic configuration script, and then press F5 to refresh the HTA in the browser.
- Use a host name instead of a Fully Qualified Domain Name (FQDN) to access the path to the HTA.
- Use an IP address to access the HTA.
- Add the Web site that you are accessing to the Trusted zone or to the Restricted zone.
- Do not use the Location object in your code.
- Click to clear the **Include all sites that bypass the proxy server** check box in the Security settings of Internet Explorer.

## Steps to reproduce the behavior

1. Start Internet Explorer.
2. On the **Tools** menu, click **Internet Options**.
3. On the **Connections** tab, click **LAN Settings**.
4. In the **Local Area Network (LAN) settings** dialog box, click to select the **Use automatic configuration script** check box. Make sure that none of the other check boxes are selected.

5. In the **Address** box, type the path to the automatic configuration script.
6. Use Notepad to create a text file that is named Default.hta.
7. Add the following HTML code to the Default.hta file:

    ```html
    <html>
        <head>
            <title>HTA Location.href bug reproduction</title>
            <HTA:APPLICATION ID="oBugRepro" APPLICATIONNAME="BugRepro">
                <SCRIPT LANGUAGE="JavaScript">
                    function ShowFrame() {
                        var strLocation;
                        strLocation = top.fraTabs.location.href;
                    }
                </SCRIPT>
        </head>
        <frameset id="fstWorkAreaMain" name="fstWorkAreaMain" rows="40%,60%">
            <frame src="about:blank" id="fraTabs" name="fraTabs" APPLICATION="yes">
                <frame src="Main.htm" id="fraMain" NAME="fraMain" APPLICATION="yes">
        </frameset>
    </html>
    ```

8. Use Notepad to create a text file that is named Main.htm.
9. Add the following HTML code to the Main.htm file:

    ```html
    <HTML>
        <BODY style="background-color:gainsboro">
            <P>Main frame</P>
            <input id="cmdButton" type="button" onclick="top.ShowFrame()"
                value="Click me to reproduce the behavior"></input>
        </BODY>
    </HTML>
     ```

10. Place the two files, Default.hta and Main.htm, in a virtual directory that is named HTARepro on a Web server.

11. Make sure that you have enabled anonymous access to the contents of the HTARepro virtual directory.
12. Type the following command at a command prompt:

    ```console
    mshta.exe http://WebServer/HTARepro/Default.hta
    ```

    > [!NOTE]
    > Replace `WebServer` with the FQDN of the Web server that you are using.

13. On the HTA application, click **Click me to reproduce the behavior**. You receive one of the error messages that are mentioned in the Symptoms section of this article.

## References

For more information, see [Introduction to HTML Applications (HTAs)](/previous-versions//ms536496(v=vs.85)).
