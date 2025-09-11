import 'package:live_score/src/core/utils/parsers.dart';

import '../../domain/entities/lineups.dart';

class LineupModel extends Lineup {
  const LineupModel({
    required super.status,
    required super.formation,
    required super.members,
  });

  factory LineupModel.fromJson(Map<String, dynamic> json) {
    return LineupModel(
      status: json['status'] ?? '',
      formation: json['formation'] ?? '',
      members:
          (json['members'] as List<dynamic>?)
              ?.map((e) => LineupMemberModel.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class YardInfoModel extends YardInfo {
  const YardInfoModel({
    required super.line,
    required super.fieldPosition,
    super.fieldLine,
    super.fieldSide,
  });

  factory YardInfoModel.fromJson(Map<String, dynamic> json) {
    return YardInfoModel(
      line: toInt(json['line']) ?? 0,
      fieldPosition: toInt(json['fieldPosition']) ?? 0,
      fieldLine: toInt(json['fieldLine']),
      fieldSide: toInt(json['fieldSide']),
    );
  }
}

class LineupMemberModel extends LineupMember {
  const LineupMemberModel({
    required super.id,
    required super.status,
    required super.statusText,
    super.yardInfo,
  });

  factory LineupMemberModel.fromJson(Map<String, dynamic> json) {
    return LineupMemberModel(
      id: json['id'],
      status: toInt(json['status']) ?? 0,
      statusText: json['statusText'] ?? '',
      yardInfo:
          json['yardFormation'] != null
              ? YardInfoModel.fromJson(json['yardFormation'])
              : null,
    );
  }
}
