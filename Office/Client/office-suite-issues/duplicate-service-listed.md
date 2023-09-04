---
title: Services display incorrectly in Research pane
description: Resolves the issues in which a service is listed two times when you view the list of available services, and a service returns no result when you query that service in the Research pane.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
ms.custom: CSSTroubleshoot
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: amaniah
appliesto: 
  - Office 2013
ms.date: 03/31/2022
---

# In the Research pane in an Office application, a service is listed two times, or a service returns no result

## Symptoms

In a Microsoft Office application, you encounter the following issues.

**Issue 1**

When you view the list of available services in the **Research** pane, some services are listed two times. 

**Issue 2**

When you try to query a service in the
 **Research** pane, the service returns no result. 

## Resolution

### fix Issue 1 

If you want to remove the duplicate services from the list of available services, use one of the following methods: 

- Click the **Get updates to your service** link at the bottom of the **Research** pane, and then follow the instructions. This update process deletes the unnecessary registry subkeys from your computer.    
- For Office 2010, Remove the following registry subkeys:
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{5ECE69BA-86F3-43f1-B120-E16447CBD2F7}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{65D2E288-904F-44b2-B48E-7EC277110D14}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{89B7F815-F3B1-4e57-8AFE-31FE4F5A05F4}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{818435D0-0F60-401d-A48D-C677372AA835}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{F7779C45-973D-45e7-BEB5-E76F40BD0F78}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{D446B35F-9661-4f71-A8FC-2D7D616EA293}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{585D6C55-32A2-4e14-B287-5B0BA7088E00}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{367320E9-4519-4da9-B378-7D558B634090}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{367320E9-4519-4da9-B378-7D558B634090}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{454B7253-3F40-4ff6-9C2C-14DDA1204C4C}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{F6898356-C963-4ada-9221-213AE4DF445D}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{AE88164D-E0DF-4bc6-9B31-4399E9B4E5C5}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{3025A91E-BDA1-4afc-93A0-C8FFA8ED2003}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{C8AB1768-BC24-4789-B87B-33ABA88A8975}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{ECBB7553-2128-4f1c-AAFA-C2F1D6C901BD}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{76848043-AC37-46a4-9654-C87D1B32E406}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{367320E9-4519-4da9-B378-7D558B634090}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{9F872FAC-E33A-47c8-AD04-3B1CEB171DC5}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{DFB0BD92-AC11-4e6f-BDA7-A416B6DA7414}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{ED0B84FD-3B80-47df-AFA9-8B54E8BFEA2F}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{AA117635-24C0-496c-BB57-5D6C9D59D642}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{211A92DA-DED2-4661-AE87-2922D1E2B469}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{E448A4AB-4ACF-4ccf-A365-F6A63BF534C5}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{C4377FE1-C723-41ce-9762-BA586264C55D}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{3512B6DB-8584-4c67-B0DF-EDD2336DB9F9}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{D7AA4AAD-77E7-4395-ACD0-9BC433D7AD65}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{F0E4682C-D691-4aa1-889F-42695D10AB3C}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{7BDFFF98-CE78-44db-AFA2-E346A772AEEC}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{F2E268F1-CE89-462f-AFBD-FD9BD89EAA1F}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{713E807F-7120-4875-919B-96BAA6ED8623}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{E475B1FE-0503-4930-8363-2677B46620C1}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{482E0230-8560-41fe-8584-07B3959847DA}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{934E2429-BC83-4ffb-B3A2-6761EC6870DE}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{5B6013C8-5C36-47d4-9AC0-22DBC558E5CB}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{2EF9BA38-C64D-4d08-8287-EB9B2F34D0E9}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{431EDE57-B54B-49fb-A944-76201F746749}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{67D50A84-401A-42c1-801A-029435E34615}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{FBEEEE40-FB96-4a4b-9D02-D293FF69FC07}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{C8DF8ECA-78C5-4073-88D0-A24585AB987A}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{A9167F26-9553-416d-B94E-1F6D9A2EEC3C}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{DA0B6D82-B161-4190-8878-AA5D07F94C9F}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{E13847DA-E186-427a-94D0-AA01163D80CE}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{6AEF5596-203D-4817-A17B-8A4810BF5D33}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{05EA20D9-18DC-4446-A9F8-F6C5161357CE}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{19BC3378-2319-4C50-990A-17600534DFF9}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{B5D49EBC-FE1A-445B-9517-A83E91E2D73A}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{C41C2E15-6852-4EA4-82D2-12E88D3E1E9F}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{8D650B1E-285A-4868-8AA6-B089C994ABE5 }**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{8B0C3669-CA5C-42AD-8FF7-B05E7ADE2242}**   
  - **HKEY_CURRENT_USER\Software\Microsoft\Office\14.0\Common\Research\Sources\{88686849-2DD9-474D-9300-778E3336FA5D}\\{C8ED648C-A5ED-4402-A55D-921D1CF1079A}**   
   
-  For Office 2013, remove all of the subkeys under the following registry entry:
   
   HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\Research\Sources\\{88686849-2DD9-474D-9300-778E3336FA5D}\ 
- If you do not want to update the registry or you cannot update the registry, disable the service so that it does not appear in the list in the **Research**pane. To do this, click the **Research options** link at the bottom of the **Research** pane, and then click to clear the check box that is next to the service name.    

### fix Issue 2

If the Research pane is not showing any available services and research sites, make sure you are connected to the internet, and then follow these steps:

- lick the Research options link at the bottom of the Research pane.   
- Select Update/Remove.   
- lick Update   
- When the services have been updated, select Close.   
- lick the check box of the service name you want to add   


## Did this fix the problem? 

Check whether the problem is fixed by viewing the list of available services or by querying the service in the **Research** pane. If the problem is fixed, you are finished with this article. If the problem is not fixed, you can contact us by clicking the following link:

[Contact support](https://support.microsoft.com/contactus)   

