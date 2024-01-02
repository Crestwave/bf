#!/usr/bin/env pwsh
param (
	[string]$filename = $(Read-Host)
)

$program = Get-Content -Raw $filename
$jumps = @{}
$stack = [System.Collections.ArrayList]@()

for ($i = 0; $i -lt $program.length; ++$i) {
	switch ($program[$i]) {
		"[" { $null = $stack.Add($i) }
		"]" {
			if ($stack.length -eq 0) {
				Write-Host "UNEXPECTED ]"
			}

			$j = $stack[-1]
			$stack.RemoveAt($stack.count - 1)
			$jumps[$i] = $j
			$jumps[$j] = $i
		}
	}
}

if ($stack.length -gt 0) {
	Write-Host "UNMATCHED ["
}

[console]::TreatControlCAsInput = $true
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
			if ([string]::IsNullOrEmpty($in)) {
				while ($key = $Host.UI.RawUI.ReadKey()) {
					# Backspace
					if ($key.VirtualKeyCode -eq 8 -And $in.length -gt 1) {
						Write-Host -NoNewline `r(" " * $in.length)
						$in = $in.SubString(0, $in.length - 2)
						Write-Host -NoNewline `r$in
					# Ctrl-C
					} elseif ($key.VirtualKeyCode -eq 67 -And $key.Character -ne "c") {
						exit
					# Ctrl-D
					} elseif ($key.VirtualKeyCode -eq 68 -And $key.Character -ne "d") {
						break
					# Newline
					} elseif ($key.VirtualKeyCode -eq 13) {
						$in = $in + "`n"
						break
					}

					$in = $in + [string]$key.Character
				}

				if (! [string]::IsNullOrEmpty($in)) {
					Write-Host
				}
			}

			if (! [string]::IsNullOrEmpty($in)) {
				$tape[$ptr] = [byte][char]$in[0]
				$in = $in.Substring(1)
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
