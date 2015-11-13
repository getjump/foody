Serialization:
  [] -> json array

Special Data Types:

Error { int code; string message }
ApiResponse { T object; Error? error; }

Range<T> { T min, max; }

GeoPoint { double lat, long; }
FailableAction { bool sucess; } // Actually is void

enum RatingType { Tried, Liked } -> {0, 1}

Rating {int tried, liked;}

Likes {  }
Photo { int id; string photo_1x; }
Tag { int id; string name; }
Place { int id; string name; GeoPoint location; }
Food { int id; string name; Photo photo; int price; Place place; }
Rating { Food food; RatingType type; }
Device { string device_hash } -> device_hash

? - means Optional, so object could be null!, and should be asked for null before job [] - is array

EX:

/:namespace/:method
  HTTP_METHOD:methodName(type :paramName...) -> ReturnType
SO request :
  HTTP_METHOD /:namespace/:methodName(?):paramName=(type)$(:paramName)

// CURRENTLY EVERYTHING WITHOUT AUTH

// REST - GET take some data, POST save some data

/food/
  GET:/(Tag(id)? tags[], int[](0->min, 1->max) price, Device? device, int? count, int? offset, string search) -> ApiResponse<Food[]>
  POST:/(Tag(id)? tags[], int price, Photo(id) photo, Place(id) place, string name) -> ApiResponse<Food>

/photos/ //
  GET:/(Photo(id) photo) -> ApiResponse<Photo?>
  POST:/(Binary photo) -> ApiResponse<Photo?>

/places/
  GET:/(Place(name)? name, Place(location)? location, int? count, int? offset) -> ApiResponse<Place[]>
  POST:/(Place(name) name, Place(location) location, Place(address)? address) -> ApiResponse<Place>

/ratings/
  POST:/(Food(id) food, RatingType status, Device device)
  DELETE:/(Food(id) food, Device device)

/tags/
  POST:/(Tag(name) name)
  GET:/(Tag(name)? name)
