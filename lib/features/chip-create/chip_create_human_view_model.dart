import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '/network/network.dart';

final class ChipCreateHumanViewModel extends ChangeNotifier {
  ChipCreateHumanViewModel({required Networkable network}) : _network = network;
  final Networkable _network;

  // ValueNotifier<Localable?> snackPub = ValueNotifier(null);

  List<UploadImage> uploads = [UploadImage()];

  void didChooseImage(int index, String path) {
    final item = uploads[index];
    if (item.path != path) {
      item.path = path;
      item.url = null;
      notifyListeners();
      uploadImage(index);
    }
  }

  void uploadImage(int index) async {
    final item = uploads[index];

    var request = MultipartRequest('POST', Uri.parse('https://upload.qiniup.com'));
    request.fields['token'] =
        'IAM-ywgpYaz9Xmjb6fAIrnccg90-55A-oeW5N-uQSyUE:-wNXxxZICwkbyd2kmfdeWWAYjMI=:eyJzY29wZSI6ImRjLXFpbml1LWFsaXl1bi1tcC1iMDY1ODc4Ni1iZWFmLTQxZjktYjIzNy05NTY5ZmYwYTA1NTAtZTIxOnVwbG9hZC9hc2RmMDAyLnBuZyIsImZvcmNlU2F2ZUtleSI6dHJ1ZSwic2F2ZUtleSI6InVwbG9hZC9hc2RmMDAyLnBuZyIsImRlYWRsaW5lIjoxNzYxODIwNDU0LCJpbnNlcnRPbmx5IjoxLCJmc2l6ZU1pbiI6MCwiZnNpemVMaW1pdCI6MTA0ODU3NjAwLCJyZXR1cm5Cb2R5Ijoie1wia2V5XCI6XCIkKGtleSlcIixcImhhc2hcIjpcIiQoZXRhZylcIixcIm5hbWVcIjpcIiQoZm5hbWUpXCIsXCJzaXplXCI6XCIkKGZzaXplKVwiLFwid2lkdGhcIjpcIiQoaW1hZ2VJbmZvLndpZHRoKVwiLFwiaGVpZ2h0XCI6XCIkKGltYWdlSW5mby5oZWlnaHQpXCIsXCJmb3JtYXRcIjpcIiQoaW1hZ2VJbmZvLmZvcm1hdClcIn0ifQ==';
    request.fields['key'] = 'upload/asdf002.png';
    request.files.add(await MultipartFile.fromPath('file', item.path!));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('File uploaded successfully!');
        String responseBody = await response.stream.bytesToString();
        print('Response: $responseBody');
      } else {
        print('File upload failed with status: ${response.statusCode}');
        String errorBody = await response.stream.bytesToString();
        print('Error: $errorBody');
      }
    } catch (e) {
      print('Error during file upload: $e');
    }
  }
}

class UploadImage {
  String? path;
  String? url;
}
