---
title: Generate and export a Support Data package
description: Describes how to generate and export a Support Data package to the BlueStripe support team.
ms.date: 08/13/2020
ms.custom: linux-related-content
---
# How to generate and export a Support Data package to the BlueStripe support team

If you're experiencing problems with FactFinder, it might be necessary to export a Support Data (SD) package so that it can be analyzed by the BlueStripe support team.

_Original product version:_ &nbsp; BlueStripe  
_Original KB number:_ &nbsp; 3134891

To collect SD, you can either use the FactFinder console's graphical user interface (GUI) to generate the SD, or you can manually run the SD collection script locally on each component.

## Generate SD using the console

There are two ways to generate SD using the console GUI. One way generates collector SD, while the other generates SD for the console and management server.

### Generate SD for collectors using the console GUI

1. In the console, select **Tools** -> **Administration** to open the **Collector Management** dialogue box.

2. Select the collector(s) for which you want to collect SD by checking the box next to the IP address.

3. Once you've selected the collector(s), select **Support Data**.

4. If you have a support case already open, include the support case number in the field provided.

    :::image type="content" source="media/generate-export-support-data-package/create-sd-for-collectors.png" alt-text="The Export Support Data Package page that you can use to generate SD for collectors." border="false":::

5. Choose **Save + Send to BlueStripe** that will automatically upload the SD to the File Transfer Protocol (FTP) server.

### Generate SD for the console or management server using the console GUI

1. In the console, select **Help ? 'Export Support Data Package'** that opens the SD prompt.

2. If you have a support case already open, include the support case number in the field provided.

    :::image type="content" source="media/generate-export-support-data-package/create-sd-for-console-or-management-server.png" alt-text="The Export Support Data Package page that you can use to collect SD from the console, management server." border="false":::

    By default, this method will collect SD from the console, management server and all of the collectors.

    > [!NOTE]
    > Checking **Also gather summary data from collectors** will retrieve data from every collector being managed by the management server, and isn't typically recommended.

3. Once you've selected what components to collect SD for, select **Save + Send to BlueStripe** to automatically FTP the results to support.

## Collect SD manually in Windows

Sign in to the machine for which you would like to collect SD. Make sure you have Administrator privileges.

For Windows machines, run the `CollectBlueStripeData.vbs` script located in the scripts directory of the installation path. For FactFinder version 8 or later, if you have an open support ticket, include the ticket number using the following command-line interface (CLI) argument: `--case <ticket number>`

Example:

```console
CollectBlueStripeData.vbs --case 1234
```

Location of SD collection script:

- Console: `C:\Program Files\BlueStripe\FactFinder\Console\scripts`

- Java Web Start console: `%AppData%\BlueStripe\FactFinderConsole-guid\scripts`

- Management server: `C:\Program Files\BlueStripe\FactFinder\Server\scripts`

- DB loader: `C:\Program Files\BlueStripe\FactFinder\DBLoader\scripts`

- Windows collector: `C:\Program Files\BlueStripe\Collector\scripts`

These scripts will generate the SD file locally on the machine. Then, you can upload the SD file to the FTP server.

## Collect SD manually in AIX, Solaris, or Linux

For an AIX, Solaris, or Linux collectors, run the `collect-bluestripe-data.sh` script located in the `/usr/lib/bluestripe-collector/scripts/` directory.

Sign in to the machine for which you would like to collect SD. Make sure you have root or sudo privileges.

The script will generate the SD file locally on the machine, which you can then upload to the FTP server. Unless the `--file <filename>` option is used with the script, the Support Data package is saved to `/var/log/bluestripe-collector` (if root) under the collector's installation directory, or to the home directory of the user running the script (non-root).

For FactFinder version 8 or later, if you have an open support ticket, include the ticket number using the `--case=<case number>` option:

Example:

```console
collect-bluestripe-data.sh --case=1234
```

Location of SD collection script:

- AIX, Solaris, or Linux collectors: `/usr/lib/bluestripe-collector/scripts/`

- Management server: `/usr/lib/bluestripe-management-server/scripts/`

- DB loader: `/usr/lib/bluestripe-db-loader/scripts/`

## Upload the SD output

> Connection: FTP or FTPS [FTP Secure - using TLS or SSL]  
> Hostname: sd.bluestripe.com  
> Username: sdftp  
> Password: SD_uploads
