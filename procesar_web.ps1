# ============================================================================
# SCRIPT DE PROCESAMIENTO DE PLANTILLA WEB
# ============================================================================
# 
# DESCRIPCIÓN:
# Este script procesa un archivo HTML que contiene CSS, JavaScript e imágenes
# embebidas en formato base64, y los separa en archivos externos para mejorar
# la organización y mantenibilidad del código.
#
# FUNCIONES PRINCIPALES:
# 1. Extrae el CSS embebido y lo reemplaza por una referencia externa
# 2. Extrae el JavaScript embebido (jQuery) y lo reemplaza por referencia externa
# 3. Reemplaza todas las imágenes codificadas en base64 por referencias a archivos
#    de imagen ubicados en la carpeta "img/"
#
# AUTOR: Procesamiento automático
# FECHA: 2026-02-05
# ============================================================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PROCESANDO ARCHIVO HTML..." -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# CONFIGURACIÓN DE RUTAS DE ARCHIVOS
# ============================================================================
# Define las rutas absolutas de los archivos que se van a procesar
$htmlPath = "c:\Users\sdelc\Downloads\Web Edifok\index.html"
$cssPath = "c:\Users\sdelc\Downloads\Web Edifok\styles.css"
$jsPath = "c:\Users\sdelc\Downloads\Web Edifok\scrypt.js"
$imgFolder = "c:\Users\sdelc\Downloads\Web Edifok\img"

# ============================================================================
# PASO 1: LEER EL CONTENIDO DEL ARCHIVO HTML
# ============================================================================
# Lee todo el contenido del archivo HTML como una cadena de texto única
# usando codificación UTF-8 para preservar caracteres especiales
Write-Host "[1/4] Leyendo archivo HTML..." -ForegroundColor Yellow
$content = Get-Content $htmlPath -Raw -Encoding UTF8
Write-Host "      Archivo leído correctamente" -ForegroundColor Gray
Write-Host ""

# ============================================================================
# PASO 2: REEMPLAZAR BLOQUE CSS POR REFERENCIA EXTERNA
# ============================================================================
# Busca el bloque <style>...</style> completo (usando regex con flag (?s) para
# que el punto coincida con saltos de línea) y lo reemplaza por una etiqueta
# <link> que referencia al archivo styles.css externo
Write-Host "[2/4] Reemplazando bloque CSS embebido..." -ForegroundColor Yellow
$stylePattern = '(?s)<style>.*?</style>'
$cssLink = '<link rel="stylesheet" href="styles.css">'
$content = $content -replace $stylePattern, $cssLink
Write-Host "      Bloque CSS reemplazado por referencia externa" -ForegroundColor Gray
Write-Host ""

# ============================================================================
# PASO 3: REEMPLAZAR BLOQUE JAVASCRIPT POR REFERENCIA EXTERNA
# ============================================================================
# Busca el primer bloque <script> que contiene jQuery (identificado por el
# comentario /*! jQuery al inicio) y lo reemplaza por una etiqueta <script>
# que referencia al archivo scrypt.js externo
Write-Host "[3/4] Reemplazando bloque JavaScript embebido..." -ForegroundColor Yellow
# Patrón regex que busca el script de jQuery completo
$scriptPattern = '(?s)<script>/\*! jQuery.*?</script>'
$jsLink = '<script src="scrypt.js"></script>'
$content = $content -replace $scriptPattern, $jsLink
Write-Host "      Bloque JavaScript (jQuery) reemplazado por referencia externa" -ForegroundColor Gray
Write-Host ""

# ============================================================================
# PASO 4: REEMPLAZAR IMÁGENES BASE64 POR ARCHIVOS EXTERNOS
# ============================================================================
# Reemplaza todas las imágenes codificadas en base64 por referencias a archivos
# de imagen ubicados en la carpeta img/. Se procesan diferentes tipos de imágenes:
Write-Host "[4/4] Reemplazando imágenes base64..." -ForegroundColor Yellow

# 4.1. LOGOS: Reemplaza imágenes PNG base64 en atributos src por logo.png
# Patrón: src="data:image/png;base64,[cualquier cosa]"
$logoPattern = 'src="data:image/png;base64,[^"]*"'
$logoReplacement = 'src="img/logo.png"'
$content = $content -replace $logoPattern, $logoReplacement
Write-Host "      Logos base64 reemplazados por img/logo.png" -ForegroundColor Gray

# 4.2. IMÁGENES DE FONDO: Reemplaza URLs base64 en propiedades CSS background-image
# Patrón: url("data:image/[cualquier cosa]")
$bgPattern = 'url\("data:image/[^"]*"\)'
$bgReplacement = 'url("img/background.jpg")'
$content = $content -replace $bgPattern, $bgReplacement
Write-Host "      Imágenes de fondo base64 reemplazadas por img/background.jpg" -ForegroundColor Gray

# 4.3. ICONOS SOCIALES: Reemplaza imágenes PNG base64 de iconos sociales
# Patrón: <img src="data:image/png;base64,[cualquier cosa]" alt="">
$iconPattern = '<img src="data:image/png;base64,[^"]*" alt="">'
$iconReplacement = '<img src="img/icon.png" alt="">'
$content = $content -replace $iconPattern, $iconReplacement
Write-Host "      Iconos sociales base64 reemplazados por img/icon.png" -ForegroundColor Gray

# 4.4. IMÁGENES DE PERSONAS/EQUIPO: Reemplaza imágenes JPEG base64 con nombres dinámicos
# Patrón: <img src="data:image/jpeg;base64,[cualquier cosa]"
# Usa un contador para generar nombres únicos: person1.jpg, person2.jpg, etc.
$personPattern = '<img src="data:image/jpeg;base64,[^"]*"'
$personCounter = 1
$content = [regex]::Replace($content, $personPattern, {
    param($match)
    $replacement = '<img src="img/person' + $personCounter + '.jpg"'
    $script:personCounter++
    return $replacement
})
Write-Host "      Imágenes de personas base64 reemplazadas por img/person1.jpg, person2.jpg, etc." -ForegroundColor Gray
Write-Host ""

# ============================================================================
# PASO 5: GUARDAR EL ARCHIVO HTML ACTUALIZADO
# ============================================================================
# Guarda el contenido modificado de vuelta al archivo HTML original
# usando codificación UTF-8 y sin añadir saltos de línea adicionales
Write-Host "Guardando archivo HTML actualizado..." -ForegroundColor Yellow
$content | Set-Content $htmlPath -Encoding UTF8 -NoNewline
Write-Host ""

# ============================================================================
# RESUMEN DEL PROCESO
# ============================================================================
Write-Host "========================================" -ForegroundColor Green
Write-Host "PROCESO COMPLETADO EXITOSAMENTE!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Archivos procesados y generados:" -ForegroundColor Cyan
Write-Host "  ✓ styles.css  - Archivo CSS externo separado" -ForegroundColor White
Write-Host "  ✓ scrypt.js   - Archivo JavaScript externo separado" -ForegroundColor White
Write-Host "  ✓ index.html  - Actualizado con referencias externas" -ForegroundColor White
Write-Host ""
Write-Host "NOTA: Asegúrate de que los archivos de imagen existan en la carpeta img/:" -ForegroundColor Yellow
Write-Host "  - logo.png" -ForegroundColor Gray
Write-Host "  - background.jpg" -ForegroundColor Gray
Write-Host "  - icon.png" -ForegroundColor Gray
Write-Host "  - person1.jpg, person2.jpg, person3.jpg, etc." -ForegroundColor Gray
Write-Host ""
