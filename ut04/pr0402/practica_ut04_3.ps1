$codigoActivo = "SRV-2026-PROD-99"

$like = $codigoActivo -like "SRV*"
Write-Host "¿Empieza por SRV?: $like"

$numeros = $codigoActivo -match "\d"
Write-Host "¿Contiene algun digito numerico?: $numeros"

$x = $codigoActivo -replace "\d", "X"
Write-Host "Codigo modificado: $x"