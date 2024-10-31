import 'package:flutter/material.dart';

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          //Container for top data
          Container(
            margin: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("1500.90 ECO", style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w700),),

                    Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.notifications, color: Colors.lightBlue[100],),
                          SizedBox(width: 16,),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.asset("images/profile.jpg", fit: BoxFit.contain,),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height : 12,),
                Row(
                  children: [
                    Text("                  No. Account  : 10019219", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.blue[100]),),

                  ],
                ),

                SizedBox(height : 24,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.date_range, color: Colors.blue[900], size: 30,),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Send", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100]),),
                        ],
                      ),
                    ),

                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.public, color: Colors.blue[900], size: 30,),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Request", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100]),),
                        ],
                      ),
                    ),

                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.local_offer_outlined, color: Colors.blue[900], size: 30,),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Offers", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100]),),
                        ],
                      ),
                    ),

                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(243, 245, 248, 1),
                                borderRadius: BorderRadius.all(Radius.circular(18))
                            ),
                            padding: EdgeInsets.all(12),
                            child: Icon(Icons.local_grocery_store_outlined, color: Colors.blue[900], size: 30,),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text("Store", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.blue[100]),),
                        ],
                      ),
                    )
                  ],
                )

              ],
            ),
          ),


          //draggable sheet
          DraggableScrollableSheet(
            builder: (context, scrollController){
              return Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(243, 245, 248, 1),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 24,),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Transaction history", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.black),),
                            Text("See all", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.grey[800]),)
                          ],
                        ),
                      ),
                      SizedBox(height: 24,),

                      //Container for buttons
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 10.0, spreadRadius: 4.5)]
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                              child: Text("All", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.grey[900]),),
                            ),
                            SizedBox(width: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 10.0, spreadRadius: 4.5)]
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.green,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("CLS", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.grey[900]),),
                                ],
                              ),
                            ),

                            SizedBox(width: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 10.0, spreadRadius: 4.5)]
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.orange,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("PR", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.grey[900]),),
                                ],
                              ),
                            ),
                            SizedBox(width: 8,),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  boxShadow: [BoxShadow(color: Colors.grey[200]!, blurRadius: 10.0, spreadRadius: 4.5)]
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 8,
                                    backgroundColor: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("ORG", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.grey[900]),),
                                ],
                              ),
                            )

                          ],
                        ),
                      ),

                      SizedBox(height: 16,),
                      //Container Listview for expenses and incomes
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text("TODAY", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                      ),

                      SizedBox(height: 16,),

                      ListView.builder(
                        itemBuilder: (context, index){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Icon(Icons.call_received, color: Colors.lightBlue[900],),
                                ),

                                SizedBox(width: 16,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Receive points", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey[900]),),
                                      Text("Receive from ClS", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                    ],
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text("+5.0 SAR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.lightGreen),),
                                    Text("15 Sep", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 2,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: false),
                      ),

                      //now expense
                      SizedBox(height: 16,),

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: Text("YESTERDAY", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                      ),

                      SizedBox(height: 16,),

                      ListView.builder(
                        itemBuilder: (context, index){
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 32),
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey[100],
                                      borderRadius: BorderRadius.all(Radius.circular(18))
                                  ),
                                  padding: EdgeInsets.all(12),
                                  child: Icon(Icons.shopping_cart_checkout, color: Colors.lightBlue[900],),
                                ),

                                SizedBox(width: 16,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("buy coffee", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.grey[900]),),
                                      Text("Payment to Star Cafe", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                    ],
                                  ),
                                ),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text("-3.5 SAR", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Colors.orange),),
                                    Text("14 Sep", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.grey[500]),),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        shrinkWrap: true,
                        itemCount: 2,
                        padding: EdgeInsets.all(0),
                        controller: ScrollController(keepScrollOffset: false),
                      ),

                      //now expense


                    ],
                  ),
                ),
              );
            },
            initialChildSize: 0.65,
            minChildSize: 0.65,
            maxChildSize: 1,
          )
        ],
      ),
    );
  }
}