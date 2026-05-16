let original = $env.config.color_config

#overlay use theme-svg "to svg"

let themes = ls nu-themes/*.nu | select name | each { update name { $in | str replace '\' '/' } } | insert svg { $in | get name | path parse | update extension svg | path join | str replace '\' '/' }

# Call a fresh process for every theme to base on current shell to make sure we don't vary on incomplete theme definitions - even if our baseline is not well defined
#$themes | get name | each {|x| ^nu --commands $'use theme-svg "to svg"; source ($x); ls | to svg | save ($x | path parse | update extension svg | path join) --force' }

#overlay hide theme-svg

# recover original theme - because calling ^nu does not isolate the theme inside the child process - it bleeds into the current terminal session
$env.config.color_config = $original

let markdownBody = $themes | each { $"## ($in.name | path basename)\n\n![($in.name)]\(($in.svg))\n\nActivate with `source ($in.name)`" } | str join "\n\n"
$'# Nushell Theme Previews

($markdownBody)
' | save theme-previews.md --force

let htmlThemesBody = $themes | each { $"
  <div class=\"theme\">
    <div class="name">($in.name | path basename)</div>
    <img src=\"($in.svg)\" alt=\"Preview of ($in.name) Nushell theme\"/>
    <div class=\"instructions\">Activate with <code>source ($in.name)</code></div>
  </div>" } | str join "\n"
$"<html><!-- Note: If you view on GitHub, prefer the Markdown \(.md) file. If you open this html file locally it will render and has a denser and dynamic layout. -->
  <head>
    <meta charset=\"utf-8\"><title>Nushelle Theme Previews</title>
    <meta name=\"viewport\" content=\"width=device-width\">
    <meta name=\"color-scheme\" content=\"dark light\" />
    <style>.themes { display: flex; flex-wrap: wrap; gap: 1rem; } .theme { display: grid; } .name { font-weight: bold; }</style>
  </head><body><div class=\"themes\">($htmlThemesBody)</div></body></html>
" | save theme-previews.html --force
