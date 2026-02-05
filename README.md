# Documentación del Proyecto Web Edifok

## 📋 Descripción del Proyecto

Este proyecto contiene una plantilla web HTML5 que ha sido refactorizada para mejorar su organización y mantenibilidad. El archivo original `index.html` contenía todo el código CSS, JavaScript e imágenes embebidas en formato base64, lo cual hacía el archivo muy grande y difícil de mantener.

## 🎯 Objetivos de la Refactorización

La refactorización se realizó con los siguientes objetivos:

1. **Separar el CSS** en un archivo externo (`styles.css`)
2. **Separar el JavaScript** en un archivo externo (`scrypt.js`)
3. **Reemplazar imágenes base64** por referencias a archivos de imagen en la carpeta `img/`
4. **Mejorar la mantenibilidad** del código para facilitar futuras ediciones

## 📁 Estructura de Archivos

```
Web Edifok/
│
├── index.html          # Archivo HTML principal (refactorizado)
├── styles.css          # Archivo CSS externo (extraído del HTML)
├── scrypt.js           # Archivo JavaScript externo (jQuery y scripts personalizados)
├── procesar_web.ps1    # Script PowerShell para procesar el HTML
├── README.md           # Este archivo de documentación
│
└── img/                # Carpeta con archivos de imagen
    ├── logo.png        # Logo principal del sitio
    ├── background.jpg  # Imagen de fondo
    ├── icon.png        # Iconos sociales genéricos
    ├── person1.jpg     # Imagen de persona/equipo 1
    ├── person2.jpg     # Imagen de persona/equipo 2
    ├── person3.jpg     # Imagen de persona/equipo 3
    └── ...             # Más imágenes según sea necesario
```

## 🔧 Cambios Realizados

### 1. Separación del CSS

**Antes:**
```html
<style>
  /* Cientos de líneas de CSS embebido */
</style>
```

**Después:**
```html
<link rel="stylesheet" href="styles.css">
```

- **Archivo generado:** `styles.css`
- **Contenido:** Todo el CSS que estaba embebido en el `<style>` del HTML original
- **Ubicación original:** Líneas 18-975 del `index.html` original

### 2. Separación del JavaScript

**Antes:**
```html
<script>
  /* jQuery y scripts embebidos */
</script>
```

**Después:**
```html
<script src="scrypt.js"></script>
```

- **Archivo generado:** `scrypt.js`
- **Contenido:** jQuery v1.10.2 y scripts personalizados que estaban embebidos
- **Ubicación original:** Primer bloque `<script>` del HTML original (líneas 1912-1918)

### 3. Reemplazo de Imágenes Base64

**Antes:**
```html
<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAA..." alt="">
```

**Después:**
```html
<img src="img/logo.png" alt="">
```

#### Tipos de imágenes reemplazadas:

1. **Logos:** Todas las imágenes PNG base64 → `img/logo.png`
2. **Imágenes de fondo:** URLs base64 en CSS → `img/background.jpg`
3. **Iconos sociales:** Imágenes PNG base64 de iconos → `img/icon.png`
4. **Imágenes de personas/equipo:** Imágenes JPEG base64 → `img/person1.jpg`, `img/person2.jpg`, etc. (numeración automática)

## 🚀 Uso del Script de Procesamiento

El script `procesar_web.ps1` automatiza todo el proceso de refactorización. Para ejecutarlo:

### Requisitos Previos

- Windows PowerShell (versión 3.0 o superior)
- Permisos de lectura/escritura en la carpeta del proyecto

### Ejecución

1. Abre PowerShell
2. Navega a la carpeta del proyecto:
   ```powershell
   cd "c:\Users\sdelc\Downloads\Web Edifok"
   ```
3. Ejecuta el script:
   ```powershell
   .\procesar_web.ps1
   ```

### ¿Qué hace el script?

El script realiza las siguientes operaciones automáticamente:

