import 'dart:ui';
import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({super.key, required this.product, required this.onAdd});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _imageTapped = false;
  bool _buttonPressed = false;
  bool _hovered = false;

  void _animateImageTap() {
    setState(() => _imageTapped = true);
    Future.delayed(const Duration(milliseconds: 140), () {
      if (mounted) setState(() => _imageTapped = false);
    });
  }

  Future<void> _onAdd() async {
    setState(() => _buttonPressed = true);
    await Future.delayed(const Duration(milliseconds: 140));
    if (mounted) setState(() => _buttonPressed = false);
    widget.onAdd();
  }

  @override
  Widget build(BuildContext context) {
    final elevation = (_hovered || _imageTapped) ? 12.0 : 3.0;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedPhysicalModel(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOutCubic,
        shape: BoxShape.rectangle,
        elevation: elevation,
        color: Colors.white,
        shadowColor: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            children: [
              // Animated image area with acrylic overlay
              Expanded(
                child: GestureDetector(
                  onTap: _animateImageTap,
                  child: Hero(
                    tag: 'product-${widget.product.id}',
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 160),
                          scale: _imageTapped ? 0.97 : 1.0,
                          curve: Curves.easeOut,
                          child: Image.network(widget.product.imageUrl, fit: BoxFit.cover),
                        ),
                        // Acrylic blur strip at bottom like Windows 11
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 68,
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(0), topRight: Radius.circular(0)),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                                child: Container(
                                  color: Colors.white.withOpacity(0.18),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Text(widget.product.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                shadows: [Shadow(blurRadius: 6, color: Colors.black38)]),
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      Text('Rs. ${widget.product.price.toStringAsFixed(2)}',
                                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // Action area with soft shadow and spacing
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          Text('Rs. ${widget.product.price.toStringAsFixed(2)}',
                              style: const TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    AnimatedScale(
                      scale: _buttonPressed ? 0.96 : 1.0,
                      duration: const Duration(milliseconds: 140),
                      child: ElevatedButton(
                        onPressed: _onAdd,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _hovered ? Colors.green[700] : Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 4,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.add_shopping_cart, size: 18),
                            SizedBox(width: 6),
                            Text('Add')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}