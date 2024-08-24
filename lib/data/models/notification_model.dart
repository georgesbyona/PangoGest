import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';

import '../../app/shared/shared.dart';

class NotificationModel {
  final String category;
  final String title;
  final String content;
  final String time;
  final IconData icon;
  final Color color;

  NotificationModel({
    this.category = "autres",
    required this.title,
    required this.content,
    required this.time,
    required this.icon,
    required this.color,
  });
}

List<NotificationModel> notificationsData = [
  NotificationModel(
    category: "system",
    title: 'Mise à jour',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Icons.update,
    color: AppColors.yellow,
    content:
        "Une mise à jour est disponible pour votre version, ne tardez plus à être à jour et ne rien manquer de nouveau pour une meilleure expérience",
  ),
  NotificationModel(
    category: "system",
    title: 'Termes & Conditions',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: AppIcons.privacy,
    color: AppColors.primary,
    content:
        "Vous vous demandez comment nous gérons vos données, lisez la confidentialité et les conditions de notre application ici",
  ),
  NotificationModel(
    category: "system",
    title: 'Conseils',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: AppIcons.add,
    color: AppColors.greenO,
    content:
        "N'hésitez pas de lacher vos feedbacks via l'application pour une amélioration selon vos attentes.",
  ),
  NotificationModel(
    title: 'Suivi - Jours restants',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Icons.monitor_heart_outlined,
    color: AppColors.primary,
    content:
        "Voici comment est classé les jours restants pour tes locataires enfin qu'ils s'acquittent de leur paiement :",
  ),
  NotificationModel(
    title: 'Rappel - Jours restants',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: AppIcons.calendar,
    color: AppColors.yellow,
    content:
        "Rien que 10 jours pour vous acquitez du forfait mensuel de mois d'Août ...",
  ),
  NotificationModel(
    title: 'Paiement',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Icons.monetization_on_outlined,
    color: AppColors.greenO,
    content:
        "Paiement effectué de la part du Locataire Hervé Mukama, à la date du 17 Juillet 2024 pour le compte du mois de Juillet et Août de cette année ...",
  ),
  NotificationModel(
    title: "Demande de prolongation",
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Icons.sentiment_satisfied,
    color: AppColors.primary,
    content:
        "J'aimerai signaler que j'aurai un petit retard dans le paiement de forfait mensuel, veuillez m'accorder 15 jours pour que je m'acquite de ce forfaits ...",
  ),
  NotificationModel(
    title: 'Rappel - Retard encaissé',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: AppIcons.calendar,
    color: AppColors.orange,
    content:
        "Vous avez 3 jours de retard encaissé pour le paiement de votre forfait mensuel du mois de Septembre ...",
  ),
  NotificationModel(
    title: 'Paiement',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Icons.monetization_on_outlined,
    color: AppColors.greenO,
    content:
        "Paiement effectué de la part du Locataire Hervé Mukama, à la date du 17 Juillet 2024 pour le compte du mois de Juillet et Août de cette année ...",
  ),
  NotificationModel(
    title: 'Convocation',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Clarity.exclamation_triangle_line,
    color: AppColors.red,
    content:
        "Le propriétaire a besoin de te rencontrer le plus tôt possible, veuillez lui faire un message dès que vous verrez cette notification ...",
  ),
    NotificationModel(
    title: 'Paiement',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Icons.monetization_on_outlined,
    color: AppColors.greenO,
    content:
        "Paiement effectué de la part du Locataire Hervé Mukama, à la date du 17 Juillet 2024 pour le compte du mois de Juillet et Août de cette année ...",
  ),
  NotificationModel(
    title: 'FIN DU CONTRAT',
    time: DateFormat.MMMEd().format(DateTime.now()),
    icon: Clarity.exclamation_triangle_solid,
    color: AppColors.red,
    content:
        "Cher Georges,\nNous tenons juste à vous rappeler qu'il ne reste plus que 1 mois avant la fin de votre contrat avec votre propriétaire actuel, prenez le temps de revoir cela et si nécessaire commencer à prendre les dispositions pour laisser la maison d'autrui...",
  ),
];
