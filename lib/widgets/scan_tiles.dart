import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class ScanTiles extends StatelessWidget {
  final String tipus;

  // Pantalla para eliminar un registro o hacerlo
  const ScanTiles({Key? key, required this.tipus}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

//Si deslizamos un registro lo elimina y si lo clickamos lo hacemos funcionar(abrir mapa o navegador)
    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_,index) => Dismissible(key: UniqueKey(),
      background: Container(color: Colors.red,
      child: Align(child: Icon(Icons.delete_forever),),
      alignment: Alignment.centerRight,), 
      onDismissed: (DismissDirection direccio) {
        Provider.of<ScanListProvider>(context, listen: false).esborraPerTipus(scans[index].id!);
      },
      child:ListTile(leading: Icon(this.tipus == "http" ? Icons.home_outlined : Icons.map_outlined) ,
      title: Text(scans[index].valor),
      subtitle: Text(scans[index].id.toString()),
      trailing: Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
      onTap: () { 
        launchURL(context, scans[index]);
      },)));
  }
}