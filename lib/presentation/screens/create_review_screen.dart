import 'package:ecommerce/presentation/controllers/create_review_controller.dart';
import 'package:ecommerce/presentation/widgets/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key,required this.productId});

  final int productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final TextEditingController _reviewTEController=TextEditingController();
  int selectedRating=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Review',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
              selectRatingTitle(),
              ratingSelector(),
              const SizedBox(height: 30,),
              buildReviewTextField(),
              const SizedBox(height: 15,),
              ElevatedButton(
                onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                    Map<String,dynamic> data={
                      "description":_reviewTEController.text.trim(),
                      "product_id":widget.productId,
                      "rating":selectedRating,
                    };
                    await Get.find<CreateReviewController>().createReview(data).then((value) {
                      if(value){
                        Get.back<bool>(result: value);
                      }else{
                        showSnackBar(context, Get.find<CreateReviewController>().errorMessage);
                      }
                      return value;
                    });
                  }
                },
                child: GetBuilder<CreateReviewController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      child: const Text(
                        'Add Review'
                      ),
                    );
                  }
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox ratingSelector() {
    return SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ListView.separated(
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      selectedRating=index+1;
                      setState(() {});
                    },
                    child: Icon(
                      (selectedRating-1)<index?Icons.star_border:Icons.star,
                      color: (selectedRating-1)<index?Colors.black45:Colors.yellow,
                      size: 50,
                    ),
                  );
                },
                separatorBuilder: (context,_){
                  return const SizedBox(
                    width: 25,
                  );
                },
              ),
            );
  }

  Text selectRatingTitle() {
    return Text(
              'Select Rating',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black45
              ),
            );
  }

  TextFormField buildReviewTextField() {
    return TextFormField(
              controller: _reviewTEController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Write Review',
              ),
              validator: (value){
                if(value==null || value==''){
                  return 'Please enter your opinion';
                }else{
                  return null;
                }
              },
            );
  }
}
