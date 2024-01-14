import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_database/http_serviceJson.dart';
import 'package:local_database/model/emp_responce.dart';
import 'package:local_database/service/http_service.dart';
import 'package:local_database/service/log_service.dart';


import 'model/post_model.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading=false;
  var items=[];
  @override
  void initState() {
    super.initState();
    var post=Post(1, "Rasuljonov", "Nurali", 14);
    _apiPostList();
    // _apiPostCreate(post);
    //  _apiPostUpdate(post);
   // _apiPostDelate(post);

  }

  void _apiPostList() async {
      setState(() {
      isLoading=true;
    });
    var response=await NetworkJson.GET(NetworkJson.API_LIST, NetworkJson.paramsEmpty());
  //  LogService.i(response.toString());
   // LogService.e("$response");
    if(response !=null){
      print("lwk clsdvlsmvlkmvlmv");
      setState(() {
        isLoading=false;
        print("111111111");
       // items=NetworkJson.parsePostList(response);
       var a= NetworkJson.parseEmpResponce(response);
      //  LogService.e(items.toString());
        items.addAll(a.data);
        LogService.e("${a.toString()}");
      });

    }else{

    }

  }

  void _apiPostCreate(Post post){
    Network.POST(Network.API_LIST, Network.paramsCreate(post)).then((response){
      LogService.w(response.toString());

    });
  }

  void _apiPostUpdate(Post post){
    Network.PUT(Network.API_UPDATE+post.id.toString(), Network.paramsUpdate(post)).then((response){
      LogService.i(response.toString());

    });
  }

  void _apiPostDelate(Post post){
    Network.DELATE(Network.API_DELATE+post.id.toString(), Network.paramsEmpty()).then((response){
      LogService.i(response.toString());
          _apiPostList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Networking"),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx,index){
              return itemHomePost(items[index]);

            },
          ),
          isLoading ? Center(
            child: CircularProgressIndicator(),
          ):SizedBox.shrink(),
        ],

      )
    );
  }




  Widget itemHomePost(Employe employe){
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.25,
        motion: ScrollMotion(),
        children: [
          SlidableAction(onPressed:(BuildContext context){
           // delate
           // _apiPostDelate(po);
          },
          flex: 3,
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          icon: Icons.delete,
          label: "Delate",),

        ],
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 20,right: 20,top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(employe.employeeName.toUpperCase(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Text(employe.employeeSalary.toString()),
          ],
        ),
      ),
    );
  }
}
