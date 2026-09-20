#!/usr/bin/env python3
"""Reduce imaginile descarcate la ~3x marimea la care sunt afisate in Figma.

Un PNG de 12 MB afisat la 312x168 e risipa: incetineste pornirea, umfla APK-ul
si nu adauga nimic vizual. 3x acopera si ecranele cu densitate mare.

Ruleaza idempotent - imaginile deja mici sunt sarite.
    python3 tools/optimize_assets.py
"""
import pathlib
from PIL import Image

OUT = pathlib.Path(__file__).resolve().parent.parent / "assets" / "images"
SCALE = 3

# nume -> (latime, inaltime) la care e afisata imaginea in design
DISPLAY = {
    "hero_autumn.png": (312, 168),
    "feat_turtleneck_sweater.png": (126, 172),
    "feat_long_sleeve_dress.png": (126, 172),
    "feat_sportwear_set.png": (126, 172),
    "feat_elegant_dress.png": (126, 172),
    "banner_hang_out.png": (119, 158),
    "rec_white_hoodie.png": (66, 66),
    "rec_cotton_tshirt.png": (66, 66),
    "banner_slim_beauty.png": (129, 229),
    "banner_summer_collection.png": (152, 229),
    "banner_tshirts.png": (110, 194),
    "banner_dresses.png": (78, 194),
    "product_sportwear_set.png": (355, 532),
    "avatar_jennifer_rose.png": (36, 36),
    "avatar_kelly_rihana.png": (36, 36),
    "similar_rise_crop_hoodie.png": (126, 172),
    "similar_gym_crop_top.png": (126, 172),
    "similar_sport_sweatshirt.png": (126, 172),
}


def main() -> None:
    before = after = 0
    for name, (w, h) in DISPLAY.items():
        path = OUT / name
        if not path.exists():
            print(f"  ! lipseste {name}")
            continue
        size0 = path.stat().st_size
        before += size0
        with Image.open(path) as im:
            im = im.convert("RGBA")
            w0, h0 = im.size
            im.thumbnail((w * SCALE, h * SCALE), Image.LANCZOS)
            if im.size == (w0, h0):
                after += size0
                print(f"  = {name:34s} {w0}x{h0} deja mic")
                continue
            im.save(path, "PNG", optimize=True)
        size1 = path.stat().st_size
        after += size1
        print(f"  > {name:34s} {w0}x{h0} -> {im.size[0]}x{im.size[1]}  "
              f"{size0 // 1024} KB -> {size1 // 1024} KB")

    print(f"\ntotal: {before / 1e6:.1f} MB -> {after / 1e6:.1f} MB")


if __name__ == "__main__":
    main()
