---
title: The default setting for MediaType in PSA isn't applied
description: Provides a workaround for an issue where the default setting for MediaType in the print support app isn't applied.
ms.date: 09/06/2024
ms.reviewer: riwaida
ms.author: haiyingyu
author: HaiyingYu
ms.custom: sap:Windows Store app UI
---
# The default setting for MediaType in the print support app isn't applied

This article helps you work around an issue where the default setting for MediaType in the [print support app (PSA)](/windows-hardware/drivers/devapps/print-support-app-design-guide) isn't applied in some specific scenarios.

## Symptoms

Consider the following scenario:

- You're developing a PSA for IPP-based printers.
- The PSA runs on Windows 10, version 22H2 or Windows 11, version 23H2.
- You add extra PageMediaType options to the Print Device Capabilities (PDC) in the `PrintSupportExtensionSession.PrintDeviceCapabilitiesChanged` event handler of the PSA.

In this scenario, the default option isn't selected as expected when the print settings screen in the PSA is first displayed. Once the settings are saved, the issue no longer occurs.

For instance, you add a `ContosoMediaType` to the `PageMediaType` feature and configure the print ticket as follows. In this case, `AutoSelect`, which is set to the default value of `true` in the Print Schema, should be the default setting, but another option is used as the default setting instead.

```xml
<!-- media-type-supported -->
<psk:PageMediaType psf2:psftype="Feature">
    <psk:AutoSelect psf2:psftype="Option" psf2:default="true"/>  <!--Set the default value for AutoSelect-->
    <psk:PhotographicGlossy psf2:psftype="Option" psf2:default="false"/>
    <psk:Photographic psf2:psftype="Option" psf2:default="false"/>
    <contoso:ContosoMediaType psf2:psftype="Option" psf2:default="false"/>
</psk:PageMediaType>
```

## Cause

This issue occurs because *Windows.Graphics.Printing.Workflow.dll* doesn't correctly convert the PDC to a print ticket. It's a problem with the Windows Print Workflow service.

## Workaround

To work around this issue, save the default option in the `PrintSupportExtensionSession.PrintDeviceCapabilitiesChanged` event handler of the PSA and restore the saved value when initializing the print settings dialog. The code samples in the following steps are based on the generic PSA samples provided by Microsoft.

1. Add the following code to the `LocalStorageUtil` class in the background task of the PSA:

    ```csharp
    // Method to check if the default option has already been set in the PrintTicket
    public static bool IsAlreadyLoadedDefaultValue()
    {
        try
        {
            return (bool)ApplicationData.Current.LocalSettings.Values["IsLoadedDefaultValue"];
        }
        catch (NullReferenceException e)
        {
            return false;
        }
    }

    // Method to indicate that the default option has been applied to the PrintTicket
    public static void LoadedDefaultValue(bool _bLoaded)
    {
        ApplicationData.Current.LocalSettings.Values["IsLoadedDefaultValue"] = _bLoaded;
    }

    // Method to save the default option value of the specified feature
    public static void SetPdcDefaultValue(string _Feature, string _DefaultValue)
    {
        System.Diagnostics.Debug.WriteLine("SetPdcDefaultValue: Feature=" + _Feature + ", Default=" + _DefaultValue);
        ApplicationData.Current.LocalSettings.Values[_Feature] = _DefaultValue;
    }

    // Method to return the default option value of the specified feature
    public static string GetPdcDefaultValue(string _Feature)
    {
        try
        {
            return (string)ApplicationData.Current.LocalSettings.Values[_Feature];
        }
        catch (NullReferenceException e)
        {
            System.Diagnostics.Debug.WriteLine(e.Message);
            return null;
        }
    }
    ```

1. In the `PrintSupportExtensionSession.PrintDeviceCapabilitiesChanged` event handler, call the `SaveDefaultValues()` method to save the default values set in the PDC.

    ```csharp
    private void OnSessionPrintDeviceCapabilitiesChanged(PrintSupportExtensionSession sender, PrintSupportPrintDeviceCapabilitiesChangedEventArgs args)
    {
        var pdc = args.GetCurrentPrintDeviceCapabilities();
        // Add the custom namespace URI to the XML document.
        pdc.DocumentElement.SetAttribute("xmlns:contoso", "http://schemas.contoso.com/keywords");
        // Add the custom media type.
        AddCustomMediaType(ref pdc, "http://schemas.contoso.com/keywords", "contoso:ContosoMediaType");

        // Call the method to save the default values of the PDC.
        SaveDefaultValues(ref pdc);

        args.UpdatePrintDeviceCapabilities(pdc);
        args.SetPrintDeviceCapabilitiesUpdatePolicy(
            PrintSupportPrintDeviceCapabilitiesUpdatePolicy.CreatePeriodicRefresh(System.TimeSpan.FromMinutes(1)));
        args.GetDeferral().Complete();
    }
    ```

1. Initialize the ComboBox items during the initial setup by using the default values saved in the `LocalStorageUtil` class.

    ```csharp
    private ComboBox CreatePrintTicketFeatureComboBox(PrintTicketFeature feature, bool useDefaultEventHandler = true)
    {
        if (feature == null)
        {
            return null;
        }

        var comboBox = new ComboBox
        {
            // Header is displayed in the UI, on top of the ComboBox.
            Header = feature.DisplayName
        };
        // Construct a new list since IReadOnlyList does not support the 'IndexOf' method.
        var options = new ObservableCollection<PrintTicketOption>(feature.Options);
        // Provide the combo box with a list of options to select from.
        comboBox.ItemsSource = options;
        // Set the selected option to the option set in the print ticket.
        PrintTicketOption selectedOption;

        // Load the default value of the PDC from LocalStorageUtil only once.
        string defaultOption = LocalStorageUtil.GetPdcDefaultValue(feature.Name);
        if (!LocalStorageUtil.IsAlreadyLoadedDefaultValue() && defaultOption != null)
        {
            selectedOption = options[0];
            foreach (var option in options)
            {
                if (option.Name == defaultOption)
                {
                    selectedOption = option;
                    break;
                }
            }
        }
        else
        {
            var featureOption = feature.GetSelectedOption();
            try
            {
                selectedOption = options.Single((option) => (
                    option.Name == featureOption.Name && option.XmlNamespace == featureOption.XmlNamespace));
            }
            // Catch exceptions, because there can be multiple features with the "None" feature name.
            // We need to handle those features separately.
            catch (System.SystemException exception)
            {
                var nameAttribute = featureOption.XmlNode.Attributes.GetNamedItem("name");
                var attribute = featureOption.XmlNode.OwnerDocument.CreateAttribute("name");

                selectedOption = options.Single((option) => (
                    option.DisplayName == featureOption.DisplayName
                    && option.Name == featureOption.Name
                    && option.XmlNamespace == featureOption.XmlNamespace));
            }
        }

        comboBox.SelectedIndex = options.IndexOf(selectedOption);

        // Indicate that we have completed loading the default value from LocalStorageUtil.
        LocalStorageUtil.LoadedDefaultValue(true);
        // ...
    }
    ```
