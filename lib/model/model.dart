import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';



void excell_generator(List data, String status) {
  int count =0;
  count= data.length;
  var excel = Excel.createExcel();
  Sheet sheetObject = excel['Sheet1'];
  //var cell = sheetObject.cell(CellIndex.indexByString("A1"));
 // cell.value = 8;
  //print(excel);
  CellStyle cellStyle_heading = CellStyle(
    bold: true,
    //textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Calibri),
      rotation: 0,
      //backgroundColorHex: "FFC8E6E3",
      horizontalAlign: HorizontalAlign.Center,
    fontSize: 14
  );
  CellStyle cellStyle= CellStyle(
      bold: true,
      //textWrapping: TextWrapping.Clip,
      fontFamily: getFontFamily(FontFamily.Calibri),
      rotation: 0,
      //backgroundColorHex: "FFDAF1F3",
      horizontalAlign: HorizontalAlign.Center,
      fontSize: 12
  );

  sheetObject.updateCell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: 0), "Status: ${status}", cellStyle: cellStyle_heading);
  sheetObject.updateCell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: 1), "Employee ID", cellStyle: cellStyle);
  for(int i=0; i<count; i++){
    sheetObject.updateCell(CellIndex.indexByColumnRow(columnIndex: 0,rowIndex: i+2), "${data[i]["employeeID"]}",cellStyle: cellStyle);
  }

  var fileBytes = excel.save(fileName: "Report-${status}-Employees.xlsx");
}