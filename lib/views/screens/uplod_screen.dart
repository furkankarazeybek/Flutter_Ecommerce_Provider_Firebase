import 'dart:io';

import 'package:ecommerce_app/controllers/upload_product_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import 'package:image_picker/image_picker.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  final TextEditingController _productTitleController = TextEditingController();
  final  TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();




  File? _pickedImage;

  final UploadProductController _uploadProductController = UploadProductController();

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 40,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    final pickedImageFile = pickedImage == null ? null : File(pickedImage.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
    // widget.imagePickFn(pickedImageFile);
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  uploadProduct() async{
    await _uploadProductController.uploadProducts(
        _productTitleController.text,
        _productTitleController.text,
        _priceController.text,
        _categoryController.text,
        _descriptionController.text,
        _quantityController.text,
        _pickedImage);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top:BorderSide(
              color:Colors.grey.shade600,
              width: 4,
            ),
            bottom:BorderSide(
              color:Colors.grey.shade600,
              width: 4,
            ),
            left:BorderSide(
              color:Colors.grey.shade600,
              width: 4,
            ),
            right:BorderSide(
              color:Colors.grey.shade600,
              width: 4,
            ),

          ),
        ),
        child: Material(
          color: Colors.black,
          child: InkWell(
            onTap: uploadProduct,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text('Upload',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                          textAlign: TextAlign.center),
                ),

              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: TextField(
                                controller: _productTitleController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  labelText: 'Product Title',
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextField(
                              controller: _priceController,
                              key: ValueKey('Price \$'),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Price \$',

                                // ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      /* Image picker here ***********************************/
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            //  flex: 2,
                            child: this._pickedImage == null
                                ? Container(
                              margin: EdgeInsets.all(10),
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1),
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey.shade600,
                              ),
                            )
                                : Container(
                              margin: EdgeInsets.all(10),
                              height: 200,
                              width: 200,
                              child: Container(
                                height: 200,
                                // width: 200,
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.only(
                                  //   topLeft: const Radius.circular(40.0),
                                  // ),
                                  color:
                                  Theme.of(context).backgroundColor,
                                ),
                                child: Image.file(
                                  this._pickedImage!,
                                  fit: BoxFit.contain,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: TextButton.icon(
                                  onPressed: _pickImageCamera,
                                  icon: Icon(Icons.camera,
                                      color: Colors.black),
                                  label: Text(
                                    'Camera',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: TextButton.icon(
                                  onPressed: _pickImageGallery,
                                  icon: Icon(Icons.image,
                                      color: Colors.black),
                                  label: Text(
                                    'Gallery',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              FittedBox(
                                child: TextButton.icon(
                                  onPressed: _removeImage,
                                  icon: Icon(
                                    Icons.remove_circle_rounded,
                                    color: Colors.red,
                                  ),
                                  label: Text(
                                    'Remove',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      //    SizedBox(height: 5),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            // flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: Container(
                                child: TextField(
                                  controller: _categoryController,
                                  //keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'Add a new Category',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 15),
                      TextField(
                        controller: _descriptionController,
                          key: ValueKey('Description'),

                          //controller: this._controller,
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            //  counterText: charLength.toString(),
                            labelText: 'Description',
                            hintText: 'Product description',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (text) {
                            // setState(() => charLength -= text.length);
                          }),
                      //    SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            //flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: TextField(
                                controller: _quantityController,
                                keyboardType: TextInputType.number,
                                key: ValueKey('Quantity'),
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(
      this.icon,
      this.size,
      this.gradient,
      );

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      child: SizedBox(
        width: size * 1.2,
        height: size * 1.2,
        child: Icon(
          icon,
          size: size,
          color: Colors.white,
        ),
      ),
      shaderCallback: (Rect bounds) {
        final Rect rect = Rect.fromLTRB(0, 0, size, size);
        return gradient.createShader(rect);
      },
    );
  }
}
