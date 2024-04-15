---
title: Click a check box in a TreeView
description: Describes how to know when the user clicks a check box in a TreeView control.
ms.date: 04/24/2020
ms.custom: sap:C and C++ Libraries\Microsoft Foundation Classes (MFC)
ms.topic: how-to
---
# How to know when the user clicks a check box in a TreeView control

This article describes how to know when the user clicks a check box in a TreeView control.

_Original product version:_ &nbsp;  Visual C++  
_Original KB number:_ &nbsp; 261289

## Summary

On a TreeView control with the **TVS_CHECKBOXES** style, there's no notification that the checked state of the item has been changed. There's also no notification that indicates the state of the item has changed. However, you can determine that the user has clicked the state icon of the item and act upon that.

## How TreeView toggles the state of the check box

When the user clicks the check box of a TreeView item, an `NM_CLICK` notification is sent to the parent window. When it occurs, the `TVM_HITTEST` message returns `TVHT_ONITEMSTATEICON`. The TreeView control uses this same condition to toggle the state of the check box. Unfortunately, the TreeView control toggles the state after the `NM_CLICK` notification is sent.

## Sample code to know when users click a check box

You can post a user-defined message to the same window that is processing the `NM_CLICK` notification, and treat this user-defined message as a notification that the checked state has changed. The following sample code illustrates how it can be accomplished.

```cpp
#define UM_CHECKSTATECHANGE (WM_USER + 100)

case WM_NOTIFY:
{
    LPNMHDR lpnmh = (LPNMHDR) lParam;
    TVHITTESTINFO ht = {0};

    if(lpnmh->code == NM_CLICK) && (lpnmh->idFrom == IDC_MYTREE))
    {
        DWORD dwpos = GetMessagePos();

        // include <windowsx.h> and <windows.h> header files
        ht.pt.x = GET_X_LPARAM(dwpos);
        ht.pt.y = GET_Y_LPARAM(dwpos);
        MapWindowPoints(HWND_DESKTOP, lpnmh->hwndFrom, &ht.pt, 1);

        TreeView_HitTest(lpnmh->hwndFrom, &ht);

        if(TVHT_ONITEMSTATEICON & ht.flags)
        {
            PostMessage(hWnd, UM_CHECKSTATECHANGE, 0, (LPARAM)ht.hItem);
        }
    }
}
break;

case UM_CHECKSTATECHANGE:
{
    HTREEITEM hItemChanged = (HTREEITEM)lParam;
    /*
    Retrieve the new checked state of the item and handle the notification.
    */
}
break
```
