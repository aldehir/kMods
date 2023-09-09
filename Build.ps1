$dir = (Get-Item $PSCommandPath).DirectoryName
$name = split-path -Leaf $dir

Write-Output "Project: $name"

Get-Item ..\System\$name.* | Remove-Item

Start-Process -NoNewWindow -WorkingDirectory "..\System" -Wait `
  ..\System\UCC.exe @("make", "-ini=$dir\Build.ini")


if (!(Test-Path System)) {
  New-Item -Path System -ItemType Directory
}

Copy-Item -Path ..\System\$name* -Destination System
