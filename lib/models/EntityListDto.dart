

class EntityDTO {
  String name;
  String path;

  EntityDTO(Map<String, dynamic> jsonObject) {
    this.name = jsonObject["name"];
    this.path = jsonObject["path"];
  }

  @override
  String toString() {
    return "EntityDTO[\n" + "  name: $name\n" + "  path: $path\n" + "]";
  }
}


class EntityListDTO {
  final List<EntityDTO> items;

  EntityListDTO(this.items);

  static List parseJson(Object jsonObject) {
    if (jsonObject is! List) {
      throw new ArgumentError("Unexpected protocol. JsonArray expected.");
    }

    // ignore: strong_mode_uses_dynamic_as_bottom
    final itemList = (jsonObject as List).map<EntityDTO>((Object jsonEntry) {
      return new EntityDTO(jsonEntry);
    }).toList();
    return itemList;

    //return new EntityListDTO(itemList);
  }
}

