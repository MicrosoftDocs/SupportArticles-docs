---
title: Use printer device fonts
description: This article describes how to enumerate and then use printer device-resident fonts.
ms.date: 02/27/2020
ms.custom: sap:Graphics and multimedia development
ms.topic: how-to
ms.technology: windows-dev-apps-graphics-multimedia-dev
---
# Use printer device fonts

The fonts that are in printers can sometimes be useful and difficult to use in application program code. This article describes how to determine which printer-resident device fonts are available for use in a Win32 printer device context. The article also describes several problems that can happen when you try to use those printer fonts in application code.

_Original product version:_ &nbsp; Win32 printer device  
_Original KB number:_ &nbsp; 201978

## Summary

In most cases, a software developer relies on the operating system to provide the fonts that will be used for its drawing. To do this, you can select an operating system-supplied font through the application programming interface (API) or through the common **Choose Font** dialog box. However, the application is typically not concerned with the particular font that is used, only it meets certain requirements and the user prefers the font. These requirements include:

- Font must be a certain size.
- Font must contain characters (otherwise known as glyphs).
- Font must have a certain style.

Typically, when the application prints the document, the font (or a font that is similar to it) is used on the printer without any particular action from the application. This is generally the correct result for the application, and this produces good printed results at reasonable speeds.

However, sometimes an application developer may have to select only a certain font specifically from a target printer. Historically, this was necessary on impact-type printers (for example, dot-matrix printers) to obtain certain formatting or to speed up the printing.

Today, most printers are fundamentally designed as raster devices and can draw a dot (a pixel) on any part of the paper as efficiently as all of a character glyph. For most applications, it isn't an issue whether a character glyph is drawn as a whole form from a printer-resident definition or is drawn as a collection of pixels that the operating system provides. However, you may still want to use a font that only the printer provides. For example, this may occur because the font is unique and has no similar substitute in the operating system or perhaps because you want to avoid the overhead of downloading a font definition to the printer.

## Device fonts

For the purposes of this article, device fonts are any fonts whose definition exists either permanently or transiently in the printer's memory. These device fonts provide a character glyph definition that can be addressed per character by the printer's page rasterizer hardware to ink the shape onto paper.

Device fonts can be categorized into three basic types:

- True device fonts. For the purposes of this article, these are fonts that only the printer hardware provides and that you can use only on the printer.

- Device font substitution. Fonts that exist in the operating system and that the printer hardware also provides. In this case, the printer hardware can substitute for the operating system's fonts.

- Downloadable fonts. Fonts that the operating system provides but whose definition can be downloaded to the printer and used on the printer as if the printer hardware provided the fonts directly.

## Downloadable fonts

The operating system provides downloadable fonts, which are also known as soft fonts. When you print a document, the definition for the font is provided as part of the print job. When the printer processes the print job, the font definition is installed in the printer memory so that the font definition can be inked onto the printed page of the document.

Some argue that because the printer is drawing the character glyphs of the font, these fonts are device fonts. However, when a font definition is downloaded or when a glyph is drawn onto the printer through a bitmap, only some overhead or print job spool size is saved. This process occurs transparently to the application so that the font in the operating system can be used on the screen and on the printer. Because this article focuses on how to use device fonts that only the printer provides, this article doesn't describe how to use downloadable fonts.

## Device font substitution

Device font substitution occurs when there are two, distinct font definitions: one that the operating system uses, and one that the printer uses. That is, an application selects and uses a font in the operating system in a document on the screen. When you print the document, the printed output is drawn by using the similarly defined font that the printer provides. Therefore, the font in the operating system has been substituted on the printer with the printer-defined font.

This typically occurs on PostScript printers when a common Windows TrueType font is used. An example of this is the TrueType Arial font that is typically printed by using the PostScript font definition for the Helvetica font on most PostScript devices. This is an example of a substitution by using a similar font whose font name is different. In this case, you can typically find and use this similar font definition directly because the similar font definition is also exposed as a true device font. This is discussed later in this article.

Device font substitution also occurs when the font on the printer has the same name as the font that the operating system provides. This typically occurs on printers such as Hewlett-Packard LaserJet printers. Those printers typically have their own versions of the Windows core fonts such as Arial and Times New Roman. Although these fonts can also typically be found by looking for true device fonts, their use sometimes cannot be guaranteed because the printer drivers frequently select on their own or select through user settings whether to use the font that the operating system provides instead.

## True device fonts

True device fonts are those that only have a definition on the printer. The only way that an application can use these fonts is for the application to specifically identify the font and to create it for use in the printer device context.

