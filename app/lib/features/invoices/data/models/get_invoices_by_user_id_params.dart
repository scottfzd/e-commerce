class GetInvoicesByUserIdParams {
  final int userId;
  final int page;
  final int limit;

  const GetInvoicesByUserIdParams({
    required this.userId,
    required this.page,
    required this.limit,
  });
}
