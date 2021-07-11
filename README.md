# Audio Profile Selector

Basic scrict to automate a transition between two (current) profiles:

* Normal
    * Microphone access OFF
    * Audio output device changed to Speakers
* Meeting
    * Microphone access ON
    * Audio output device changed to headphones

## Attribution
This script uses AudioDeviceCmdlets to control the audio devices:

<https://github.com/frgnca/AudioDeviceCmdlets>

## Import
First import AudioDeviceCmdlets.
See: <https://github.com/frgnca/AudioDeviceCmdlets/blob/master/README.md#import-cmdlet-to-powershell>

Then import the provided module
```PowerShell
New-Item "$($profile | split-path)\Modules\AudioProfileSelector" -Type directory -Force
Copy-Item "C:\Path\to\AudioProfileSelector.psm1" "$($profile | split-path)\Modules\AudioProfileSelector\AudioProfileSelector.psm1"
Set-Location "$($profile | Split-Path)\Modules\AudioProfileSelector"
Get-ChildItem | Unblock-File
Import-Module AudioProfileSelector
```


## Usage
```PowerShell
# Sets the profile. Currently only "Normal" or "Meeting"
Set-AudioProfile <string>
```

## Notes
The script was developed for a custom use case. The device IDs will change from machine to machine. To retrieve:

```PowerShell
Get-AudioDevice -List  | Format-Table Index, Default, Type, Id, Name
```