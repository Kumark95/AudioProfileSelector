<#
.SYNOPSIS
    Audio profile setter.
.DESCRIPTION
    Set different profiles for audio.
.NOTES
    Author: Cristhian Rivera
    Date:   July 11, 2021
#>
function Set-AudioProfile
{
    Param(
        [Parameter(Mandatory=$true)]
        [ValidateSet('Normal', 'Meeting')]
        [String]
        $Profile
    )
    Process
    {
        Write-Output "Profile selected: $Profile"

        switch($profile)
        {
            # To get the device IDs "Get-AudioDevice -List | ft"
            'Normal' {
                Set-MicrophoneAccess $false
                $audioDeviceId = "{0.0.0.00000000}.{3adb2d60-408d-43ef-951f-3d0fec28635a}"
            }
            'Meeting' {
                Set-MicrophoneAccess $true
                $audioDeviceId = "{0.0.0.00000000}.{417b94c4-455e-4d19-93dc-3fd438223e0f}"
            }
        }

        Write-Output "Changing audio device to: $audioDevice"
        Set-AudioDevice -ID $audioDeviceId

        # Alternatively using the deviceName: "Get-AudioDevice -List | where Name -EQ $audioDeviceName | Set-AudioDevice"
        # Currently has issues with UTF-8 strings
    }
}

function Set-MicrophoneAccess
{
    Param(
        [boolean]$allow
    )
    Process
    {
        switch ( $allow )
        {
            $true { $action = 'Allow' }
            $false { $action = 'Deny' }
        }

        Write-Output "Setting microphone access to: $action"

        $regKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone"
        Set-ItemProperty -Path $regKey -Name Value -Value $action
    }
}
