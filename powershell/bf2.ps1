#!/usr/bin/env pwsh
param (
	$filename
)

if ($filename -ne $null) {
	$program = Get-Content -Raw $filename
} else {
	do {
		$line = [console]::ReadLine()
		$program += $line
	} while ($line -ne $null)
}

$a = @(0) * 30000
$p = 0
$t = @{
	">" = '++$p;';
	"<" = '--$p;';
	"+" = 'if (++$a[$p] -eq 256) { $a[$p] = 0 }';
	"-" = 'if (--$a[$p] -eq -1) { $a[$p] = 255 }';
	"." = 'Write-Host -NoNewline ([char]$a[$p]);';
	"," = '$c = [console]::Read(); if ($c -ne -1) { $a[$p] = $c }';
	"[" = 'while ($a[$p]) {';
	"]" = '}';
}

foreach ($c in [char[]]$program) {
	$eval += $t[[string]$c]
}

Invoke-Expression $eval
