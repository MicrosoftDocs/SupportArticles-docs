---
title: Script errors after applying update
description: Fixes script errors after your Microsoft Dynamics CRM Online organization is updated to the December 2012 Service Update.
ms.reviewer: dmartens
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: d365-sales-server
---
# Client-side scripts no longer work in Microsoft Dynamics CRM Online after the December 2012 Service Update

This article helps you fix script errors after your Microsoft Dynamics CRM Online organization is updated to the December 2012 Service Update.

_Applies to:_ &nbsp; Microsoft Dynamics CRM Online  
_Original KB number:_ &nbsp; 2804561

## Symptoms

If your forms use the V4.0 client API (crmForm), you may encounter script errors after your Microsoft Dynamics CRM Online organization is updated to the December 2012 Service Update. You may see a dialog appear that says "Undefined", or you may see an error in the bottom-left corner of the form that says "Error on page". Other various script errors may appear.

## Cause

The December 2012 Service Update for Microsoft Dynamics CRM introduced a new System Setting that controls whether or not HTML Components (HTC) are included in Microsoft Dynamics CRM forms. This setting is disabled by default in Microsoft Dynamics CRM Online.

The following crmForm properties require HTC:

|CrmForm properties|
|---|
|.Save(|
|.SaveAndClose(|
|.FormType|
|.ObjectTypeCode|
|.ObjectId|
|.ObjectTypeName|
|.RequiredLevel|
|.SetFocus(|
|.FireOnChange|
|.Min|
|.Max|
|.DataValue|
|.isDirty|
|.Disabled|
|.SelectedOption|
|.SelectedText|
|.SortingEnum|
|.Sort|
|.SelectedIndex|
|.InnerText|
|.OptionsXml|
|.Precision|
|.DataXml|
|.Text|
|.Value|
|.DisplayValue|
|.WillSubmit|
|.DataChangeHandler|
|.BypassValidation|
|.AllowFormFocus|
|._bSaving|
|._htcInitCompleted|
|.SubmitFormId|
|.NO_DATA|
|.RefreshOnSave|
|.Visible|
|.ForceSubmit|
|.Form|
|.TimeControl|
|.isInitialized|
|.allowblankdate|
|.IsMoney|
|.IsBaseCurrency|
|.CurrencySymbol|
|.CurrencyPrecision|
|.IgnoreCurrencySymbol|
|.IgnoreRange|
|.PrecisionChangeHandler|
|.TrimValue|
|.MaxLength|
|Enumerator|

## Resolution

1. Sign in to the Microsoft Dynamics CRM web application as a System Administrator.
2. Click **Settings**, click **Administration**, and then click **System Settings**.
3. Click the **Customization** tab.
4. Click the checkbox next to the setting labeled **Include HTC Support in Microsoft Dynamics CRM forms**.
5. Click **OK**.

## More information

The crmForm API was deprecated with the Microsoft Dynamics CRM 2011 release. For more information about this topic and other potential causes of script errors after the December 2012 Service Update, see the following Blog posts:

- [Resolve Breaking Script Issues When Upgrading Microsoft Dynamics CRM](https://community.dynamics.com/blogs/post/?postid=6983b51b-486e-4c3a-8a9c-de1419d0a706)
- [Microsoft Dynamics CRM 2011 Custom Code Validation Tool Released](https://cloudblogs.microsoft.com/dynamics365/no-audience/2012/06/21/microsoft-dynamics-crm-2011-custom-code-validation-tool-released/)

