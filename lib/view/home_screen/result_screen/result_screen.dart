import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          //  appBar:AppBar(
          //   title:Text("Result",

          //   )
          //  )
          body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 252, 243, 243),
        ),
        child: Column(children: [
          // SizedBox(height: 5.h),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xff184C9A),
                border: Border.all(
                  width: 5,
                  color: const Color(0xff184C9A),
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                )),
            child: Row(children: [
              IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 3.h),
                  onPressed: () => Navigator.pop(context)),
              SizedBox(width: 32.w),
              const Expanded(
                child: Text("Result",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1)),
              )
            ]),
          ),
          SizedBox(height: 1.h),
          SizedBox(
              height: 30.h,
              width: 100.w,
              // padding: const EdgeInsets.all(15),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(20),
              //   border: Border.all(color: const Color(0xff184C9A), width: 5),
              // ),
              child: ClipRRect(
                  // borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                "assets/images/pic.jpg",
                fit: BoxFit.fitWidth,
              ))),
          SizedBox(
            height: 3.h,
          ),
          const Align(
            alignment: Alignment.center,
            child: Text("Blast Cell",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1)),
          ),
          //    SizedBox(height: 2.h),
          const Divider(thickness: .5, color: Colors.grey),
          Expanded(
            child: SizedBox(
                width: 100.w,
                // decoration: BoxDecoration(
                //     border: Border.all(
                //       width: 5,
                //       color: const Color(0xff184C9A),
                //     ),
                //     borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(40),
                //       topRight: Radius.circular(40),
                //     )),
                child: Column(
                  children: [
                    // SizedBox(height: 2.h),
                    // const Text(
                    //   "Description",
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w600,
                    //       color: Colors.black,
                    //       letterSpacing: 1),
                    // ),
                    SizedBox(height: 1.h),
                    Expanded(
                      child: Container(
                          width: 100.w,
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          // decoration: BoxDecoration(
                          //     color: const Color.fromARGB(255, 252, 243, 243),
                          //     boxShadow: const [
                          //       BoxShadow(
                          //         color: Colors.grey, //New
                          //         blurRadius: 2.0,
                          //       )
                          //     ],
                          //     border:
                          //         Border.all(color: Colors.black.withOpacity(.2)),
                          //     borderRadius: BorderRadius.circular(10)),
                          child: const Text(
                              "Myeloblast: Precursor cell of granulocytes and monocytes. Myeloblasts give rise to neutrophils, eosinophils, basophils, and monocytes in the bone marrow. They are part of the myeloid lineage of hematopoietic cells. Myeloblast: Precursor cell of granulocytes and monocytes. Myeloblasts give rise to neutrophils, eosinophils, basophils, and monocytes in the bone marrow. They are part of the myeloid lineage of hematopoietic cells. Immature red blood cell precursor. Erythroblasts are committed to the erythroid lineage and undergo a series of maturation steps to become mature red blood cells (erythrocytes), which transport oxygen throughout the body.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ))),
                    )
                  ],
                )),
          )
        ]),
      )),
    );
  }
}
