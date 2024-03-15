---
title: Organization Browser web part does not render for Windows Claims users
description: The Organization Browser webpart does not render the information for Windows Claims users in SharePoint 2010 and SharePoint 2013.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# Organization Browser web part does not render for Windows Claims users

## Symptoms  

When using the Organization Browser Web Part on Windows Claims enabled sites, the web part does not render any information. The same web part renders users with different Claims Authentication types correctly.

## Cause  

The organization information is pulled from the profile database of the User Profile Service Application (UPSA). The required information is stored in the UserProfile_Full table.  

Active Directory users (either added manually or synchronized automatically) are stored in the UPSA Profile Database with NETBIOS\LogonName (*Ex.: CONTOSO\TestUser1*) format.  

When browsing a claims site however, the user context uses the Claims NTName format. (*Ex.: i:0#.w|Contoso\TestUser1*)

The Organization Browser web part then does a database lookup for the user *'i'0#.w|Contoso\TestUser1'*  which is not available in the database since the user information will be stored with the 'CONTOSO\TestUser1' NTName.  

The issue does not happen with any other Claims Authentication type as the Profile Database contains the correct naming format for them.  

## Resolution  

The Organization Browser Web Part control is rendered on the page by the CreateHierarchyChartControl  javascript function. This function is not aware of the fact that the UPSA Profile Database stores the Windows Claims users with a different naming format. To work around this, the below code snippet must be entered in to the site source right after the Organization Browser web part.  

```javascript
<script type="text/javascript">  
 function CreateHierarchyChartControl(parentId, profileId, type, persistControlId) {  
  var i = profileId.indexOf("|");  
  var claimsmode = profileId.substr(i-1,1);  
  if((i >=0 ) & (claimsmode=="w"))  
  {  
   profileId = profileId.substr(i+1,profileId.length-i-1);  
   var initParam = profileId + ',' + type + ',' + persistControlId;  
   var host = document.getElementById(parentId);  
   host.setAttribute('width', '100%');  
   host.setAttribute('height', '100%');  
   Silverlight.createObject('/_layouts/ClientBin/hierarchychart.xap',  
    host,  
    'ProfileBrowserSilverlightControl',  
    {  
     top: '30',  
     width: '100%',  
     height: '100%',  
     version: '2.0',  
     isWindowless: 'true',  
     enableHtmlAccess: 'true'  
    },  
    {  
     onLoad: OnHierarchyChartLoaded  
    },  
     initParam,  
     null);  
    }  
  }  
</script>  
```

### For SharePoint Server 2016

```javascript
  <script type="text/javascript">
            function CreateHierarchyChartControl(parentId, profileId, type, persistControlId, flowDirection, silverLightControlId){
            var i = profileId.indexOf("|");
            var claimsmode = profileId.substr(i - 1, 1);
            if ((i >= 0) & (claimsmode == "w")) {
                profileId = profileId.substr(i + 1, profileId.length - i - 1);
                var initParam = profileId + ',' + type + ',' + persistControlId + ',' + flowDirection + ',' + silverLightControlId;
                var host = document.getElementById(parentId);
                host.setAttribute('width', '100%');
                host.setAttribute('height', '100%');
                Silverlight.createObject('/_layouts/ClientBin/hierarchychart.xap',
                 host,
                 'ProfileBrowserSilverlightControl',
                 {
                     top: '30',
                     width: '100%',
                     height: '100%',
                     version: '2.0',
                     isWindowless: 'true',
                     enableHtmlAccess: 'true'
                 },
                 {
                     onLoad: OnHierarchyChartLoaded
                 },
                  initParam,
                  null);
            }
            }            

        //For html view
            SP.UI.Portal.SimpleProfileBrowser.prototype.$35_0 = function(b, c, d) {
            var i = b.indexOf("|");
            b = b.substr(i + 1, b.length - i - 1);
            var a = $get(c);
            if (a) {
                a.innerHTML = "<DIV></DIV><DIV></DIV><DIV></DIV>";
                this.$m_0 = a.firstChild;
                this.$1C_0 = this.$m_0.nextSibling;
                this.$1a_0 = this.$1C_0.nextSibling
            }
            if (d) {
                this.$m_0.innerHTML = String.format(SpsClient.ScriptResources.silverlight_Install_Message, "<a href='javascript:Silverlight.getSilverlight(\"2.0\");'>Silverlight</a>");
                Sys.UI.DomElement.addCssClass(this.$m_0, "ms-profileBrowserHeaderText");
                Sys.UI.DomElement.addCssClass(this.$m_0.firstChild.nextSibling, "ms-profileBrowserSilverlightLink")
            }
            this.$38_0(b)
        }
       
</script>
```

### Method 1: Add a Content Editor Web Part to the page  

1. Edit the page that contains the Organization Browser web part.
2. Add a Content Editor Web Part right after the Organization Browser Web Part.
3. Edit the content.
4. In the Ribbon, click on HTML/Edit HTML Source under the Format Text tab.
5. Copy-paste the code above.
6. Hide the Chrome and the content of the web part so that it would not appear on the page.

### Method 2: Edit the page in SharePoint Designer  

Please note that this method will detach the page from the site definition, and as such must be used with caution.  

1. Open the page in SharePoint Designer for editing.
2. Change to code view.
3. In the Ribbon, click Advanced Mode
4. Locate the </ SharePoint:EmbeddedFormField> tag.
5. Paste the above code right after the tag.
6. Save your changes.
7. Click Yes in the Site Definition Page Warning window.

## More Information  

Please note that it not possible to overwrite the Html View of the Organization Browser web part from the client. If you need to have a non-Silverlight control available, you will need to write a custom web part to achieve this goal with Windows Claims.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
