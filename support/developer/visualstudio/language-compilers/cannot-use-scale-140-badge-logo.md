---
title: Can't use the Scale-140 badge logo
description: Works around problems in which you can't use the Scale-140 badge logo in Visual Studio 2012 Update 1.
ms.date: 04/27/2020
ms.custom: sap:Language or Compilers\Other
ms.reviewer: pchapman, rezac, rilee
---
# You can't use the Scale-140 badge logo in Visual Studio 2012 Update 1

This article helps you resolve a problem where you can't use the Scale-140 badge logo in Microsoft Visual Studio 2012 Update 1.

_Original product version:_ &nbsp; Visual Studio Express 2012 for Windows 8, Visual Studio Premium 2012, Visual Studio Ultimate 2012  
_Original KB number:_ &nbsp; 2792380

## Issue 1

Consider the following scenario:

- You create an app by using Visual Studio 2012 Update 1.
- You select a 33 x 33 pixel .png file for the Scale-140 badge logo for the app.
- You try to package the app.

In this scenario, you can't package the app. Additionally, you receive an error message that resembles the following:

> App manifest references badge logo image 'images\BadgeLogo.scale-140.png' which has not valid dimensions. It must be 34x34 pixels.

## Issue 2

Consider the following scenario:

- You create an app by using Visual Studio 2012 Update 1.
- You select a 34 x 34 pixel *.png* file for the Scale-140 badge logo for the app.
- You try to submit this app to the Windows Store.

In this scenario, you can't submit the app to the Windows Store.

## Cause

These issues occur because Visual Studio 2012 Update 1 incorrectly requires a .png file that is 34 x 34 pixels for the Scale-140 badge logo. However, the Windows Store and the Windows App Certification Kit (WinACK) require that image files for the Scale-140 badge logo be 33 x 33 pixels.

## Workaround

To work around this issue, follow these steps:

1. In Solution Explorer, right-click the project, and then select **Unload Project**.
2. Right-click the project, and then select **Edit**.
3. Add the following XML code to the bottom of the project file before the closing `</Project>` element:

    ```xml
    <!-- Workaround for 33x33 badge logo issue. -->
    <Target Name="WorkaroundForBadgeLogoScale140Issue">
        <ItemGroup>
            <AppxManifestImageFileNameQuery Remove="./m:Package/m:Applications/m:Application/m:VisualElements/m:LockScreen/@BadgeLogo" />
        </ItemGroup>
        <ItemGroup>
            <AppxManifestImageFileNameQuery Include="./m:Package/m:Applications/m:Application/m:VisualElements/m:LockScreen/@BadgeLogo">
                <DescriptionID>BadgeLogo</DescriptionID>
                <ExpectedScaleDimensions>100:24x24;140:33x33;180:43x43</ExpectedScaleDimensions>
            </AppxManifestImageFileNameQuery>
        </ItemGroup>
    </Target>
    ```

4. Add the following XML code to the bottom of the project file before the closing `</Project>` element:

    > [!NOTE]
    > If your project file already contains a `BeforeBuild` target, add `WorkaroundForBadgeLogoScale140Issue` to the `DependsOnTargets` attribute.

    ```xml
    <Target Name="BeforeBuild" DependsOnTargets="WorkaroundForBadgeLogoScale140Issue" />
    ```

5. Save and close the project file.
6. In Solution Explorer, right-click the project, and then select **Reload Project**.
7. In Manifest Designer, add a Scale-140 logo .png file that is 33 x 33 pixels.

> [!NOTE]
> Manifest Designer will display a warning that the badge logo does not meet the required size of 34 x 34 pixels. However, Visual Studio will package the app, and WinACK enables you to publish the app to the Windows Store.