1. ✅ Lee el archivo `index.html` completo
2. ✅ Reemplaza el bloque `<style>` por `<link rel="stylesheet" href="styles.css">`
3. ✅ Reemplaza el bloque `<script>` de jQuery por `<script src="scrypt.js"></script>`
4. ✅ Reemplaza todas las imágenes base64 por referencias a archivos en `img/`
5. ✅ Guarda el archivo `index.html` actualizado

## 📝 Archivos de Imagen Requeridos

Para que el sitio web funcione correctamente, asegúrate de tener los siguientes archivos en la carpeta `img/`:

| Archivo | Descripción | Tipo |
|---------|-------------|------|
| `logo.png` | Logo principal del sitio | PNG |
| `background.jpg` | Imagen de fondo para secciones | JPG |
| `icon.png` | Iconos sociales genéricos | PNG |
| `person1.jpg` | Primera imagen de persona/equipo | JPG |
| `person2.jpg` | Segunda imagen de persona/equipo | JPG |
| `person3.jpg` | Tercera imagen de persona/equipo | JPG |
| ... | Más imágenes según sea necesario | JPG |

**Nota:** Si alguna de estas imágenes no existe, deberás crearlas o reemplazarlas con imágenes reales. El script solo reemplaza las referencias base64, no crea los archivos de imagen.

## 🔍 Verificación de Cambios

Para verificar que los cambios se aplicaron correctamente:

1. **Verificar CSS externo:**
   ```powershell
   Test-Path "styles.css"
   ```

2. **Verificar JavaScript externo:**
   ```powershell
   Test-Path "scrypt.js"
   ```

3. **Verificar que no queden imágenes base64:**
   ```powershell
   Select-String -Path "index.html" -Pattern "data:image" | Measure-Object
   ```
   (Debería devolver 0 coincidencias)

4. **Verificar referencias a imágenes:**
   ```powershell
   Select-String -Path "index.html" -Pattern 'src="img/' | Measure-Object
   ```
   (Debería devolver múltiples coincidencias)

## 🛠️ Edición Futura

Ahora que el código está separado, puedes editar cada parte de forma independiente:

### Para editar estilos:
- Abre `styles.css` en tu editor favorito
- Realiza los cambios necesarios
- Los cambios se aplicarán automáticamente al recargar la página

### Para editar JavaScript:
- Abre `scrypt.js` en tu editor favorito
- Realiza los cambios necesarios
- Los cambios se aplicarán automáticamente al recargar la página

### Para cambiar imágenes:
- Reemplaza los archivos en la carpeta `img/` manteniendo los mismos nombres
- O actualiza las referencias en `index.html` si cambias los nombres

## ⚠️ Notas Importantes

1. **Rutas relativas:** Todos los archivos usan rutas relativas, por lo que la estructura de carpetas debe mantenerse intacta.

2. **Codificación:** Los archivos están codificados en UTF-8 para preservar caracteres especiales.

3. **Compatibilidad:** El código JavaScript utiliza jQuery v1.10.2. Asegúrate de que esta versión sea compatible con tus necesidades.

4. **Imágenes faltantes:** Si alguna imagen referenciada no existe, aparecerá un icono roto en el navegador. Asegúrate de crear o proporcionar todas las imágenes necesarias.

## 📚 Información Adicional

- **Plantilla original:** Stratkit - Digital Agency HTML5 Landing Page Template
- **Fecha de refactorización:** 5 de febrero de 2026
- **Herramientas utilizadas:** PowerShell, regex, procesamiento de texto

## 🆘 Solución de Problemas

### El CSS no se aplica
- Verifica que `styles.css` existe en la misma carpeta que `index.html`
- Verifica que la ruta en el `<link>` es correcta: `href="styles.css"`

### El JavaScript no funciona
- Verifica que `scrypt.js` existe en la misma carpeta que `index.html`
- Abre la consola del navegador (F12) para ver errores
- Verifica que la ruta en el `<script>` es correcta: `src="scrypt.js"`

### Las imágenes no se muestran
- Verifica que la carpeta `img/` existe y contiene los archivos necesarios
- Verifica que los nombres de los archivos coinciden con las referencias en el HTML
- Verifica los permisos de lectura de los archivos de imagen

---

**Última actualización:** 5 de febrero de 2026
