#!/usr/bin/env pwsh
param (
	$filename
)

if ($filename -ne $null) {
	$program = Get-Content -Raw $filename
} else {
	do {
		$line = [console]::ReadLine()
		$program = $program + $line
	} while ($line -ne $null)
}

$jumps = @{}
$stack = [System.Collections.ArrayList]@()

for ($i = 0; $i -lt $program.length; ++$i) {
	switch ($program[$i]) {
		"[" { $null = $stack.Add($i) }
		"]" {
			if ($stack.count -eq 0) {
				throw "Unexpected token ']'."
			}

			$j = $stack[-1]
			$stack.RemoveAt($stack.count - 1)
			$jumps[$i] = $j
			$jumps[$j] = $i
		}
	}
}

if ($stack.length -gt 0) {
	throw "Unmatched token '['."
}

$tape = @(0) * 30000
$ptr = 0

for ($i = 0; $i -lt $program.length; ++$i) {
	switch ($program[$i]) {
		">" { ++$ptr }
		"<" { --$ptr }
		"+" {
			if (++$tape[$ptr] -eq 256) {
				$tape[$ptr] = 0
			}
		}
		"-" {
			if (--$tape[$ptr] -eq -1) {
				$tape[$ptr] = 255
			}
		}
		"." { Write-Host -NoNewline ([char]$tape[$ptr]) }
		"," {
			$c = [console]::Read()
			if ($c -eq 13) {
				$tape[$ptr] = 10
			} elseif ($c -ne -1) {
				$tape[$ptr] = $c
			}
		}
		"[" {
			if ($tape[$ptr] -eq 0) {
				$i = $jumps[$i]
			}
		}
		"]" {
			if ($tape[$ptr] -ne 0) {
				$i = $jumps[$i]
			}
		}
	}
}
