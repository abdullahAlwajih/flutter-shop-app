import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/edit_product_controller.dart';

class EditProductPage extends GetView<EditProductController> {
  const EditProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: controller.formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: controller.editedProduct?.title,
                      decoration: const InputDecoration(labelText: 'Title'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(controller.priceFocusNode),
                      validator: (value) {
                        if (value!.isNotEmpty) return null;
                        return 'Please provide a value.';
                      },
                      onSaved: (value) =>
                          controller.editedProduct?.title = value,
                    ),
                    TextFormField(
                      initialValue: controller.editedProduct?.price.toString(),
                      decoration: const InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: controller.priceFocusNode,
                      onFieldSubmitted: (_) => FocusScope.of(context)
                          .requestFocus(controller.descriptionFocusNode),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a price.';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number grater than zero.';
                        }
                        return null;
                      },
                      onSaved: (value) => controller.editedProduct?.price =
                          double.parse(value!),
                    ),
                    TextFormField(
                      initialValue: controller.editedProduct?.description,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      focusNode: controller.descriptionFocusNode,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        if (value.length < 10) {
                          return 'Should be at least 10 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) =>
                          controller.editedProduct?.description = value,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.grey),
                          ),
                          child: controller.imageUrlController.text.isEmpty
                              ? const Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    controller.imageUrlController.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controller.imageUrlController,
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            focusNode: controller.imageUrlFocusNode,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('png') &&
                                  !value.endsWith('jpg') &&
                                  !value.endsWith('jpeg')) {
                                return 'Please enter a valid URL.';
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                controller.editedProduct?.imageUrl = value,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        icon: const Icon(Icons.save),
                        onPressed: controller.saveForm)
                  ],
                ),
              ),
            ),
    );
  }
}
