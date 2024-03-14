---
title: Description of Language ID global system variable
description: Lists the values of the Language ID global system variable and the corresponding values of the getmsg(9999) function in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:System and Security Setup, Installation, Upgrade, and Migrations
---
# Description of the Language ID global system variable in Microsoft Dynamics GP

This article lists the possible values of the Language ID global system variable and the corresponding values of the `getmsg(9999)` function in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 942751

## More information

Microsoft Dynamics GP uses the Language ID global variable to specify the language and the country/region of the current application instance. When tables contain text that can be displayed to a user, the tables frequently have the Language ID field in the primary key. Therefore, the text can appear in the appropriate language or with the appropriate terminology.

For example, the `SY_Error_Messages_MSTR (DYNAMICS.dbo.SY01700)` table has the Language ID field as its first field. This field handles warning dialog boxes in multiple languages.

The Language ID global variable is set by core Dynamics GP code. This code is based on the value of the message 9999 in the `LanguageID()` global function.

The following table lists the values of the Language ID global variable and the corresponding values of the `getmsg(9999`) function.

|Language ID|Value of the getmsg(9999) function|
|---|---|
|0|English-US|
|1|English-UK|
|2|English-Canada|
|3|English-South Africa|
|4|English-Singapore|
|5|English-Australia|
|6|English-New Zealand|
|7|Polish-Polish|
|8|German-Germany|
|9|German-Austria|
|10|German-Switzerland|
|11|Portuguese-Portugal|
|12|Portuguese-Brazil|
|13|Spanish-Colombia|
|14|Spanish-US|
|15|Spanish-Mexico|
|16|Spanish-Spain|
|17|Spanish-Venezuela|
|18|Spanish-Argentina|
|19|Spanish-Bolivia|
|20|Czech-Czech Republic|
|21|Arabic-UAE|
|22|Arabic-Saudi Arabia|
|23|Chinese-China|
|24|Chinese-Singapore|
|25|Chinese-Hong Kong SAR|
|26|Japanese-Japan|
|27|French-France|
|28|French-Canada|
|29|French-Belgium|
|30|French-Switzerland|
|31|Russian-Russia|
|32|Hebrew-Israel|
|33|Norwegian-Norway|
|34|Swedish-Sweden|
|35|Dutch-Netherlands|
|36|English-Middle East|
|37|English-Netherlands|
|38|English-Belgium|
|39|Dutch-Belgium|
|40|English-UAE|
|41|English-Saudi Arabia|
|42|German-Belgium|
|43|French-Luxembourg|
|44|German-Luxembourg|
|45|English-Luxembourg|
|46|Danish-Denmark|
|47|Finnish-Finland|
|48|Estonian-Estonia|
|49|Lithuanian-Lithuania|
|50|Latvian-Latvia|
|51|English-Thailand|
  
> [!NOTE]
> If you specify a value for the Language ID global variable, the Language ID global variable does not indicate that a translated version of Microsoft Dynamics GP is available.

## References

For more information, see [Guidelines for how to write code that can be easily translated and that can be run in multiple languages in Dexterity in Microsoft Dynamics GP](https://support.microsoft.com/topic/guidelines-for-how-to-write-code-that-can-be-easily-translated-and-that-can-be-run-in-multiple-languages-in-dexterity-in-microsoft-dynamics-gp-2ae38519-d690-bc81-2087-37ae3d6c05b3).
