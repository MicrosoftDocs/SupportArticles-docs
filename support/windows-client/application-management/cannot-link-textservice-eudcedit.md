---
title: You cannot link TextService in Eudcedit.exe
description: Resolves an issue in which you cannot link TextService in Eudcedit.exe
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, shfuruka, v-jesits
ms.custom: sap:multilingual-user-interface-mui-and-input-method-editor-ime, csstroubleshoot
---
# You cannot link TextService in Eudcedit.exe

This article helps to resolve an issue in which you cannot link TextService in Eudcedit.exe.  

_Applies to:_ &nbsp; Windows 10, version 2004  
_Original KB number:_ &nbsp; 4568315

## Symptoms

Consider the following scenario:

- You use Windows 10, version 2004.
- You create or modify end-user-defined characters (EUDC) on the computer.
- You try to link the EUDC to Microsoft Bopomofo.

In this scenario, the EUDC editor returns the following message:  
> There is no active TextService that can link to Eudc.

:::image type="content" source="media/cannot-link-textservice-eudcedit/no-active-textservice.png" alt-text="Screenshot of the error message in Private Character Editor." border="false":::

## Cause

After you update to Windows 10, version 2004, Microsoft Bopomofo is updated. The latest version of Microsoft Bopomofo currently doesn't provide the functionality to link EUDC characters.

## Workaround

### Method 1

Turn on the Compatibility option to revert to the previous version Microsoft Bopomofo. To do this, follow these steps:

1. On the **Settings** page, select **Language**.

    :::image type="content" source="media/cannot-link-textservice-eudcedit/language.png" alt-text="Screenshot of the Options in the Chinese (Traditional, Taiwan) item under Language page of Settings.":::

2. Select **Options** for Microsoft Bopomofo (**Chinese (Traditional, Taiwan)**).

    :::image type="content" source="media/cannot-link-textservice-eudcedit/language-options.png" alt-text="Screenshot of the Microsoft Bopomofo option in the Language options: Chinese (Traditional, Taiwan) page.":::

3. Select **General**.

    :::image type="content" source="media/cannot-link-textservice-eudcedit/bopomofo.png" alt-text="Screenshot of the General option in the Microsoft Bopomofo page.":::

4. Turn on the "Use previous version of Microsoft Bopomofo" option.

    :::image type="content" source="media/cannot-link-textservice-eudcedit/previous-bopomofo.png" alt-text="Screenshot of the Use previous version of Microsoft Bopomofo option in the General page.":::

### Method 2

Revert to the previous version of Microsoft Bopomofo by using the following Group Policy setting:
  
**User Configuration** > **Administrative Templates** > **Windows Components** > **IME** > **Configure Traditional Chinese IME version**

:::image type="content" source="media/cannot-link-textservice-eudcedit/ime-version.png" alt-text="Screenshot of the IME group policy setting window." border="false":::

> [!Note]
> This policy was introduced in Windows 10, version 2004.

### Method 3

Revert to the previous version of Microsoft Bopomofo by using MDM Policy. To do this, see [TextInput/ConfigureTraditionalChineseIMEVersion](/windows/client-management/mdm/policy-csp-textinput#textinput-configuretraditionalchineseimeversion).
