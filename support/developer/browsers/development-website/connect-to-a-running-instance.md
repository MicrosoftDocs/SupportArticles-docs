---
title: Connect to a running instance of Internet Explorer
description: This article describes how to connect to a running instance of Internet Explorer through C++ code.
ms.date: 06/03/2020
ms.reviewer: scotrobe
---
# How to connect to a running instance of Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

You can use the **SHDocVw.ShellWindows** collection to connect to a running instance of Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer  
_Original KB number:_ &nbsp; 176792

## More information

Typically, an application connects to a running instance of another application using the `Running Object` table. Because Internet Explorer doesn't register itself in the running object table, another method is necessary.

The **ShellWindows** collection is described in the Internet Client SDK as follows:

The **ShellWindows** object represents a collection of the open windows that belong to the shell. In fact, this collection contains references to **Internet Explorer** as well as other windows belonging to the shell, such as the Windows Explorer.

The following Visual Basic code obtains a reference to the **ShellWindows** collection. The collection is enumerated and the **LocationName** for each object added to a list box. If the document associated with the object is of type **HTMLDocument** (a Web Page), the title for the page is added to another list box.

To run the following code, it is necessary to add a reference to Microsoft Internet Controls (**Shdocvw.dll**) and Microsoft HTML Object Library (**Mshtml.dll**) to the Visual Basic project:

```vb
Dim SWs As New SHDocVw.ShellWindows
Dim IE As SHDocVw.InternetExplorer

Private Sub Form_Load()
    Dim Doc
    List1.Clear
    List2.Clear

    Text1.Text = SWs.count

    For Each IE In SWs
        List1.AddItem IE.LocationName

        Set Doc = IE.Document
        If TypeOf Doc Is HTMLDocument Then
            'if this is an HTML page, display the title
            'may or may not be the same as LocationName
            List2.AddItem Doc.Title
        End If
    Next
End Sub
```

In C++, a connection can be accomplished in roughly the same way. Visual C++ Native COM Support is used here for the sake of brevity.

Add references to **Shdocvw.dll** and **Mshtml.dll** to the project:

```vb
#import <mshtml.dll> // Internet Explorer 4.0x
#import <mshtml.tlb> // Internet Explorer 5
#import <shdocvw.dll>
```

Declare an instance of an **IShellWindows** pointer in your view class:

```vb
SHDocVw::IShellWindowsPtr m_spSHWinds;
```

Create an instance of a **ShellWindows** object in your view's constructor:

```vb
m_spSHWinds.CreateInstance(__uuidof(SHDocVw::ShellWindows));
```

Use the **ShellWindows** object in your view's **OnInitialUpdate** function:

```vb
void CConnectIEView::OnInitialUpdate()
{
    CFormView::OnInitialUpdate();

    ASSERT(m_spSHWinds != NULL);

    CString strCount;
    long nCount = m_spSHWinds->GetCount();

    strCount.Format("%i", nCount);
    m_strWinCount = strCount;

    UpdateData(FALSE);

    IDispatchPtr spDisp;
    for (long i = 0; i < nCount; i++)
    {
        _variant_t va(i, VT_I4);
        spDisp = m_spSHWinds->Item(va);

        SHDocVw::IWebBrowser2Ptr spBrowser(spDisp);
        if (spBrowser != NULL)
        {
            m_ctlListLoc.AddString(spBrowser->GetLocationName());

            MSHTML::IHTMLDocument2Ptr spDoc(spBrowser->GetDocument());
            if (spDoc != NULL)
            {
                m_ctlListTitle.AddString(spDoc->Gettitle());
            }
        }
    }
}
```

The previous method for connecting to a running instance of the Internet Explorer doesn't work if Shell Integration isn't installed or if **Browse in a new process** is selected in Internet Explorer.

If these factors cannot be controlled, there is still one possible method that may work. A browser helper object can be written to register Internet Explorer in the running object table (ROT). There are many implementations possible here depending on how the application is to determine the instance of Internet Explorer with which to connect. Just one possible solution: The browser helper object, having access to the object model of the instance of Explorer that launched it, would determine if this is the instance of the browser that should be registered in the running object table.

The interface that the consumer is interested in can be registered in the ROT with the RegisterActiveObject function and a dummy CLSID that the consumer will recognize. Another solution, that would allow multiple instances of the explorer to be registered in the ROT, would be to have the Browser Helper object compose an Item moniker based on a GUID and piece of data unique to each instance of Internet Explorer. The moniker would be registered in the ROT with the `IRunningObjectTable::Register` method. Again, the consumer would have to know how to recognize this moniker.

## References

For more information about Windows Shell SDK, see [Windows Shell](/previous-versions/windows/desktop/legacy/bb773177(v=vs.85)).

For more information about provides developer specific to Internet Explorer, see [Internet Explorer for Developers](/previous-versions/windows/internet-explorer/ie-developer/).