If you know enough information about a device, you can create a logical font description in a `LOGFONT` structure that will result in the realization of the device font. In particular, it is important to provide the correct information for the `lfFacename` member, the `lfHeight` member, and the character set of the font. Also, the `lfOutPrecision` member should contain an `OUT_DEVICE_PRECIS` flag to influence the font-mapping process to choose device fonts instead of similarly named system fonts.

If the description of the font isn't known, you can enumerate fonts to discover device fonts. To obtain a list of device fonts that the printer supports, use one of the font enumeration functions such as
`EnumFontFamiliesEx`. Application code that is put in the callback function can examine the data that is handed to the callback function to determine which font instances describe a device font.

## Use true device fonts

The process of using a device font in a printer device context follows these general steps:

1. Identify the true device fonts by enumeration of the fonts in a printer device context.
2. Select fonts that are device-only as indicated by the `FontType` flags and by process of elimination.
3. Use printer-specific metrics in the `MM_TEXT` mapping mode to accurately place the text that is drawn by using the device font.

## Enumerate the fonts of a printer device context

To enumerate all of the fonts that are available in a device context, you can use callback functions and the `EnumFontFamiliesEx` function from the Win32 application programming interface (API). To enumerate all of the fonts for a device context, you must call `EnumFontFamiliesEx` two times: first to get a list of font families, and a second time to get all of the distinct fonts that are in each font family.

To find all of the device fonts on a printer device context, you must enumerate all of the fonts of the printer device context. When each font is passed to the callback functions, the font is examined to determine if it is a device font. The `PrinterDeviceFontEnum` and
`PrinterDeviceFontFamiliesEnum` callback functions in the following sample code perform this operation.

