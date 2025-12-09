$ErrorActionPreference = 'Stop'
Set-Location -Path (Join-Path $PSScriptRoot ".")

$domains = @('3_info_pl','a_biz_pl','abcpodatki_pl')
$manifestDir = 'post-data'

function Get-PostTitle {
    param([string]$Path)
    # Czytaj niewielki fragment nagłówka (front matter) w UTF-8
    $lines = Get-Content -Path $Path -TotalCount 40 -Encoding UTF8 -ErrorAction SilentlyContinue
    foreach ($line in $lines) {
        if ($line -match '^title:\s*\"?(.+?)\"?\s*$') {
            return $matches[1].Trim()
        }
    }
    return $null
}

foreach ($d in $domains) {
    $items = Get-ChildItem -Path ("post-data/$d") -Filter '*.md' -File -Recurse | ForEach-Object {
        $rel = $_.FullName.Replace((Get-Location).Path + '\', '').Replace('\','/')
        $title = Get-PostTitle -Path $_.FullName
        if (-not $title -or $title -eq '') {
            $title = [System.IO.Path]::GetFileNameWithoutExtension($_.Name).Replace('-',' ')
        }
        [pscustomobject]@{
            path  = $rel
            title = $title
        }
    }

    $json = $items | ConvertTo-Json -Depth 4
    $out = "$manifestDir/$d-index.json"
    Set-Content -Path $out -Value $json -Encoding UTF8
    Write-Host ("Wrote {0} ({1} files)" -f $out, $items.Count)
}

