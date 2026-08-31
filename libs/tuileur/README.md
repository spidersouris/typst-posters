<p align="center">
    <img src="./images/preview.png"/>
</p>

A somewhat random tiling engine heavily inspired by [Jetbrain's CAI Tiler](https://tiler.labs.jb.gg/).

_Find out more about Jetbrains's Tiler in their [blogpost](https://blog.jetbrains.com/blog/2021/06/16/art-of-tiling-and-mind-coalescence/)._

> [!IMPORTANT]
> Copyright © 2026 JetBrains s.r.o. all tiles in the /tiles/jetbrains_brand_assets/ are trademarks of JetBrains s.r.o. and should follow brand asset guidelines: https://www.jetbrains.com/company/brand/
> 
> The current [LICENSE](./LICENSE) does not yet encompass this. Beware.
>
>You can still add your own tiles by providing the `tiler` function with an array of your SVGs raw bytes.
>
>An example of reading all the tiles of a directory is provided in the `use_tileset` function:
>```typst
>/// Load a tileset by name from the tiles/ directory.
>///
>/// - name (str): Tileset name, e.g. "Wells", "Gibson", "Atwood"
>/// - tiles_dir (str): Path to the tiles directory (default: "tiles")
>/// -> array: Array of SVG bytes ready to pass as `tileset:` to `tiler()`
>#let use_tileset(name, tiles_dir: "tiles/jetbrains_brand_assets") = {
>  let count = tileset_counts.at(name, default: 0)
>  assert(count > 0, message: "Unknown tileset \"" + name + "\". Available: " + tilesets.join(", "))
>  return range(1, count + 1).map(i => read(tiles_dir + "/" + name + "/tile" + str(i) + ".svg"))
>}
>```

## Quick Start Example

```typst
#import "@local/tuileur:0.1.0": tiler, use_tileset, palettes
// or #import "@preview/tuileur:0.1.0": tiler, use_tileset, palettes

#tiler(
  cols: 5,
  rows: 5,
  tileset: use_tileset("Gibson"),
  colors: palettes.JetBrains,
)
```
<p align="center">
  <img src="./images/quick.svg" width=50%/>
</p>



## Capabilities & Examples
You can explore some more examples in the `examples/` folder.


## Contributing / Building Yourself

The engine is built in Zig 0.16.x.

To compile it to WASM, simply run:
```bash
zig build
```

To install it directly into your local Typst packages directory (so you can `#import "@local/tuiles:0.1.0"` anywhere):
```bash
zig build install-typst
```
*(Note: Requires Linux/Mac with bash installed for the symlink step)*