```cpp
// Data structure to pass data through the font enumeration callbacks.
typedef struct PrintEnumFontData
{
    HDC             hPrinterDC;
    HDC             hEnumDC;
    int             curx, cury;
    ENUMLOGFONTEX   elf;
} PRINTENUMFONTDATA;

int CALLBACK PrinterDeviceFontEnum(
  ENUMLOGFONTEX *lpelfe,    // logical-font data
  NEWTEXTMETRICEX *lpntme,  // physical-font data
  DWORD FontType,           // type of font
  LPARAM lParam             // application-defined data
)
{
    // Crack the data out of the enumeration parameter.
    PRINTENUMFONTDATA *     ppeft = (PRINTENUMFONTDATA*) lParam;

    // Printing information
    TEXTMETRIC              tm;
    HFONT                   hfont, holdfont;
    int                     pagecx, pagecy;

    // Data to determine where this font came from
    ENUMEDFONT      df = { FontType, lpelfe };  // To look for a system version

    // What is the printable area of the page?
    pagecx = GetDeviceCaps(ppeft->hPrinterDC, HORZRES);
    pagecy = GetDeviceCaps(ppeft->hPrinterDC, VERTRES);

    // Is it a device font?
    // If it is, make sure that it is also not a TrueType font because
    // that is most likely a downloaded font.
    // Also, look for any system-provided fonts that are also
    // masquerading as printer device fonts. This implies that they will be
    // downloaded to the printer as is the case with Adobe Type 1 fonts.
    // If they are downloaded, you do not want to include them in this demonstration.
    if (FontType & DEVICE_FONTTYPE &&
        !(FontType & TRUETYPE_FONTTYPE) &&
        !IsSystemFont(&df))
    {
        TCHAR           Buffer[MAX_PATH];           // description of font
        LPTSTR          szFontType;                 // description of type
        LPTSTR          pStyle = "Regular";         // Fonts Style defaults to Regular

        // At this point in this code, the lpelfe parameter has been examined
        // and found to describe a printer device font.
        // Do something interesting with it as follows:

        // Build a sample string that describes the font.
        if (lpelfe->elfLogFont.lfItalic)
        {
            pStyle = "Italic";
            if (lpelfe->elfLogFont.lfWeight > FW_NORMAL)
                pStyle = "Bold Italic";
        }
        else if (lpelfe->elfLogFont.lfWeight > FW_NORMAL)
            pStyle = "Bold";

        // Determine if the font is scalable or a bitmap font.
        if (FontType & RASTER_FONTTYPE)
            szFontType = TEXT("Bitmap Font");
        else
        {
            // This is an instance of a scalable font, 
            // use 12 pt because it is easy to read.
            szFontType = TEXT("Scalable Font");
            lpelfe->elfLogFont.lfHeight = MulDiv(12, GetDeviceCaps(ppeft->hPrinterDC, LOGPIXELSY), 72);
            lpelfe->elfLogFont.lfWidth = 0;
        }

        // Skip all fonts after this font that are the same scale as the last one.
        // However, let different sizes of 'bitmap' fonts through.
        // This is a cheat that relies on enumeration order.
        // Really, you should keep a 'used' list and compare against the list.
        if (FontType & RASTER_FONTTYPE || !CompareLogFontEx(&ppeft->elf, lpelfe))
        {

            hfont = CreateFontIndirect(&lpelfe->elfLogFont);
            holdfont = (HFONT)SelectObject(ppeft->hPrinterDC, hfont);
            GetTextMetrics(ppeft->hPrinterDC, &tm);

            // If beyond bottom of page, get a new page.
            if (pagecy < ppeft->cury + tm.tmExternalLeading + tm.tmHeight)
            {
                EndPage(ppeft->hPrinterDC);
                StartPage(ppeft->hPrinterDC);
                ppeft->cury = 0;
            }

            // Draw our sample text.
            wsprintf(Buffer, "%s %s [%s]  FontType: %s", lpelfe->elfFullName, pStyle, lpelfe->elfScript, szFontType);
            ppeft->cury += tm.tmExternalLeading;
            TextOut(ppeft->hPrinterDC, ppeft->curx, ppeft->cury, Buffer, lstrlen(Buffer));
            ppeft->cury += tm.tmHeight;

            // Clean up.
            SelectObject(ppeft->hPrinterDC, holdfont);
            DeleteObject(hfont);

            // Make a note of the font that you used so that the next time
            // this callback is called, you can skip different scales of
            // the same font.
            CopyMemory(&ppeft->elf, lpelfe, sizeof(ENUMLOGFONTEX));
        }
    }
    // Otherwise, continue enumeration without doing anything with this
    // particular font.

    return 1;
}

int CALLBACK PrinterDeviceFontFamiliesEnum(
  ENUMLOGFONTEX *lpelfe,    // logical-font data
  NEWTEXTMETRICEX *lpntme,  // physical-font data
  DWORD FontType,           // type of font
  LPARAM lParam             // application-defined data
)
{
    PRINTENUMFONTDATA * ppeft = (PRINTENUMFONTDATA*) lParam;

    ZeroMemory(&ppeft->elf, sizeof(ppeft->elf));

    // Is it a device font?
    // If it is, make sure that it is also not a TrueType font because
    // that is most likely a downloaded font.
    if (FontType & DEVICE_FONTTYPE && !(FontType & (TRUETYPE_FONTTYPE)))
    {

        // Enumerate all of the font instances that are part of this
        // font family.
        return EnumFontFamiliesEx(ppeft->hEnumDC,
            &lpelfe->elfLogFont,
            (FONTENUMPROC)PrinterDeviceFontEnum,
            lParam,
            0);
    }

    // Otherwise, if you are not interested in this particular font, 
    // continue enumeration so that you can find more.
    return 1;
}

BOOL CALLBACK AbortProc(HDC hdc, int iError)
/*
    This minimal AbortProc implementation stops the print
    job when an error occurs.
 */
{
    if (iError)
        return FALSE;
    return TRUE;
}

BOOL PrintDeviceFontList(HDC hPrinterDC)
{
    int ret;
    LOGFONT             lf;     // Describes the start of the font enumeration
    PRINTENUMFONTDATA peft =
    {
        hPrinterDC,             // Device Context on which to print
        hPrinterDC,             // Device Context to enumerate
        0, 0,                   // Current print location
        NULL                    // Last device font that is used to print
    };
    DOCINFO di;                 // Description of the print job

    // Start the print job.
    ZeroMemory(&di, sizeof(di));
    di.cbSize = sizeof(di);
    di.lpszDocName = TEXT("Printer Font List");

    // Set a minimal AbortProc because there should always be one.
    ret = SetAbortProc(hPrinterDC, (ABORTPROC) AbortProc);
    if (ret < 1) return false;

    ret = StartDoc(hPrinterDC, &di);
    if (ret < 1) return false;

    ret = StartPage(hPrinterDC);
    if (ret < 1)
    {
        AbortDoc(hPrinterDC);
        return false;
    }

    // Enumerate everything to start, weed out non-device fonts, 
    // and then print non-device fonts during enumeration.
    ZeroMemory(&lf, sizeof(lf));
    lf.lfCharSet = DEFAULT_CHARSET;

    // Call the enumeration with your callback function that prints
    // the device fonts that it finds.
    ret = EnumFontFamiliesEx(hPrinterDC,
        &lf,
        (FONTENUMPROC)PrinterDeviceFontFamiliesEnum,
        (LPARAM)&peft,
        0);

    // The value 1 is returned by the callback functions to continue
    // the enumeration. When the enumeration completes, EnumFontFamiliesEx
    // returns the last value that the callback returns.
    // Therefore, you succeed if you get 1. Let it print.
    if (ret == 1)
    {
        EndPage(hPrinterDC);
        EndDoc(hPrinterDC);
        return true;
    }

    // Otherwise, exit because you failed somewhere in the process.
    AbortDoc(hPrinterDC);
    return false;
}
```

