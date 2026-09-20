import 'package:flutter/material.dart';

import '../data/demo_data.dart';
import '../models/product.dart';
import '../theme/app_colors.dart';
import '../theme/app_theme.dart';
import '../widgets/expandable_section.dart';
import '../widgets/page_dots.dart';
import '../widgets/product_card.dart';
import '../widgets/rating_bar_row.dart';
import '../widgets/star_rating.dart';

/// Reproduce frame-ul Figma "product full" (node 2:426), 375x1818.
class ProductScreen extends StatefulWidget {
  final Product product;

  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  static const double pagePadding = 32;
  static const double _heroHeight = 406;
  static const double _sheetRadius = 20;

  static const _swatches = <Color>[
    AppColors.swatchBeige,
    AppColors.swatchBlack,
    AppColors.swatchRed,
  ];
  static const _sizes = <String>['S', 'M', 'L'];

  int _colorIndex = 0;
  int _sizeIndex = 2; // "L" e selectat in design
  bool _favorite = true;
  bool _descriptionOpen = true;
  bool _reviewsOpen = true;
  bool _similarOpen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _heroArea(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: pagePadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 57),
                      _titleRow(),
                      const SizedBox(height: 16),
                      _ratingRow(),
                      const SizedBox(height: 21),
                      const Divider(height: 1, thickness: 1, color: AppColors.divider),
                      const SizedBox(height: 15),
                      _optionsBlock(),
                      const SizedBox(height: 33),
                      const Divider(height: 1, thickness: 1, color: AppColors.divider),
                      const SizedBox(height: 7),
                      _descriptionSection(),
                      const SizedBox(height: 18),
                      _reviewsSection(),
                      const SizedBox(height: 20),
                      _similarSection(),
                      const SizedBox(height: 37),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _topButtons(),
        ],
      ),
      bottomNavigationBar: _addToCartBar(),
    );
  }

  // --- Zona de sus: fundal, cerc, fotografie, puncte de pagina -----------

  Widget _heroArea() {
    return SizedBox(
      height: _heroHeight + _sheetRadius,
      child: Stack(
        children: [
          ClipRect(
            child: SizedBox(
              height: _heroHeight + _sheetRadius,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 451,
                    child: Container(color: AppColors.productBackdrop),
                  ),
                  Positioned(
                    left: 81,
                    top: 93,
                    child: Container(
                      width: 234,
                      height: 234,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.productCircle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 12,
                    width: 355,
                    height: 532,
                    child: Image.asset(widget.product.image, fit: BoxFit.contain),
                  ),
                  const Positioned(
                    top: 384,
                    left: 0,
                    right: 0,
                    child: PageDots(color: Color(0xFF4F4F4F)),
                  ),
                ],
              ),
            ),
          ),
          // Marginea rotunjita a "foii" albe care acopera fotografia.
          Positioned(
            top: _heroHeight,
            left: 0,
            right: 0,
            height: _sheetRadius,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(_sheetRadius)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topButtons() {
    return Positioned(
      top: 59,
      left: 30,
      right: 31,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const SizedBox(
              width: 36,
              height: 36,
              child: Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF1E3354)),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _favorite = !_favorite),
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: Icon(
                _favorite ? Icons.favorite : Icons.favorite_border,
                size: 19,
                color: AppColors.heart,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Titlu + pret ------------------------------------------------------

  Widget _titleRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.product.name,
            style: AppTheme.font(
              size: 18,
              weight: FontWeight.w700,
              color: AppColors.textPrimary,
              height: 21,
            ),
          ),
        ),
        Text(
          widget.product.formattedPrice,
          style: AppTheme.font(
            size: 26,
            weight: FontWeight.w700,
            color: Colors.black,
            height: 30,
          ),
        ),
      ],
    );
  }

  Widget _ratingRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const StarRating(size: 18, gap: 7),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(bottom: 2),
          child: Text(
            '(${DemoData.ratingsCount})',
            style: AppTheme.font(
              size: 12,
              weight: FontWeight.w300,
              color: AppColors.textPrimary,
              height: 16,
            ),
          ),
        ),
      ],
    );
  }

  // --- Color / Size ------------------------------------------------------

  Widget _optionsBlock() {
    final labelStyle = AppTheme.font(
      size: 14,
      weight: FontWeight.w500,
      color: AppColors.textBanner,
      height: 20,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text('Color', style: labelStyle)),
            Expanded(child: Text('Size', style: labelStyle)),
          ],
        ),
        const SizedBox(height: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                for (var i = 0; i < _swatches.length; i++)
                  Padding(
                    padding: EdgeInsets.only(right: i == _swatches.length - 1 ? 0 : 13),
                    child: _colorSwatch(i),
                  ),
              ],
            ),
            Row(
              children: [
                for (var i = 0; i < _sizes.length; i++)
                  Padding(
                    padding: EdgeInsets.only(right: i == _sizes.length - 1 ? 0 : 8),
                    child: _sizeChip(i),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _colorSwatch(int i) {
    final selected = i == _colorIndex;
    return GestureDetector(
      onTap: () => setState(() => _colorIndex = i),
      child: Container(
        width: 34,
        height: 34,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: selected ? Border.all(color: AppColors.textSizeOff) : null,
        ),
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(shape: BoxShape.circle, color: _swatches[i]),
        ),
      ),
    );
  }

  Widget _sizeChip(int i) {
    final selected = i == _sizeIndex;
    return GestureDetector(
      onTap: () => setState(() => _sizeIndex = i),
      child: Container(
        width: 33,
        height: 33,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.sizeActive : AppColors.surfaceSizeOff,
        ),
        child: Text(
          _sizes[i],
          style: AppTheme.font(
            size: 12,
            weight: FontWeight.w500,
            color: selected ? Colors.white : AppColors.textSizeOff,
            height: 15,
            letterSpacing: -0.1,
          ),
        ),
      ),
    );
  }

  // --- Description -------------------------------------------------------

  Widget _descriptionSection() {
    final body = AppTheme.font(
      size: 12,
      weight: FontWeight.w300,
      color: AppColors.textPrimary,
      height: 20,
    );

    return ExpandableSection(
      title: 'Description',
      expanded: _descriptionOpen,
      onToggle: (v) => setState(() => _descriptionOpen = v),
      child: Text.rich(
        TextSpan(
          style: body,
          children: [
            TextSpan(text: '${DemoData.description} '),
            TextSpan(
              text: 'Read more',
              style: body.copyWith(color: AppColors.accent),
            ),
          ],
        ),
      ),
    );
  }

  // --- Reviews -----------------------------------------------------------

  Widget _reviewsSection() {
    return ExpandableSection(
      title: 'Reviews',
      expanded: _reviewsOpen,
      onToggle: (v) => setState(() => _reviewsOpen = v),
      contentTopPadding: 28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _ratingSummary(),
          const SizedBox(height: 16),
          for (final row in DemoData.ratingBreakdown)
            RatingBarRow(stars: row.stars, fill: row.fill, label: row.label),
          const SizedBox(height: 8),
          _reviewsToolbar(),
          const SizedBox(height: 40),
          for (var i = 0; i < DemoData.reviews.length; i++) ...[
            if (i > 0) const SizedBox(height: 35),
            _reviewTile(DemoData.reviews[i]),
          ],
        ],
      ),
    );
  }

  Widget _ratingSummary() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DemoData.rating.toString(),
          style: AppTheme.font(
            size: 40,
            weight: FontWeight.w700,
            color: AppColors.textRating,
            height: 45,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(width: 12),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            'OUT OF 5',
            style: AppTheme.font(
              size: 11,
              weight: FontWeight.w400,
              color: AppColors.textMuted,
              height: 13,
              letterSpacing: 0.1,
            ),
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 3),
              child: StarRating(size: 19, gap: 2),
            ),
            const SizedBox(height: 7),
            Text(
              '${DemoData.ratingsCount} ratings',
              style: AppTheme.font(
                size: 10,
                weight: FontWeight.w300,
                color: AppColors.textMuted,
                height: 12,
                letterSpacing: 0.1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _reviewsToolbar() {
    final style = AppTheme.font(
      size: 11,
      weight: FontWeight.w300,
      color: AppColors.textMuted,
      height: 17,
      letterSpacing: -0.1,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('${DemoData.reviewsCount} Reviews', style: style),
        Row(
          children: [
            Text('WRITE A REVIEW', style: style),
            const SizedBox(width: 4),
            const Icon(Icons.edit, size: 16, color: Color(0xFFC8C7CC)),
          ],
        ),
      ],
    );
  }

  Widget _reviewTile(Review review) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipOval(
          child: Image.asset(review.avatar, width: 36, height: 36, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    review.author,
                    style: AppTheme.font(
                      size: 13,
                      weight: FontWeight.w700,
                      color: AppColors.textDark,
                      height: 18,
                    ),
                  ),
                  Text(
                    review.timeAgo,
                    style: AppTheme.font(
                      size: 11,
                      weight: FontWeight.w600,
                      color: AppColors.textDark.withValues(alpha: 0.25),
                      height: 17,
                      letterSpacing: -0.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              StarRating(size: 10, gap: 5, count: review.stars),
              const SizedBox(height: 11),
              Padding(
                padding: const EdgeInsets.only(right: 0),
                child: Text(
                  review.text,
                  style: AppTheme.font(
                    size: 11,
                    weight: FontWeight.w300,
                    color: Colors.black,
                    height: 17,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Similar Product ---------------------------------------------------

  Widget _similarSection() {
    return ExpandableSection(
      title: 'Similar Product',
      expanded: _similarOpen,
      onToggle: (v) => setState(() => _similarOpen = v),
      contentTopPadding: 30,
      child: SizedBox(
        height: 227,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          padding: EdgeInsets.zero,
          itemCount: DemoData.similar.length,
          separatorBuilder: (_, _) => const SizedBox(width: 20),
          itemBuilder: (_, i) => ProductCard(
            product: DemoData.similar[i],
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (_) => ProductScreen(product: DemoData.similar[i]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Bara fixa de jos --------------------------------------------------

  Widget _addToCartBar() {
    return Container(
      height: 77,
      decoration: const BoxDecoration(
        color: AppColors.addToCartBar,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_bag, size: 24, color: Color(0xFFFCFCFD)),
            const SizedBox(width: 13),
            Text(
              'Add To Cart',
              style: AppTheme.font(
                size: 18,
                weight: FontWeight.w700,
                color: Colors.white,
                height: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
