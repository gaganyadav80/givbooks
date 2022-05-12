import 'package:books_finder/books_finder.dart';
import 'package:get/get.dart';
import 'package:givbooks/utils/db_helper.dart';
import 'package:givbooks/views/shelf/model/shelf_model.dart';
import 'package:uuid/uuid.dart';

class ShelfController extends GetxController {
  final RxList<ShelfModel> shelves = <ShelfModel>[].obs;

  static ShelfController get to => Get.find();

  @override
  void onInit() {
    shelves.addAll(DBHelper.getShelves.map((e) => ShelfModel.fromJson(e)).toList());
    super.onInit();
  }

  @override
  void onClose() {
    DBHelper.setShelves(shelves.map((e) => e.toJson()).toList());
    super.onClose();
  }

  void addDefaultShelf() {
    shelves.addAll([
      ShelfModel(id: const Uuid().v1(), name: 'Read', books: const []),
      ShelfModel(id: const Uuid().v1(), name: 'Currently Reading', books: const []),
      ShelfModel(id: const Uuid().v1(), name: 'Want to Read', books: const []),
    ]);
    update();
  }

  void addShelf(String name) {
    shelves.add(ShelfModel(id: const Uuid().v1(), name: name, books: const []));
    update();
  }

  void deleteShelf(ShelfModel model) {
    shelves.remove(model);
    update();
  }

  void addBookToShelf(int index, Book book) {
    List<Book> books = List<Book>.from(shelves[index].books);
    books.add(book);
    shelves[index].books = books;
    update();
  }
}
