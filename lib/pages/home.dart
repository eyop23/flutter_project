import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/models/category_model.dart';
import 'package:myapp/models/diet_model.dart';


class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> catagories=[];
  List<DietModel> diets=[];

  void _getCatagories(){
    catagories= CategoryModel.getCategories();
  }
  void _getDiets(){
    diets = DietModel.getDiets();
  }
  @override
  void initState() {
    super.initState();
    _getCatagories();
    _getDiets();
  }

  @override
  Widget build(BuildContext context) {
    _getCatagories();
    _getDiets();
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        _searchfield(),
        const SizedBox(height: 40),
        _catagoriesSection(),
        const SizedBox(height: 20),
        _insideCatagoriesSection(),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             const Padding(
            padding: EdgeInsets.only(left:20),
            child: Text("Recommendation\n for diet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )
            ),
          ),
          const  SizedBox(height: 10),
            Container(
              height: 150,
              padding:const EdgeInsets.only(
                left:20,
                right: 20
              ),
              child:ListView.separated(
                itemBuilder: (context,index){
                  return  Container(
                    width:210,
                    decoration: BoxDecoration(
                      color: diets[index].boxColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                      SvgPicture.asset(diets[index].iconPath),
                      const SizedBox(height: 5),
                      Text(diets[index].name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      ),
                      Text(diets[index].level + " | " + diets[index].duration + " | " + diets[index].calorie,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                      ),
                      Container(
                        width: 100,
                        height: 20,
                        child: const Center(
                          child: Text('View',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.blue,
                          ),
                          ),
                        ),
                     
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xff9DCEFF),
                              Color(0xffEEA4CE)
                            ]
                          )
                        ),
                      )


                    ],)
                  );
                },
                separatorBuilder: (context,index) => const SizedBox(width: 25),
                itemCount: diets.length,
                scrollDirection: Axis.horizontal,
              ),
            )

            
          ]
        )
      ],)
    );
  }

  Container _insideCatagoriesSection() {
    return Container(
      //git remote add origin https://github.com/eyop23/flutter_project.git
      //git push -u origin main
// Suggested code may be subject to a license. Learn more: ~LicenseLog:3806232257.
        height: 120,
        padding: const EdgeInsets.only(
          left:20,
          right:20
        ),
        child:ListView.separated(
          itemCount: catagories.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context,index) => const SizedBox(width: 25),
          itemBuilder: (context,index){
          return Container(
            width: 100,
            decoration: BoxDecoration(
            color: catagories[index].boxColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(15)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               Container(
                // margin: EdgeInsets.only(top:10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(catagories[index].iconPath),
                ),
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color:Colors.white,
                  shape:BoxShape.circle,
                  
                ),
               ),
               const SizedBox(height: 10),
               Text(catagories[index].name,
               style: const TextStyle(
                 fontSize: 14,
                 fontWeight: FontWeight.w600,
                 color: Colors.black,
               ),
               )
            ],),
          );
        })
      );
  }

  Column _catagoriesSection() {
    return const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left:20),
            child: Text("Catagories",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )
            ),
          ),
        ],
      );
  }

  Container _searchfield() {
    return Container(
        margin:const EdgeInsets.only(top:40,left:20,right:20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 0.0,
              blurRadius: 40,
            ),
          ],
        ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(15),
              hintText: "search your favourite",
              hintStyle: const TextStyle(
                fontSize:14,
              ),
              prefixIcon:Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Search.svg'),
              ),
              suffixIcon:Container(
                width: 100,
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const VerticalDivider(
                        thickness: 0.1,
                        indent: 10,
                        endIndent: 10,
                        color: Colors.black,
                        ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: SvgPicture.asset('assets/icons/Filter.svg'),
                      ),
                    ],
                  ),
                ),
              ),
              
              border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,

              )
            ),
          ),
        );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text(
        'Home Pages',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor:Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () => {

        },
        child: Container(
          margin:const EdgeInsets.all(10),
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/icons/Arrow - Left 2.svg'),
          decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
          ),
        ),
      ),
      actions: [
       GestureDetector(
        onTap: () => {},
         child: Container(
          margin:const EdgeInsets.all(10),
          width: 37,
          alignment: Alignment.center,
          child: SvgPicture.asset('assets/icons/dots.svg'),
          decoration:  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
                 ),
       ),
      ],
    );
  }
}