You can see in the sample code where the `EnumFontFamiliesEx` function is called two times. The first call is made in the
`PrintDeviceFontList` function. The second call is in the `PrinterDeviceFontFamiliesEnum` callback function.

`PrintDeviceFontList` is the top-level function. `PrintDeviceFontList` performs two tasks by starting a print job on the printer device context and then invoking the first call to `EnumFontFamiliesEx` to start the font enumeration process. According to the Platform Software Development Kit (SDK) documentation, when you set the `LOGFONT` structure's `lfCharSet` member to the `DEFAULT_CHARSET` value, `EnumFontFamiliesEx` enumerates all of the font families. After the font enumeration is complete, the code completes the print job management task by calling the `EndDoc` method.

The `PrinterDeviceFontFamiliesEnum` callback function is called for each font family by the `EnumFontFamiliesEx` function. In that callback function, the code initially screens the font families to find only the device fonts that are marked by the `FontType` parameter. It also screens out any fonts that are marked as `TrueType` because those fonts are likely to be downloadable fonts. For those font families that are considered device fonts, the `EnumFontFamiliesEx` function is called again but is passed the `ENUMLOGFONTEX` structure that the callback function received. The use of the callback parameter as the input parameter to the second enumeration function call causes the second enumeration to list all of the distinct fonts in that font family.

## Select device fonts

You can use certain criteria of printer device fonts to distinguish these fonts from any other font that is enumerated. Specifically, look for the `DEVICE_FONTTYPE` value in the `FontType` callback function's DWORD parameter. Almost all of the fonts that are handed to the callback function with this value set are device fonts for the printer device context (except with Adobe fonts).

In the sample code, the `PrinterDeviceFontEnum` callback function is called by the second enumeration for each distinct font in the font family. The `PrinterDeviceFontEnum` callback function performs three tasks:

- Uses the device font criteria again to make sure that the function only processes fonts that are recognized as device fonts.

- Searches for the font by using another font enumeration to see if the device font is also used in the system's screen device context.

- Prints a sample of the font onto the print job that is being created to demonstrate the use of the font. This callback function uses a function named `IsSystemFont`, which is part of the following sample code:

