---
title: Send HTML code to clipboard by Visual C++
description: This article describes how to add Hypertext Markup Language (HTML) to the Microsoft Windows clipboard by using Visual C++.
ms.date: 04/24/2020
ms.topic: how-to
ms.custom: sap:Language or Compilers\C++
---
# Add HTML code to the clipboard by using Visual C++

This article demonstrates how to add Hypertext Markup Language (HTML) code to Microsoft Windows clipboard by using Visual C++.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 274308

## Summary

This article includes a sample function that you can use in your applications to simplify the process of adding HTML code to the clipboard.

## HTML clipboard format

HTML has its own clipboard format called HTML Format (CF_HTML) that you can use to provide your data to other applications, such as Excel, Word, or other Office applications.

CF_HTML is entirely a text-based format that includes a description, a context, and a fragment within that context. When you build data to send to the clipboard, you must include a description of the data to indicate the clipboard version and the offsets for the context and fragment. Calculating the offsets can be the difficult part. However, you can use the following routine to simplify this task.

For more information, see [HTML Clipboard Format](/previous-versions/windows/internet-explorer/ie-developer/platform-apis/aa767917(v=vs.85)).

## Sample code

```cpp
// CopyHtml() - Copies given HTML to the clipboard.
// The HTML/BODY blanket is provided, so you only need to
// call it like CallHtml("<b>This is a test</b>");

void CopyHTML(char *html)
{
    // Create temporary buffer for HTML header...
    char *buf = new char [400 + strlen(html)];
    if(!buf) return;

    // Get clipboard id for HTML format...
    static int cfid = 0;
    if(!cfid) cfid = RegisterClipboardFormat("HTML Format");

    // Create a template string for the HTML header...
    strcpy(buf,
        "Version:0.9\r\n"
        "StartHTML:00000000\r\n"
        "EndHTML:00000000\r\n"
        "StartFragment:00000000\r\n"
        "EndFragment:00000000\r\n"
        "<html><body>\r\n"
        "<!--StartFragment -->\r\n");

    // Append the HTML...
    strcat(buf, html);
    strcat(buf, "\r\n");
    // Finish up the HTML format...
    strcat(buf,
        "<!--EndFragment-->\r\n"
        "</body>\r\n"
        "</html>");

    // Now go back, calculate all the lengths, and write out the
    // necessary header information. Note, wsprintf() truncates the
    // string when you overwrite it so you follow up with code to replace
    // the 0 appended at the end with a '\r'...
    char *ptr = strstr(buf, "StartHTML");
    wsprintf(ptr+10, "%08u", strstr(buf, "<html>") - buf);
    *(ptr+10+8) = '\r';

    ptr = strstr(buf, "EndHTML");
    wsprintf(ptr+8, "%08u", strlen(buf));
    *(ptr+8+8) = '\r';

    ptr = strstr(buf, "StartFragment");
    wsprintf(ptr+14, "%08u", strstr(buf, "<!--StartFrag") - buf);
    *(ptr+14+8) = '\r';

    ptr = strstr(buf, "EndFragment");
    wsprintf(ptr+12, "%08u", strstr(buf, "<!--EndFrag") - buf);
    *(ptr+12+8) = '\r';

    // Now you have everything in place ready to put on the clipboard.
    // Open the clipboard...
    if(OpenClipboard(0))
    {
        // Empty what's in there...
        EmptyClipboard();

        // Allocate global memory for transfer...
        HGLOBAL hText = GlobalAlloc(GMEM_MOVEABLE |GMEM_DDESHARE, strlen(buf)+4);

        // Put your string in the global memory...
        char *ptr = (char *)GlobalLock(hText);
        strcpy(ptr, buf);
        GlobalUnlock(hText);

        ::SetClipboardData(cfid, hText);

        CloseClipboard();
        // Free memory...
        GlobalFree(hText);
    }
    // Clean up...
    delete [] buf;
}
```

When you use this function to copy an HTML code fragment to the clipboard, it might look like the following example:

```html
char *html =
    "<b>This is a test</b><hr>"
    "<li>entry 1"
    "<li>entry 2";
CopyHTML(html);
```

## More information

Using an approach that sends HTML code to the clipboard might be especially beneficial for Office automation clients. For example, if you have an automation client that needs to generate formatted data for cells in Excel or paragraphs in Word, you could build the data in HTML code, send it to the clipboard, and then paste it into the application. By using this technique, you could reduce the number of out-of-process calls to the Automation client.
