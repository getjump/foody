Serialization:
  [] -> json array

Special Data Types:

Error { int code; string message }
ApiResponse { T object; Error? error; }

GeoPoint { double lat, long; }
FailableAction { bool sucess; } // Actually is void

enum RatingType { Tryed, Liked };

Photo { int id; string photo_1x; }
Tag { int id; string name; }
Place { int id; string name; GeoPoint location; }
Food { int id; string name; Photo photo; int price; Place place; }
Rating { Food food; RatingType type; }
Device { string device_hash }

? - means Optional, so object could be null!, and should be asked for null before job [] - is array

EX:

/:namespace/:method
  HTTP_METHOD:methodName(type :paramName...) -> ReturnType
SO request :
  HTTP_METHOD /:namespace/:methodName(?):paramName=(type)$(:paramName)

// CURRENTLY EVERYTHING WITHOUT AUTH

// REST - GET take some data, POST save some data

/food/
  GET:/(Tag(id)? tags[], int? price, Device? device) -> ApiResponse<Food[]>
  POST:/(Tag(id)? tags[], int price, Photo(id) photo, Place(id) place) -> ApiResponse<Food>

/photos/ //
  GET:/(Photo(id) photo) -> ApiResponse<Photo?>
  POST:/(Binary photo) -> ApiResponse<Photo?>

/places/
  GET:/(Place(name) name, Place(location) location) -> ApiResponse<Place[]>
  POST:/(Place(name) name, Place(location) location) -> ApiResponse<Place>

/ratings/
  POST:/(Food(id) food, RatingType type, Device device)

/tags/
  POST:/(Tag(name) name)
