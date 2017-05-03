<#
.SYNOPSIS
    Gets the contents of a dialog from a HotDocs component file.
.PARAMETER path
The Path to an XML Component file for HotDocs v. 11 or greater.
.PARAMETER dialog
The name of a dialog stored in the component file.
.PARAMETER before
Text to place before the component
.PARAMETER after
Text to place after the component
.EXAMPLE
get-dialogcontents.ps1 -path "c:\hotdocs\components.cmp" -dialog "Main Interview" -before "HIDE"
.EXAMPLE
get-dialogcontents.ps1 -path "c:\hotdocs\components.cmp" -dialog "Main Interview" -before "SET " -after " TO YES"
.NOTES
	Author: Quinten Steenhuis, 5/3/2017
#>
param(
    [string]$path = "",
    [string]$dialog,
    [string]$before,
    [string]$after
)

[xml]$xml = get-content $path


function get-dialogcontents($xml=$xml, $dialog=$dialog) {
    $xml.componentlibrary.components.dialog | where {$_.name -like $dialog} | foreach {$_.contents.item}
}

function get-dialogcontentsscript($xml=$xml, $dialog=$dialog, $before='',$after='') {
    get-dialogcontents -xml $xml -dialog $dialog | %{write-host "$before" $_.name $after}
}

get-dialogcontentsscript -xml $xml -before $before -after $after -dialog $dialog