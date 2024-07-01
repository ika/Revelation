List<String> tableIndex = [
  "De Las Santas Escrituras",
  "De Dios y De La Santísima Trinidad",
  "Del Decreto Eterno De Dios",
  "De La Creación",
  "De La Providencia",
  "De La Caída Del Hombre, Del Pecado Y Su Castigo",
  "Del Pacto De Dios Con El Hombre",
  "De Cristo, El Mediador",
  "Del Libre Albedrío",
  "Del Llamamiento Eficaz",
  "De La Justificación",
  "De La Adopción",
  "La Santificación",
  "De La Fe Salvadora",
  "Del Arrepentimiento Para Vida",
  "De Las Buenas Obras",
  "De La Perseverancia De Los Santos",
  "De La Seguridad De La Gracia Y De La Salvación",
  "De La Ley De Dios",
  "De La Libertad Cristiana Y De La Libertad De Conciencia",
  "De La Adoración Religiosa Y Del Día De Reposo",
  "De Los Juramentos Y De Los Votos Lícitos",
  "Del Magistrado Civil",
  "Del Matrimonio Y Del Divorcio",
  "De La Iglesia",
  "De La Comunión De Los Santos",
  "De Los Sacramentos",
  "Del Bautismo",
  "De La Cena Del Señor",
  "De La Disciplina Eclesiástica",
  "De Los Sínodos Y Concilios",
  "La Muerte Y La Resurrección",
  "Del Juicio Final"
];

class Utils {
  // Future<List<String>> getTitleList() async {
  //   return westindex;
  // }

  Future<List<String>> getTableIndex() async {
    return tableIndex;
  }
}

String replaceNumbers(String txt) {
  return txt.replaceAll(RegExp(r"#\d+"), "");
}

// text and length
String prepareText(String txt, int len) {
  txt = replaceNumbers(txt);
  if (txt.length > len) {
    txt = txt.substring(0, len);
  }
  return txt;
}