```cpp
BOOL CompareLogFontEx(
  CONST ENUMLOGFONTEX * Destination,   // copy destination
  CONST ENUMLOGFONTEX * Source  // memory block
)
/*
    Returns true if the two ENUMLOGFONTEX buffers compare.
    Return false if the two buffers differ in someway as described by the 
    criteria below.
*/
{

    // Compare the string descriptions:
    if (lstrcmpi((LPCTSTR )Destination->elfFullName, (LPCTSTR )Source->elfFullName) != 0)
        return false;
    if (lstrcmpi((LPCTSTR )Destination->elfScript, (LPCTSTR )Source->elfScript) != 0)
        return false;
    if (lstrcmpi((LPCTSTR )Destination->elfStyle, (LPCTSTR )Source->elfStyle) != 0)
        return false;

    // Height and Width are not compared because they will change
    // based upon the device on which the font is enumerated.
    //  LONG lfHeight;
    //  LONG lfWidth;

    // Compare the LOGFONT properties:
    //  LONG lfEscapement;
    if (Destination->elfLogFont.lfEscapement != Source->elfLogFont.lfEscapement) return false;
    //  LONG lfOrientation;
    if (Destination->elfLogFont.lfOrientation != Source->elfLogFont.lfOrientation) return false;
    //  LONG lfWeight;
    if (Destination->elfLogFont.lfWeight != Source->elfLogFont.lfWeight) return false;
    //  BYTE lfItalic;
    if (Destination->elfLogFont.lfItalic != Source->elfLogFont.lfItalic) return false;
    //  BYTE lfUnderline;
    if (Destination->elfLogFont.lfUnderline != Source->elfLogFont.lfUnderline) return false;
    //  BYTE lfStrikeOut;
    if (Destination->elfLogFont.lfStrikeOut != Source->elfLogFont.lfStrikeOut) return false;
    //  BYTE lfCharSet;
    if (Destination->elfLogFont.lfCharSet != Source->elfLogFont.lfCharSet) return false;
    //  BYTE lfOutPrecision;
    if (Destination->elfLogFont.lfOutPrecision != Source->elfLogFont.lfOutPrecision) return false;
    //  BYTE lfClipPrecision;
    if (Destination->elfLogFont.lfClipPrecision != Source->elfLogFont.lfClipPrecision) return false;
    //  BYTE lfQuality;
    if (Destination->elfLogFont.lfQuality != Source->elfLogFont.lfQuality) return false;
    //  BYTE lfPitchAndFamily;
    if (Destination->elfLogFont.lfPitchAndFamily != Source->elfLogFont.lfPitchAndFamily) return false;
    //  TCHAR lfFaceName[LF_FACESIZE];
    if (lstrcmpi((LPCTSTR )Destination->elfLogFont.lfFaceName, (LPCTSTR )Source->elfLogFont.lfFaceName) != 0) return false;

    // Conclusion: the two LOGFONT enumeration buffers are comparable.
    return true;
}

typedef struct structEnumedFont
{
    DWORD FontType;
    ENUMLOGFONTEX * elfx;
} ENUMEDFONT;

int CALLBACK FindSystemFontEnum(
  ENUMLOGFONTEX *lpelfe,    // logical-font data
  NEWTEXTMETRICEX *lpntme,  // physical-font data
  DWORD FontType,           // type of font
  LPARAM lParam             // application-defined data
)
{
    ENUMEDFONT  *   pdf  = (ENUMEDFONT *)lParam;
    ENUMLOGFONTEX * lpelfeSrc = pdf->elfx;

    lpelfe->elfLogFont.lfHeight = lpelfeSrc->elfLogFont.lfHeight;
    lpelfe->elfLogFont.lfWidth = lpelfeSrc->elfLogFont.lfWidth;

if (CompareLogFontEx(lpelfeSrc, lpelfe) && FontType == pdf->FontType)
        return 0;       // System font found. Stop enumeration.
        return 1;
}

BOOL IsSystemFont(ENUMEDFONT *pdf)
/*
    Utility function that takes a font that is enumerated from a printer device
    that is in the pdf parameter and that looks for it on a Screen Device
    Context to conclude that the font passed in that came from the 
    printer is really supplied by the system.
 */
{
    HDC hScreenDC = GetDC(NULL);    // Get the screen device context.

    // If the enumeration stops by returning zero (0),
    // the font was found on the screen device context so it is a
    // system-supplied font.
    BOOL fFound = !EnumFontFamiliesEx(hScreenDC,
        &pdf->elfx->elfLogFont,
        (FONTENUMPROC)FindSystemFontEnum,
        (LPARAM)pdf,
        0);

    // Cleanup
    ReleaseDC(NULL, hScreenDC);
    return fFound;
}
```

This function detects when a font that is marked as a device font but isn't a true device font (according to the definition in this article). This occurs when Adobe fonts are installed into the system through either the Adobe Type Manager or through the native Adobe rasterizer that is present in Windows 2000 or Windows XP.

When this occurs, the font is really a system-supplied font that is downloaded to the printer, which sometimes occurs with TrueType fonts. Unfortunately, there is no flag that you can use across Windows 98, Windows Millennium Edition (Me), Windows 2000, and Windows XP that indicates that the font is an Adobe font that the system provides (unlike TrueType fonts, which include a flag). There is an indication in the `NEWTEXTMETRIC` structure's `ntmFlags` member, but this is only available in Windows 2000 and later. Therefore, the code must resort to a process of elimination. The font is removed when `IsSystemFontdetermines` that the device font is provided by both the screen device context and the printer device context.

To avoid repetitious samples of a font that scales, the code also notes when a candidate font has already been used. The specific implementation of this relies on the enumeration order of the fonts to see when sequential enumerations of a font are the same font but in a different scale. To remove fonts that are only a different scale, the code uses the `CompareLogFontEx` function.

