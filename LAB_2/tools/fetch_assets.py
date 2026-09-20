#!/usr/bin/env python3
"""Descarca imaginile folosite in frame-urile 'homepage full' si 'product full'
din fisierul Figma, cu nume lizibile, in assets/images/.

Utilizare:
    FIGMA_TOKEN=figd_xxx python3 tools/fetch_assets.py

Foloseste curl (certificatele de sistem) ca sa evite problemele SSL
ale build-urilor de Python de pe python.org.
Doar citiri (GET). Nu modifica nimic in fisierul Figma.
"""
import json, os, pathlib, subprocess, sys

FILE_KEY = "3HeBH74VC2MHhKwXGnqI2e"
OUT = pathlib.Path(__file__).resolve().parent.parent / "assets" / "images"

# imageRef din Figma -> nume de fisier local
ASSETS = {
    # --- homepage full (node 2:164) ---
    "15fabd854b7cb3b15474b1d58ae3661dd03a76db": "hero_autumn.png",
    "ac4448f9289ba74dc8e260cf2469fe907263ed9b": "feat_turtleneck_sweater.png",
    "265cd7ba4de44d517944d6e28fbe7a516c2c8937": "feat_long_sleeve_dress.png",
    "761f46596218a649ae167df03599465380531f96": "feat_sportwear_set.png",
    "09a1be8060c68fe8e2d0ea8f62839ee9328cede6": "feat_elegant_dress.png",
    "253f5374175bb9210b2f2de3f4abe98c37fd3cbb": "banner_hang_out.png",
    "ce9ccb3eabc00976156cd7a6ef7715b1e60e96f3": "rec_white_hoodie.png",
    "fc91d640491a54d6427825d70d17317b32339301": "rec_cotton_tshirt.png",
    "3d8289e005f646c4c914bb766d81b1457a1815b2": "banner_slim_beauty.png",
    "071373fad51ad0143a98105907f84f8d80c53d58": "banner_summer_collection.png",
    "24642656f175b762469766070dae1ee73196af89": "banner_tshirts.png",
    "2059944f83f665e563d29b20be6188383e033306": "banner_dresses.png",
    # --- product full (node 2:426) ---
    "550c305749d6c4a8efe5849bb6952d297db4e2c1": "product_sportwear_set.png",
    "f38890a225ddff0443fafd8c2e8b14967c27e285": "avatar_jennifer_rose.png",
    "09e90f5ea1ecc64acbaaa975deb94ffe18def16c": "avatar_kelly_rihana.png",
    "5c86d1e9fefeb1de1a02e52e62f59bb5624dff95": "similar_rise_crop_hoodie.png",
    "1ba718d3938b04da6be29a56e3d4b6108c22d1e6": "similar_gym_crop_top.png",
    "c83e7223d06d87d1604bef80ed425c7bbab5b054": "similar_sport_sweatshirt.png",
}


def curl(args: list[str]) -> bytes:
    p = subprocess.run(["curl", "-sS", "--fail", *args], capture_output=True)
    if p.returncode != 0:
        raise RuntimeError(p.stderr.decode().strip() or f"curl exit {p.returncode}")
    return p.stdout


def main() -> int:
    token = os.environ.get("FIGMA_TOKEN")
    if not token:
        print("Lipseste FIGMA_TOKEN.\n  FIGMA_TOKEN=figd_xxx python3 tools/fetch_assets.py")
        return 1

    print("Cer URL-urile de imagine de la Figma...")
    raw = curl([
        "-H", f"X-Figma-Token: {token}",
        f"https://api.figma.com/v1/files/{FILE_KEY}/images",
    ])
    urls = json.loads(raw)["meta"]["images"]

    OUT.mkdir(parents=True, exist_ok=True)
    ok = failed = 0
    for ref, name in ASSETS.items():
        url = urls.get(ref)
        if not url:
            print(f"  ! lipseste in fisier: {name}")
            failed += 1
            continue
        dest = OUT / name
        try:
            curl(["-L", "-o", str(dest), url])
        except RuntimeError as e:
            print(f"  ! {name}: {e}")
            failed += 1
            continue
        print(f"  ok {name:34s} {dest.stat().st_size // 1024:5d} KB")
        ok += 1

    print(f"\n{ok} descarcate, {failed} esuate -> {OUT}")
    return 0 if failed == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
