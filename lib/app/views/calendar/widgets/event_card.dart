import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.title,
    required this.content,
    required this.tenant,
    required this.where,
    required this.time,
  });

  final String title;
  final String content;
  final String tenant;
  final String where;
  final String time;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.raleway(height: 2),
            ),
            Text(
              content,
              style: theme.textTheme.bodySmall!.copyWith(
                letterSpacing: 2,
                fontSize: 13,
              ),
            ),
            const Gap(5),
            if (tenant.isNotEmpty)
              BottomEventCardDetails(title: "Locataire", text: tenant),
            if (where.isNotEmpty)
              BottomEventCardDetails(title: "Lieu", text: where),
            if (time.isNotEmpty)
              BottomEventCardDetails(title: "Heure", text: time),
          ],
        ),
      ),
    );
  }
}

class BottomEventCardDetails extends StatelessWidget {
  const BottomEventCardDetails({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "$title : ",
          style: GoogleFonts.indieFlower(
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "$text ",
          style: GoogleFonts.indieFlower(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
