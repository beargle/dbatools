﻿function Get-DbaXESmartTarget {
 <#
    .SYNOPSIS
    Gets an XESmartTarget PowerShell Job created by Start-DbaXESmartTarget.
    
    .DESCRIPTION
    Gets an XESmartTarget PowerShell Job created by Start-DbaXESmartTarget.
    
    .PARAMETER EnableException
    By default, when something goes wrong we try to catch it, interpret it and give you a friendly warning message.
    This avoids overwhelming you with "sea of red" exceptions, but is inconvenient because it basically disables advanced scripting.
    Using this switch turns this "nice by default" feature off and enables you to catch exceptions with your own try/catch.

    .NOTES
    Website: https://dbatools.io
    Copyright: (C) Chrissy LeMaire, clemaire@gmail.com
    License: GNU GPL v3 https://opensource.org/licenses/GPL-3.0
    SmartTarget: by Gianluca Sartori (@spaghettidba)

    .LINK
    https://dbatools.io/Get-DbaXESmartTarget
    https://github.com/spaghettidba/XESmartTarget/wiki

    .EXAMPLE
    Get-DbaXESmartTarget
    
    Gets an XESmartTarget PowerShell Job created by Start-DbaXESmartTarget

#>
    [CmdletBinding()]
    param (
        [switch]$EnableException
    )
    process {
        try {
            Get-Job | Where-Object Name -Match SmartTarget | Select-Object -Property ID, Name, State
        }
        catch {
            Stop-Function -Message "Failure" -ErrorRecord $_
        }
    }
}