> [!NOTE]
> The documentation for programming Windows operating systems doesn't state that font instances that differ only by scale will be enumerated sequentially. The code sample uses this technique because enumeration was seen to work this way, and the reduction in the number of sample lines on the printed page is not a critical feature of the demonstration code. If you want to rely on eliminating different scales of the same font, you must keep a data structure of the device fonts that are used. Then the program must check the currently-enumerated font against that data structure.

### Scalable vs. Bitmap fonts

There are two types of device fonts that can be enumerated on printers:

- Bitmap or raster fonts
- Scalable fonts

Bitmap fonts are fonts that have a character glyph definition of a fixed size. Scalable fonts are fonts that have a mathematics-based definition in the printer so that they can be drawn at any size. In other words, their size scales.

The classic example of a bitmap font is Courier 10 characters per inch (cpi). As the name implies, this font is a hold over from the transition from typewriters to impact-type printers. It is called a bitmap font because the most common definition of the font was located in a ROM bitmap image of a dot-matrix printer.

Examples of scalable, printer-resident fonts can be found in most PostScript printers where there is typically a standard set of PostScript fonts such as Helvetica and Times.

Device fonts that aren't scalable have a bit that is set in the `FontType` parameter of the callback function. That bit is represented by the symbol `RASTER_FONTTYPE` in the SDK. If the `FontType` parameter to the callback function doesn't have the `RASTER_FONTTYPEbit` set, the font is a scalable font. For an example of how to determine this, see the `PrinterDeviceFontEnum` callback function of the sample code.

## Draw the device fonts

After fonts that are device fonts are found, the sample uses them in the printer device context on which the enumeration was done. Device fonts are used much like other fonts by creating a logical description with the `CreateFontIndirect` function. This function call is passed the `LOGFONT` that was passed into the font enumeration callback function. After the `HFONT` is created, it's used in the printer device context by selecting it into the device context with the `SelectObject` function call.

Metrics for the device font are obtained through the `GetTextMetrics` function call. It is best to operate on printer device contexts by using the `MM_TEXT` mapping mode, which is the default-mapping mode for a device context. When you use the `MM_TEXT` mapping mode, you avoid mathematical errors that can occur during the unit conversion process of other mapping modes.

When you use a device font in a printer device context, you must be careful not to transport the metrics for the font and the strings to other device contexts. This is true particularly of memory device contexts. By definition, a memory device context isn't the print job but is a temporary memory buffer of raster graphics and therefore can't use a device font.

There is another significant consideration when you use printer device fonts: you cannot provide a What-You-See-Is-What-You-Get type preview of the print job. Clearly, fonts that reside in the printer hardware cannot be drawn onto the screen. The closest that you can come to previewing the print job is to find a system-supplied font that has the general characteristics of a printer device font and then draw the glyphs of that font on the screen by using the `ExtTextOut` function to simulate the placement of the character glyphs on the printed page.

## Problems using device fonts

You may experience the following problems when you use device fonts:

- There's a device font, but the printer driver doesn't enumerate it.

    There are two reasons why you can't find a device font by enumerating the fonts available for use on a printer device context:

  - The printer driver was written to exclude that device font for some reason.
  - The printer driver enumerates the font, but the font isn't properly marked in the `FontType` parameter as a device font.

- There are system fonts that seem to enumerate as device fonts.

    This problem occurs when a system-provided font is downloaded to a printer.

    When this occurs with TrueType fonts, the font enumeration callback function receives a call with the `TRUETYPE_FONTTYPE` and the `DEVICE_FONTTYPE` bits set on the `FontType` parameter. This is handled in the sample code by not including any fonts that contain these combinations of bits.

    This also occurs with Adobe PostScript fonts that are installed in the system that are downloaded to the printer. One way to differentiate these fonts from the other device fonts is to look for them in both a system screen device context and the printer device context. If the same font can be enumerated on both device contexts, the font will likely be downloaded to the printer when it is used on the printer device context.

- My printer driver enumerates several scalable device fonts, but they appear to be the same except for their sizes.

    Many printer drivers enumerate a scalable font by providing several different instances of the same font with different sizes. This is handled in the sample code by comparing the various instances of those fonts that are presumed to be scalable by using the `CompareLogFontEx` function.

    > [!NOTE]
    > When the `FontType` parameter to the callback function has the `RASTER_FONTTYPEbit` set, the multiple enumerations provide descriptions of specific instances of the non-scalable fonts for each size. Each callback enumerates the only sizes in which that font is available.

- Some printers appear not to have device fonts.

    This is true. Some printers, namely ink jet-type printers, do not provide device fonts. These printers are strictly raster devices and therefore do not have printer-resident font definitions.
