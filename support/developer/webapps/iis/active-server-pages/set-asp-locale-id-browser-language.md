---
title: Set ASP locale ID
description: This article provide the information that how to set the Locale ID for the ASP application.
ms.date: 03/23/2020
ms.custom: sap:Active Server Pages
ms.reviewer: mcai
ms.topic: how-to
ms.technology: active-server-pages
---
# Set the ASP locale ID per the browser's language settings

This article describes that how to set the Active Server Pages (ASP) locale ID according to the browser's language settings.

_Original product version:_ &nbsp;  Active Server Pages  
_Original KB number:_ &nbsp; 229690

## Summary

When you create an ASP application that multiple international sites access, it is beneficial to modify the locale settings so that the VBScript date, time, currency, and so forth, formats return the correct format for the location of the user.

## More information

The following subroutine dynamically sets the `Locale ID` for the ASP application (`Session.LCID`) according to the language settings supplied by the user's browser:

```vbscript
<SCRIPT Runat=Server Language=VBScript>
Sub SetLCID()
    Dim strAcceptLanguage
    Dim strLCID
    Dim strPos
    strAcceptLanguage = Request.ServerVariables("HTTP_ACCEPT_LANGUAGE")
    strPos = InStr(1, strAcceptLanguage, ",")
    If strPos > 0 Then
        strAcceptLanguage = Left(strAcceptLanguage, strPos - 1)
    End If

    Select Case LCase(strAcceptLanguage)
        Case "af"
          strLCID = 1078 ' Afrikaans
        Case "sq"
          strLCID = 1052 ' Albanian
        Case "ar-sa"
          strLCID = 1025 ' Arabic(Saudi Arabia)
        Case "ar-iq"
          strLCID = 2049 ' Arabic(Iraq)
        Case "ar-eg"
          strLCID = 3073 ' Arabic(Egypt)
        Case "ar-ly"
          strLCID = 4097 ' Arabic(Libya)
        Case "ar-dz"
          strLCID = 5121 ' Arabic(Algeria)
        Case "ar-ma"
          strLCID = 6145 ' Arabic(Morocco)
        Case "ar-tn"
          strLCID = 7169 ' Arabic(Tunisia)
        Case "ar-om"
          strLCID = 8193 ' Arabic(Oman)
        Case "ar-ye"
          strLCID = 9217 ' Arabic(Yemen)
        Case "ar-sy"
          strLCID = 10241 ' Arabic(Syria)
        Case "ar-jo"
          strLCID = 11265 ' Arabic(Jordan)
        Case "ar-lb"
          strLCID = 12289 ' Arabic(Lebanon)
        Case "ar-kw"
          strLCID = 13313 ' Arabic(Kuwait)
        Case "ar-ae"
          strLCID = 14337 ' Arabic(U.A.E.)
        Case "ar-bh"
          strLCID = 15361 ' Arabic(Bahrain)
        Case "ar-qa"
          strLCID = 16385 ' Arabic(Qatar)
        Case "eu"
          strLCID = 1069 ' Basque
        Case "bg"
          strLCID = 1026 ' Bulgarian
        Case "be"
          strLCID = 1059 ' Belarusian
        Case "ca"
          strLCID = 1027 ' Catalan
        Case "zh-tw"
          strLCID = 1028 ' Chinese(Taiwan)
        Case "zh-cn"
          strLCID = 2052 ' Chinese(PRC)
        Case "zh-hk"
          strLCID = 3076 ' Chinese(Hong Kong SAR)
        Case "zh-sg"
          strLCID = 4100 ' Chinese(Singapore)
        Case "hr"
          strLCID = 1050 ' Croatian
        Case "cs"
          strLCID = 1029 ' Czech
        Case "da"
          strLCID = 1030 ' Danish
        Case "nl"
          strLCID = 1043 ' Dutch(Standard)
        Case "nl-be"
          strLCID = 2067 ' Dutch(Belgian)
        Case "en"
          strLCID = 9 ' English
        Case "en-us"
          strLCID = 1033 ' English(United States)
        Case "en-gb"
          strLCID = 2057 ' English(British)
        Case "en-au"
          strLCID = 3081 ' English(Australian)
        Case "en-ca"
          strLCID = 4105 ' English(Canadian)
        Case "en-nz"
          strLCID = 5129 ' English(New Zealand)
        Case "en-ie"
          strLCID = 6153 ' English(Ireland)
        Case "en-za"
          strLCID = 7177 ' English(South Africa)
        Case "en-jm"
          strLCID = 8201 ' English(Jamaica)
        Case "en-ca"
          strLCID = 9225 ' English(Caribbean)
        Case "en-bz"
          strLCID = 10249 ' English(Belize)
        Case "en-tt"
          strLCID = 11273 ' English(Trinidad)
        Case "et"
          strLCID = 1061 ' Estonian
        Case "fo"
          strLCID = 1080 ' Faeroese
        Case "fa"
          strLCID = 1065 ' Persian
        Case "fi"
          strLCID = 1035 ' Finnish
        Case "fr"
          strLCID = 1036 ' French(Standard)
        Case "fr-be"
          strLCID = 2060 ' French(Belgian)
        Case "fr-ca"
          strLCID = 3084 ' French(Canadian)
        Case "fr-ch"
          strLCID = 4108 ' French(Swiss)
        Case "fr-lu"
          strLCID = 5132 ' French(Luxembourg)
        Case "mk"
          strLCID = 1071 ' Macedonian
        Case "gd"
          strLCID = 1084 ' Scottish Gaelic
        Case "de"
          strLCID = 1031 ' German(Standard)
        Case "de-ch"
          strLCID = 2055 ' German(Swiss)
        Case "de-at"
          strLCID = 3079 ' German(Austrian)
        Case "de-lu"
          strLCID = 4103 ' German(Luxembourg)
        Case "de-li"
          strLCID = 5127 ' German(Liechtenstein)
        Case "el"
          strLCID = 1032 ' Greek
        Case "he"
          strLCID = 1037 ' Hebrew
        Case "hi"
          strLCID = 1081 ' Hindi
        Case "hu"
          strLCID = 1038 ' Hungarian
        Case "is"
          strLCID = 1039 ' Icelandic
        Case "in"
          strLCID = 1057 ' Indonesian
        Case "it"
          strLCID = 1040 ' Italian(Standard)
        Case "it-ch"
          strLCID = 2064 ' Italian(Swiss)
        Case "ja"
          strLCID = 1041 ' Japanese
        Case "ko"
          strLCID = 1042 ' Korean
        Case "ko"
          strLCID = 2066 ' Korean(Johab)
        Case "lv"
          strLCID = 1062 ' Latvian
        Case "lt"
          strLCID = 1063 ' Lithuanian
        Case "ms"
          strLCID = 1086 ' Malaysian
        Case "mt"
          strLCID = 1082 ' Maltese
        Case "no"
          strLCID = 1044 ' Norwegian(Bokmal)
        Case "no"
          strLCID = 2068 ' Norwegian(Nynorsk)
        Case "pl"
          strLCID = 1045 ' Polish
        Case "pt-br"
          strLCID = 1046 ' Portuguese(Brazil)
        Case "pt"
          strLCID = 2070 ' Portuguese(Portugal)
        Case "rm"
          strLCID = 1047 ' Rhaeto-Romanic
        Case "ro"
          strLCID = 1048 ' Romanian
        Case "ro-mo"
          strLCID = 2072 ' Romanian(Moldova)
        Case "ru"
          strLCID = 1049 ' Russian
        Case "ru-mo"
          strLCID = 2073 ' Russian(Moldova)
        Case "sz"
          strLCID = 1083 ' Sami(Lappish)
        Case "sr"
          strLCID = 3098 ' Serbian(Cyrillic)
        Case "sr"
          strLCID = 2074 ' Serbian(Latin)
        Case "sk"
          strLCID = 1051 ' Slovak
        Case "sl"
          strLCID = 1060 ' Slovenian
        Case "sb"
          strLCID = 1070 ' Sorbian
        Case "es"
          strLCID = 1034 ' Spanish(Spain - Traditional Sort)
        Case "es-mx"
          strLCID = 2058 ' Spanish(Mexican)
        Case "es-gt"
          strLCID = 4106 ' Spanish(Guatemala)
        Case "es-cr"
          strLCID = 5130 ' Spanish(Costa Rica)
        Case "es-pa"
          strLCID = 6154 ' Spanish(Panama)
        Case "es-do"
          strLCID = 7178 ' Spanish(Dominican Republic)
        Case "es-ve"
          strLCID = 8202 ' Spanish(Venezuela)
        Case "es-co"
          strLCID = 9226 ' Spanish(Colombia)
        Case "es-pe"
          strLCID = 10250 ' Spanish(Peru)
        Case "es-ar"
          strLCID = 11274 ' Spanish(Argentina)
        Case "es-ec"
          strLCID = 12298 ' Spanish(Ecuador)
        Case "es-c"
          strLCID = 13322 ' Spanish(Chile)
        Case "es-uy"
          strLCID = 14346 ' Spanish(Uruguay)
        Case "es-py"
          strLCID = 15370 ' Spanish(Paraguay)
        Case "es-bo"
          strLCID = 16394 ' Spanish(Bolivia)
        Case "es-sv"
          strLCID = 17418 ' Spanish(El Salvador)
        Case "es-hn"
          strLCID = 18442 ' Spanish(Honduras)
        Case "es-ni"
          strLCID = 19466 ' Spanish(Nicaragua)
        Case "es-pr"
          strLCID = 20490 ' Spanish(Puerto Rico)
        Case "sx"
          strLCID = 1072 ' Sutu
        Case "sv"
          strLCID = 1053 ' Swedish
        Case "sv-fi"
          strLCID = 2077 ' Swedish(Finland)
        Case "th"
          strLCID = 1054 ' Thai
        Case "ts"
          strLCID = 1073 ' Tsonga
        Case "tn"
          strLCID = 1074 ' Tswana
        Case "tr"
          strLCID = 1055 ' Turkish
        Case "uk"
          strLCID = 1058 ' Ukrainian
        Case "ur"
          strLCID = 1056 ' Urdu
        Case "ve"
          strLCID = 1075 ' Venda
        Case "vi"
          strLCID = 1066 ' Vietnamese
        Case "xh"
          strLCID = 1076 ' Xhosa
        Case "ji"
          strLCID = 1085 ' Yiddish
        Case "zu"
          strLCID = 1077 ' Zulu
        Case Else
          strLCID = 2048 ' default
    End Select

    Session.LCID = strLCID
End Sub
</SCRIPT>
```

## Sample ASP page

The following sample code may be used to demonstrate the locale changes. To demonstrate the changes, create an ASP page with the following code and view it in the browser. In the **Internet Options** (or **Preferences**) section, modify your language settings and refresh the ASP page.

> [!NOTE]
> The `SetLCID()` code sample was placed in an include file called *setlcid.inc*.

```vbscript
<%@ Language=VBScript %>
<HTML>
  <BODY>
    <!--#include file=setlcid.inc -->
    <%
    SetLCID 'Set the Locale ID per the browser

    Response.Write "Date/Time Formats"
    Response.Write "<p>Date = " & Date()
    Response.Write "<br>Month = " & Month(Date())
    Response.Write "<br>Day = " & Day(Date())
    Response.Write "<br>Year = " & Year(Date())
    Response.Write "<br>Time = " & Time()

    Response.Write "<p>Currency Formats"
    Response.Write "<p>" & FormatCurrency(1.05, 2)
    Response.Write "<br>" & FormatNumber(1000000,2)
    Response.Write "<br>" & FormatNumber(-1000000,2)
    %>
  </BODY>
</HTML>
```
