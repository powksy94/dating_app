import 'package:flutter/material.dart';
import 'package:nocturne/l10n/app_localizations.dart';
import 'package:nocturne/domains/elegie/models/elegie.dart';

class ElegieTile extends StatelessWidget {
  final Elegie elegie;
  const ElegieTile({super.key, required this.elegie});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: const Color(0xFF0D0010),
      leading: CircleAvatar(
        radius: 26,
        backgroundColor: const Color(0xFF2D0040),
        backgroundImage: elegie.otherAvatarUrl.isNotEmpty
            ? NetworkImage(elegie.otherAvatarUrl)
            : null,
        child: elegie.otherAvatarUrl.isEmpty
            ? const Icon(Icons.person, color: Color(0xFF7B00D4))
            : null,
      ),
      title: Text(
        elegie.otherUsername,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Text(
            elegie.text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFFAA9AB5),
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF1A0A1F),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF7B00D4), width: 0.5),
        ),
        child: Text(
          AppLocalizations.of(context)!.chatElegiePending,
          style: const TextStyle(
            color: Color(0xFF7B00D4),
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      isThreeLine: true,
    );
  }
}
