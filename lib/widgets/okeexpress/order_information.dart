import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:okejek_flutter/defaults/size_config.dart';

class OrderInformation extends StatelessWidget {
  final List layananList = [
    {
      'jenis': 'Standart',
      'harga': 'Rp.14.000',
      'estimasi': '1 - 3 hari',
    },
    {
      'jenis': 'Express',
      'harga': 'Rp.19.000',
      'estimasi': '1 hari',
    },
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 6,
              child: Container(
                padding: EdgeInsets.all(10),
                height: Get.height * 0.12,
                width: Get.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lokasi Penjemputan',
                          style: TextStyle(
                            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    Text(
                      'Jl.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Jarak ke Hub',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '7KM',
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
        ),
        Text(
          'Tujuan',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        Container(
          width: Get.width * 0.6,
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        Container(
          width: Get.width * 0.6,
          child: Text(
            'Nama Pengirim',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        Container(
          width: Get.width * 0.6,
          child: Text(
            '081232198129',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 20 / 3.6,
        ),
        Text(
          'Detail Paket',
          style: TextStyle(
            fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        Container(
          width: Get.width * 0.6,
          child: Text(
            'Isi paket Seeding lalala hehehe',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        Container(
          width: Get.width * 0.6,
          child: Text(
            'Berat : 3Kg',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockHorizontal * 10 / 3.6,
        ),
        Container(
          width: Get.width * 0.6,
          child: Text(
            'Volume : 100cm³',
            style: TextStyle(
              fontSize: SizeConfig.safeBlockHorizontal * 10 / 3.6,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          height: SizeConfig.safeBlockVertical * 20 / 7.2,
        ),
        DropdownButtonHideUnderline(
          child: Container(
            height: SizeConfig.safeBlockVertical * 80 / 7.2,
            width: Get.width,
            child: DropdownButtonFormField(
              itemHeight: SizeConfig.safeBlockVertical * 80 / 7.2,
              isDense: true,
              isExpanded: true,
              hint: Text(
                'Pilih Layanan Pengiriman',
                style: TextStyle(
                  fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down,
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Colors.grey, width: 2.0),
                ),
              ),
              selectedItemBuilder: (context) => layananList
                  .map(
                    (value) => DropdownMenuItem<String>(
                      value: value['jenis'],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(value['jenis'] + ' (${value['harga']})'),
                          Text(
                            value['estimasi'],
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              items: layananList.map((value) {
                return DropdownMenuItem(
                  child: Container(
                    height: SizeConfig.safeBlockVertical * 60 / 7.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              value['jenis'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                            SizedBox(
                              height: SizeConfig.safeBlockVertical * 10 / 7.2,
                            ),
                            Text(
                              value['harga'],
                              style: TextStyle(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          value['estimasi'],
                        ),
                      ],
                    ),
                  ),
                  value: value['jenis'],
                );
              }).toList(),
              style: TextStyle(
                fontSize: SizeConfig.safeBlockHorizontal * 12 / 3.6,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
              onChanged: (value) {},
            ),
          ),
        ),
      ],
    );
  }
}
