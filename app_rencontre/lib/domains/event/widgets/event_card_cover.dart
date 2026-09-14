import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';

class EventCardCover extends StatelessWidget {
  final String coverImageUrl;
  final bool isFree;
  final double? price;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const EventCardCover({
    super.key,
    required this.coverImageUrl,
    required this.isFree,
    required this.price,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      child: Stack(
        children: [
          coverImageUrl.isNotEmpty
              ? Image.network(
                  coverImageUrl,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: 160,
                  color: const Color(0xFF2D0040),
                  child: const Center(
                    child: Icon(Icons.music_note,
                        size: 48, color: Color(0xFF7B00D4)),
                  ),
                ),
          Positioned(
            top: 10,
            right: 10,
            child: _PriceBadge(isFree: isFree, price: price),
          ),
          Positioned(
            top: 10,
            left: 10,
            child: Material(
              color: Colors.black54,
              shape: const CircleBorder(),
              child: InkWell(
                onTap: onToggleFavorite,
                customBorder: const CircleBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    size: 18,
                    color: isFavorite ? const Color(0xFFD400FF) : Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceBadge extends StatelessWidget {
  final bool isFree;
  final double? price;
  const _PriceBadge({required this.isFree, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isFree ? const Color(0xFF1A5C1A) : const Color(0xFF1A0A1F).withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isFree ? const Color(0xFF2ECC71) : const Color(0xFF7B00D4),
        ),
      ),
      child: Text(
        isFree ? AppLocalizations.of(context)!.eventPriceFree : '${price?.toStringAsFixed(0)} €',
        style: TextStyle(
          color: isFree ? const Color(0xFF2ECC71) : const Color(0xFFD400FF),
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
