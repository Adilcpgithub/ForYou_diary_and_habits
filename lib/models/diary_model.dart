import 'package:hive/hive.dart';
part 'diary_model.g.dart';

@HiveType(typeId: 1)
class DiaryEntry extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String content;

  @HiveField(2)
  late DateTime date;

  @HiveField(3)
  late String? imagePath;

  @HiveField(4)
  late String? userId;

  DiaryEntry(
      {required this.title,
      required this.content,
      required this.date,
      this.imagePath,
      this.userId});
}
