---
title: FAQ about international installations
description: Contains answers to frequently asked questions about international installations of Microsoft Great Plains.
ms.reviewer: kyouells
ms.date: 03/31/2021
---
# Answers to frequently asked questions about international installations of Microsoft Dynamics GP

This article contains answers to some frequently asked questions about international installations of Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 887108

## Introduction

To access the latest information on multilingual installations, see [Multilingual installs in Microsoft Dynamics GP - What you need to know!!](https://community.dynamics.com/blogs/post/?postid=a3fe78ae-d265-4672-8282-a10600329784).

A Multilingual Installation is an environment in which multiple language release installations (unique language code folders) share the same DYNAMICS database, and potentially the same company databases.  Each unique release contains specific words and phrases to match the language of that country/region. As an example, the United Kingdom installation uses "cheque" and a U.S. installation uses the word "check". There are 27 unique languages to choose from when you install Microsoft Dynamics GP.

## More information

**Q1: What is the difference between a localized release and a translated release of Microsoft Dynamics GP?**  

A1: A translated release is translated from English into another language. Each translated release of Microsoft Dynamics GP requires a different set of installation CDs. A localized release is selected during the Microsoft Dynamics GP installation process. A localized release has features that meet the legal and business requirements of the country/region that was selected during installation. The localized versions that are offered during the installation process depend on the language of Microsoft Dynamics GP that is being installed. For example, the United States-English version of Microsoft Dynamics GP offers 27 localized versions.

> [!NOTE]
> Translated releases were introduced in Microsoft Business Solutions-Great Plains 7.0.

**Q2: What translated releases are available?**  

A2: The translated releases that are available per release are listed in the following table.

|Release number|Available translated releases|
|---|---|
|7.5|French-France, French-Canadian, Spanish-Latin America, Spanish-Iberia, German, Dutch-Netherlands|
|8.0|French-Canadian, Spanish-Latin America|
|9.0|French-France, French-Canadian, Spanish-Latin America, Spanish-Iberia, German, Dutch-Netherlands|
|10.0|French-Canadian, Spanish-Latin America|
  
**Q3:What does "translated" mean within Microsoft Dynamics GP releases?**  

A3: "Translated" means that the user interface has been translated to a language other than English. The user interface includes the installation windows, the program menus and windows, and reports.

Which translated language version is installed depends on the installation CDs that are being used. A translated release doesn't include a translation of the data.

For example, if you've a United States installation and a French Canadian installation, and if you enter an item into the inventory module that is named small window, both installations display the data as small window. Because the data isn't translated, the item isn't displayed in the French Canadian installation as the French equivalent, une petite fenetre.

However, if you enter an item from the French Canadian installation as "une petite fenetre," both installations will view the item as "une petite fenetre."

**Q4:Are there any differences between the Microsoft Dynamics GP installations for different countries/regions?**  

A4: There are two differences between the various localized releases. The following differences are based on the country/region that is selected during the installation.

- The following list contains the countries/regions that are available as localized releases during the Microsoft Dynamics GP installation. The various localized releases contain some words and phrases that are changed to match the language of that country/region. For example, the United Kingdom installation uses "cheque" instead of "check."

  - Andean (new in Microsoft Dynamics GP 10.0)
  - Argentina (new in Microsoft Dynamics GP 10.0)
  - Australia
  - Austria
  - Belgium
  - Canada
  - Chile (new in Microsoft Dynamics GP 10.0)
  - China
  - France
  - Germany
  - Hong Kong SAR
  - Indonesia
  - Japan
  - Latin America
  - Luxembourg
  - Malaysia
  - Middle East
  - Netherlands
  - New Zealand
  - Philippines
  - Singapore
  - South Africa
  - Spain
  - Taiwan
  - Thailand
  - United Kingdom and Ireland
  - United States
- Based on the country/region that you select during the installation, different additional sub-features will be available. For example, if you install a Canadian client, you'll have **Canadian Payroll** as an installation option.

- Starting with Microsoft Dynamics GP 9.0, you must create all additional sub-feature tables by using the Microsoft Dynamics GP Utilities program. Therefore, multilingual installations in which different additional sub-features are also installed have special requirements. First, you must install the server components of Microsoft Dynamics GP for each region. Then, you must run Microsoft Dynamics GP Utilities to create the tables.

**Q5:Is it possible to have a multilingual installation?**  

A5: Yes, multilingual installations are possible for translated releases of Microsoft Dynamics GP. A multilingual installation is an environment in which you can have multiple release installations. For example, you can install the United States, United Kingdom, Australia, and French Canadian releases. Additionally, all the installations will use the same DYNAMICS and potentially the same company databases. You should avoid logging on a United Kingdom company database that has a U.S version of Microsoft Dynamics GP together with Cash Book Management. Additionally, this U.S version of Microsoft Dynamics GP isn't running the Cash Book Management code, nor can it load the Cash Book Management code.

> [!NOTE]
>
> - If the client installations will be installed in different physical locations, first verify the remote connectivity configurations that we support. Currently, we support only Microsoft Windows Terminal Server orCitrix technology as remote connectivity options.
> - Perform all client installations at the same service pack level. Because translated service packs are typically released one month after the International English service packs are released, wait until the translated service pack is released before you apply any new service packs.
> - If you have different language installations on one server that has Terminal Services enabled or in one Citrix environment, consider the date format as a potential issue. United States installations display the date in MM/DD/YY format. However, many other installations display the date in DD/MM/YY format. This difference becomes an issue when the operating system of the server can display the date in only one format. Newer versions of Terminal Server and of Citrix let you set the date and the time per user as a workaround.

**Q6:Which service packs do I install for a multilingual installation?**

A6: In a multilingual installation environment, apply the corresponding service pack for the translated release that you've installed on each computer. For example, if you've the United States installation, the Spanish-Latin America installation, and the French Canadian installation, apply the following service packs:

- United States: apply the Microsoft Dynamics GP service pack
- Spanish-Latin America: apply the Microsoft Dynamics GP Spanish-Latin America service pack
- French Canadian: apply the Microsoft Dynamics GP French-Canadian service pack Notes
- Translated service packs are typically released about one month after the United States service packs are released. You should wait until translated service packs are released before you apply any new service packs. It's true even of the service pack for the International English installation because all Microsoft Dynamics GP installations must run the same level of service pack.

**Q7:In a multilingual installation, which installation do I use to update the databases?**  

A7: You must update each company database by using the same server installation that was used to create the company database. If you update the company by using a different installation for that language, you may receive error messages (such as "The audit trail codes cannot be assigned, information is incomplete or missing.") because the Audit Trail codes in the SY01000 table no longer match the Dynamics..Messages table.
The key to success:  The Dynamics database and all company databases should be created/installed/upgraded using one PRIMARY language code folder only. It will ensure the Audit Trail codes match across all company databases within the same SQL instance.

**Q8:How does a multilingual installation affect my audit trail codes?**  

A8: A multilingual installation for Microsoft Dynamics GP does affect audit trail codes. All audit trail codes are based on the original server installation.

In a multilingual install audit trail, codes across companies will be identical and certain steps must be followed:

1. Decide which install will be used for upgrades going forward (See Question 7).
2. Install this version of the client code for the primary language.
3. Create your **first real company** by using DynUtils.

    > [!NOTE]
    > It's insufficient to create the sample company TWO.

4. Start Microsoft Dynamics GP that will populate the MESSAGES table in the DYNAMICS database.
5. Install any other necessary multilingual clients (i.e. secondary language code folder).
6. Start DynUtils before you start Microsoft Dynamics GP to sync the audit trail codes in the messages held within the Dynamics.dic file to the first company created.

> [!NOTE]
> If this steps aren't followed, there can be differences between the audit trail codes from various Dynamics.dic files, from Dynamics..Messages table, and from \<CompanyDB>..SY01000 table which could lead to various issues.

If the secondary language folder was installed before the first real company was created, then it doesn't synchronize correctly and audit trail codes may be incorrect. You can synchronize the audit trail codes in the secondary language code folder by doing the following steps: (Refer to [Multilingual Installs in Microsoft Dynamics GP - What You Need To Know!!](https://community.dynamics.com/blogs/post/?postid=a3fe78ae-d265-4672-8282-a10600329784) to see the below steps in more detail in 'Answer 4' section of the blog.)

1. Make a current backup of the company and Dynamics databases.
2. Delete the Dynamics..MESSAGES table to clear it out.  
    **DELETE DYNAMICS..MESSAGES**  
3. Add this line to the Dex.ini file for ALL language code folders being used in the multilingual environment:  
    **Synchronize=TRUE**  
4. Launch **Utilities** first from the **Primary** language code folder.
5. When Utilities has finished, select **Launch Microsoft Dynamics GP** to launch into the company. It will synchronize the audit trail codes with the primary code folder.
6. Next, launch **Utilities** from the **secondary** language code folder.
7. When Utilities has finished, select **Launch Microsoft Dynamics GP** to launch into the company. It will synch the audit trail codes to the MESSAGES table (that was created from the primary language code folder).
8. Repeat steps 5 and 6 for all other secondary code folders as well.  

**Q9:In a multilingual installation, if a company database was created by using the Spanish-Latin America installation, can a different installation access that database?**

A9: Yes, you can access companies from installations other than the one in which the company was created. Avoid logging into the same company database if different additional sub-features are installed on each client. For example, avoid logging into a United Kingdom company that has Cash Book Management installed with a United States install that doesn't have the Cash Book Management code loaded, nor can it be loaded on the United States install.

> [!NOTE]
> The data for all installations appears in the language in which the data was originally entered into the application. Translated releases translate only the user interface. Translated releases do not translate data.

**Q10:Must I register with Microsoft to obtain translated releases?**

A10: Yes, you must register with Microsoft to obtain translated releases of Microsoft Dynamics GP. To register for a translated release, contact Microsoft Sales Operations at (800) 456-0025.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
