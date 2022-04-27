


/// FireStore Variable
const String fireStoreUser = 'User';
const String fireStoreUpload = 'Uploaded';
const String fireStoreComment = 'Comment';
const String fireStoreCommentLike = 'Like';
const String fireStoreUsersChat = 'UsersChat';
const String fireStoreMyUpload = 'MyUploaded';
const String fireStoreProfile = 'Profile';
const String fireStoreLike = 'Favorite';
const String fireStoreRequests = 'Requests';
const String fireStoreFriends = 'Friends';
const String fireStoreBlocks = 'Blocks';
const String fireStoreFoods = 'Food';
const String fireStoreMeat = 'Meat';
const String fireStoreVegetables = 'Vegetables';
const String fireStoreFavorite = 'Favorite';
const String fireStoreChat = 'Chat';
const String fireStoreMessage = 'Message';


/// RegExp

final RegExp regExpEmail =
RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

final RegExp regExpPw = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

final RegExp regExpPhone = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');

final RegExp regExpName = RegExp('[a-zA-Z]');

final RegExp regexImage =  RegExp(r"(http(s?):)([/|.|\w|\s|-])*\.(?:jpg|gif|png)");

//final RegExp regExpPw = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

//final RegExp regExpName = RegExp('[a-zA-Z]');
final RegExp conditionEegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
final RegExp numberRegExp = RegExp(r'\d');
final RegExp langEnRegExp = RegExp('[a-zA-Z]');
final RegExp langEnArRegExp = RegExp('[a-zA-Zء-ي]');
final RegExp langArRegExp = RegExp('[ء-ي]');
final RegExp arabicRegExp = RegExp("[\u0600-\u06ff]|[\u0750-\u077f]|[\ufb50-\ufc3f]|[\ufe70-\ufefc]");
