let original = $env.config.color_config

#overlay use theme-svg "to svg"

let themes = ls nu-themes/*.nu | select name | each { update name { $in | str replace '\' '/' } } | insert svg { $in | get name | path parse | update extension svg | path join }

# Call a fresh process for every theme to base on current shell to make sure we don't vary on incomplete theme definitions - even if our baseline is not well defined
$themes | get name | each {|x| ^nu --commands $'use theme-svg "to svg"; source ($x); ls | to svg | save ($x | path parse | update extension svg | path join) --force' }

#overlay hide theme-svg

# recover original theme - because calling ^nu does not isolate the theme inside the child process - it bleeds into the current terminal session
$env.config.color_config = $original

let markdownBody = $themes | each {|x| $"## ($x.name)'\n\n![$in.name]\($x.svg)" } | str join "\n\n"
$'# Nushell Theme Previews

($markdownBody)
' | save theme-previews.md --force
