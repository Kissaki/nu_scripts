from https://github.com/nushell/nu_scripts/issues/339#issuecomment-2816715419
2025-04-19 @fdncred https://github.com/fdncred
> This is the last version I have. folder to-svg, mod.nu.

https://github.com/nushell/nu_scripts/issues/970#issuecomment-2422788653
2024-10-18 @NotTheDr01ds https://github.com/NotTheDr01ds

> My current progress on `to svg`:
>
> * The files below are almost entirely generated with to svg. The only modification I made manually was setting the background rect color and changing the width and height. It's currently handling:
>   * ANSI RGB colors
>   * ANSI SGR colors
>   * ANSI xterm colors
>   * Bold, underline, strikethrough
>   * Combining any of the above into a single escape
> * It uses a much more optimized layout rather than specifying the exact placement of characters and text like ansi2 above. Each line is simply a tspan offset (dy) from the previous line.
> * That captures 95% of everything I'm throwing at it so far. TODO:
>   * Calculate height and width automatically
>   * Tighten up the line spacing slightly to remove the gaps in line-drawing
>   * Set the background and default foreground color -- For now, this might have to be done via a flag unless I can get a reliable way to query the terminal state. I'm still working on getting the example above to work.
>   * Background color and reverse -- For instance, I can't currently render the readme.md in the example above, , but I at least know a way to do it that is far more efficient than the ansi2 crate. Just need to implement.
>   * Italics, hidden, dimmed
>   * Blink (sure, why not)
>   * Handle ANSI codes that cross line-boundaries (already architected for it; just need to implement)
>   * Possibly rewrite using to xml
>
> ```nu
> ls | to svg | save ...
> ```
