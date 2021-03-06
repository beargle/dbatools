﻿function Copy-DbaXESessionTemplate {
 <#
    .SYNOPSIS
    Copies non-Microsoft templates from our template repository (\bin\xetemplates\) to $home\Documents\SQL Server Management Studio\Templates\XEventTemplates

    .DESCRIPTION
    Copies non-Microsoft templates from our template repository (\bin\xetemplates\) to $home\Documents\SQL Server Management Studio\Templates\XEventTemplates

    Useful for when you want to use the SSMS GUI

    .PARAMETER Path
    The path to the template directory. Defaults to our template repository (\bin\xetemplates\)

    .PARAMETER Destination
    Path to the Destination directory, defaults to $home\Documents\SQL Server Management Studio\Templates\XEventTemplates

    .PARAMETER EnableException
    By default, when something goes wrong we try to catch it, interpret it and give you a friendly warning message.
    This avoids overwhelming you with "sea of red" exceptions, but is inconvenient because it basically disables advanced scripting.
    Using this switch turns this "nice by default" feature off and enables you to catch exceptions with your own try/catch.

    .NOTES
    Website: https://dbatools.io
    Copyright: (C) Chrissy LeMaire, clemaire@gmail.com
    License: GNU GPL v3 https://opensource.org/licenses/GPL-3.0

    .LINK
    https://dbatools.io/Copy-DbaXESessionTemplate

    .EXAMPLE
    Copy-DbaXESessionTemplate

    Copies non-Microsoft templates from our template repository (\bin\xetemplates\) to $home\Documents\SQL Server Management Studio\Templates\XEventTemplates

    .EXAMPLE
    Copy-DbaXESessionTemplate -Path C:\temp\xetemplates

    Copies your templates from C:\temp\xetemplates to $home\Documents\SQL Server Management Studio\Templates\XEventTemplates

#>
    [CmdletBinding()]
    param (
        [string[]]$Path = "$script:PSModuleRoot\bin\xetemplates",
        [string]$Destination = "$home\Documents\SQL Server Management Studio\Templates\XEventTemplates",
        [switch]$EnableException
    )
    process {
        if (-not (Test-Path -Path $Destination)) {
            try {
                $null = New-Item -ItemType Directory -Path $Destination -ErrorAction Stop
            }
            catch {
                Stop-Function -Message "Failure" -ErrorRecord $_ -Target $Destination
            }
        }
        try {
            $files = (Get-DbaXESessionTemplate -Path $Path | Where-Object Source -ne Microsoft).Path
            foreach ($file in $files) {
                Write-Message -Level Output -Message "Copying $($file.Name) to $Destination"
                Copy-Item -Path $file -Destination $Destination -ErrorAction Stop
            }
        }
        catch {
            Stop-Function -Message "Failure" -ErrorRecord $_ -Target $path
        }
    }
}