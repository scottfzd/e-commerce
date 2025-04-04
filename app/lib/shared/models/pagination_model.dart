import 'package:app/shared/entities/pagination_entity.dart';

class PaginationModel extends PaginationEntity {
  PaginationModel({
    super.currentPage,
    super.totalPages,
    super.totalItems,
    super.perPage,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      currentPage: json['current_page'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      totalItems: json['total_items'] ?? 0,
      perPage: json['per_page'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'total_pages': totalPages,
      'total_items': totalItems,
      'per_page': perPage,
    };
  }

  factory PaginationModel.fromEntity(PaginationEntity entity) {
    return PaginationModel(
      currentPage: entity.currentPage,
      totalPages: entity.totalPages,
      totalItems: entity.totalItems,
      perPage: entity.perPage,
    );
  }

  PaginationEntity toEntity() {
    return PaginationEntity(
      currentPage: currentPage,
      totalPages: totalPages,
      totalItems: totalItems,
      perPage: perPage,
    );
  }
}
