class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL
  // static const domain = "http://192.168.1.6/mbc-laravel";
  // static const baseURL = domain + "/public/api";
  // static const imageURL = "$domain/public/storage/photos_thumb";

  static const domain = "https://maiwabreedingcenter.com";
  static const baseURL = domain + "/api";
  static const imageURL = "$domain/storage/photos_thumb";

  String getKabupatens = "$baseURL/kabupaten";
  String peternakURL = "$baseURL/peternak";
  String peternakSapiURL = "$baseURL/peternaksapi";
  String loginURL = "$baseURL/login";
  String periksaKebuntinganURL = "$baseURL/pk";
  String sapiURL = "$baseURL/sapi";
  String sapiMasterURL = "$baseURL/master/sapi";
  String performaURL = "$baseURL/performa";
  String strowURL = "$baseURL/strow";
  String ibURL = "$baseURL/ib";
  String perlakuanURL = "$baseURL/perlakuan";
  String notifURL = "$baseURL/notif";
  String metodeURL = "$baseURL/metode";
  String hasilURL = "$baseURL/hasil";
  String exportURL = "$baseURL/export";
  String laporanURL = "$baseURL/laporan";
  String userURL = "$baseURL/user";
  String birahiURL = "$baseURL/birahi";
  String panenURL = "$baseURL/panen";
}
