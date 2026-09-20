import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bar_icons.dart';
import '../widgets/banner_caption.dart';
import '../widgets/category_item.dart';
import '../widgets/page_dots.dart';
import '../widgets/product_card.dart';
import '../widgets/recommended_card.dart';
import '../widgets/section_header.dart';
import 'product_screen.dart';

/// Reproduce frame-ul Figma "homepage full" (node 2:164), 375x1714.
/// Distantele verticale de mai jos sunt diferentele dintre coordonatele Y
/// din Figma, nu valori alese la intamplare.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const double pagePadding = 32;

  int _category = 0;

  static const _categories = <(IconData, String)>[
    (Icons.woman, 'Women'),
    (Icons.man, 'Men'),
    (Icons.watch, 'Accessories'),
    (Icons.brush, 'Beauty'),
  ];

  void _openProduct(Product product) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ProductScreen(product: product)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 19),
              _header(),
              const SizedBox(height: 36),
              _categoryRow(),
              const SizedBox(height: 30),
              _hero(),
              const SizedBox(height: 35),
              _padded(const SectionHeader(title: 'Feature Products')),
              const SizedBox(height: 20),
              _featureList(),
              const SizedBox(height: 19),
              _hangOutBanner(),
              const SizedBox(height: 38),
              _padded(const SectionHeader(title: 'Recommended')),
              const SizedBox(height: 30),
              _recommendedList(),
              const SizedBox(height: 34),
              _padded(const SectionHeader(title: 'Top Collection')),
              const SizedBox(height: 33),
              _padded(_slimBeautyBanner()),
              const SizedBox(height: 15),
              _padded(_summerBanner()),
              const SizedBox(height: 16),
              _padded(_smallBanners()),
              const SizedBox(height: 17),
            ],
          ),
        ),
      ),
    );
  }

  Widget _padded(Widget child) =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: pagePadding), child: child);

  // --- Header: hamburger / GemStore / clopotel --------------------------

  Widget _header() => _padded(
        SizedBox(
          height: 26,
          child: Stack(
            alignment: Alignment.center,
            children: [
              const Align(alignment: Alignment.centerLeft, child: MenuIcon()),
              Text(
                'GemStore',
                style: AppTheme.font(
                  size: 20,
                  weight: FontWeight.w700,
                  color: Colors.black,
                  height: 24,
                ),
              ),
              const Align(alignment: Alignment.centerRight, child: BellIcon()),
            ],
          ),
        ),
      );

  // --- Randul de categorii ----------------------------------------------

  Widget _categoryRow() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var i = 0; i < _categories.length; i++)
              CategoryItem(
                icon: _categories[i].$1,
                label: _categories[i].$2,
                active: i == _category,
                onTap: () => setState(() => _category = i),
              ),
          ],
        ),
      );

  // --- Hero "Autumn Collection 2021" ------------------------------------

  Widget _hero() => _padded(
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: SizedBox(
            height: 168,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  color: AppColors.heroPlaceholder,
                  child: Image.asset('${DemoData.imgPath}/hero_autumn.png', fit: BoxFit.cover),
                ),
                Positioned(
                  left: 188,
                  top: 19,
                  child: Text(
                    'Autumn\nCollection\n2021',
                    style: AppTheme.font(
                      size: 22,
                      weight: FontWeight.w700,
                      color: Colors.white,
                      height: 31,
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 8,
                  left: 0,
                  right: 0,
                  child: PageDots(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      );

  // --- Feature Products --------------------------------------------------

  Widget _featureList() => SizedBox(
        height: 227,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: pagePadding),
          itemCount: DemoData.featured.length,
          separatorBuilder: (_, _) => const SizedBox(width: 20),
          itemBuilder: (_, i) => ProductCard(
            product: DemoData.featured[i],
            onTap: () => _openProduct(DemoData.featured[i]),
          ),
        ),
      );

  // --- Banner "HANG OUT & PARTY" (full-bleed) ---------------------------

  Widget _hangOutBanner() => SizedBox(
        height: 158,
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: AppColors.surfaceBanner)),
            Positioned(
              left: 227,
              top: 6,
              child: _circle(132, AppColors.bannerCircleLarge),
            ),
            Positioned(
              left: 242,
              top: 21,
              child: _circle(102, AppColors.bannerCircleLarge),
            ),
            Positioned(
              left: 233,
              top: 0,
              width: 119,
              height: 158,
              child: Image.asset('${DemoData.imgPath}/banner_hang_out.png', fit: BoxFit.cover),
            ),
            const Positioned(
              left: 55,
              top: 36,
              child: BannerCaption(
                label: 'NEW COLLECTION',
                title: 'HANG OUT \n& PARTY',
                titleHeight: 23,
              ),
            ),
          ],
        ),
      );

  // --- Recommended -------------------------------------------------------

  Widget _recommendedList() => SizedBox(
        height: RecommendedCard.cardHeight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: pagePadding),
          itemCount: DemoData.recommended.length,
          separatorBuilder: (_, _) => const SizedBox(width: 15),
          itemBuilder: (_, i) => RecommendedCard(
            product: DemoData.recommended[i],
            onTap: () => _openProduct(DemoData.recommended[i]),
          ),
        ),
      );

  // --- Top Collection: banner 1 -----------------------------------------

  Widget _slimBeautyBanner() => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 141,
          child: Stack(
            children: [
              Positioned.fill(child: Container(color: AppColors.surfaceBanner)),
              Positioned(left: 194, top: 25, child: _circle(86, AppColors.bannerCircleSmall)),
              Positioned(
                left: 181,
                top: -60,
                width: 129,
                height: 229,
                child: Image.asset('${DemoData.imgPath}/banner_slim_beauty.png', fit: BoxFit.cover),
              ),
              const Positioned(
                left: 23,
                top: 22,
                child: BannerCaption(
                  label: 'Sale up to 40%',
                  title: 'FOR SLIM\n& BEAUTY',
                  titleColor: AppColors.textBanner,
                ),
              ),
            ],
          ),
        ),
      );

  // --- Top Collection: banner 2 -----------------------------------------

  Widget _summerBanner() => SizedBox(
        height: 229,
        child: Stack(
          children: [
            Positioned(
              top: 19,
              left: 0,
              right: 0,
              height: 210,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(
                  children: [
                    Positioned.fill(child: Container(color: AppColors.surfaceBanner)),
                    Positioned(left: 165, top: 41, child: _circle(114, AppColors.bannerCircleGrey)),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 160,
              top: 0,
              width: 152,
              height: 229,
              child: Image.asset('${DemoData.imgPath}/banner_summer_collection.png', fit: BoxFit.cover),
            ),
            const Positioned(
              left: 23,
              top: 53,
              child: BannerCaption(
                label: 'Summer Collection 2021',
                title: 'Most sexy\n& fabulous\ndesign',
                titleWeight: FontWeight.w500,
                titleHeight: 30,
              ),
            ),
          ],
        ),
      );

  // --- Top Collection: cele doua carduri mici ---------------------------

  Widget _smallBanners() => SizedBox(
        height: 194,
        child: Row(
          children: [
            Expanded(
              child: _smallBanner(
                label: 'T-Shirts',
                title: 'The \nOffice\nLife',
                titleSize: 17,
                titleHeight: 21,
                image: '${DemoData.imgPath}/banner_tshirts.png',
                imageOnLeft: true,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _smallBanner(
                label: 'Dresses',
                title: 'Elegant\nDesign',
                titleSize: 18,
                titleHeight: 22,
                image: '${DemoData.imgPath}/banner_dresses.png',
                imageOnLeft: false,
              ),
            ),
          ],
        ),
      );

  Widget _smallBanner({
    required String label,
    required String title,
    required double titleSize,
    required double titleHeight,
    required String image,
    required bool imageOnLeft,
  }) {
    final textBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: AppTheme.font(
            size: 13,
            weight: FontWeight.w400,
            color: AppColors.textLabel,
            height: 15,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 17),
        Text(
          title,
          style: AppTheme.font(
            size: titleSize,
            weight: FontWeight.w300,
            color: AppColors.textPrimary,
            height: titleHeight,
          ),
        ),
      ],
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: AppColors.surfaceBanner,
        child: Stack(
          children: [
            Positioned(
              left: imageOnLeft ? 0 : null,
              right: imageOnLeft ? null : 0,
              top: 0,
              bottom: 0,
              width: imageOnLeft ? 110 : 78,
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Positioned(
              left: imageOnLeft ? 83 : 7,
              top: 42,
              child: textBlock,
            ),
          ],
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      );
}
