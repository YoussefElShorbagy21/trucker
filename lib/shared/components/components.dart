import 'package:flutter/material.dart';

Widget defaultButton(
    {
       double width = double.infinity ,
       Color background = Colors.deepOrange,
      bool isUpperCase = true ,
      double radius = 10.0 ,
      required  function ,
      required String text,
    }
    ) =>  Container(
  width: width ,
  child: MaterialButton (
      onPressed: function ,
      child:  Text(
        isUpperCase ? text.toUpperCase() : text,
        style: TextStyle
          (
          color: Colors.white,
        ),
      )
  ),
  decoration:BoxDecoration(borderRadius: BorderRadius.circular(radius,),
    color: background  ,
  ) ,
);
Widget defalutTextButton({required  function, required String text}) =>
    TextButton(
        onPressed: function,
        child: Text(text.toUpperCase(),
        )
    );

Widget defaultFormField(
{
  required TextEditingController controller,
  required TextInputType type,
  onSubmit ,
  onChange,
  onTap,
  suffixPressed,
  required validate ,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false ,
  bool isClick = true ,
}
) => TextFormField (
        controller:  controller,
        keyboardType: type,
        obscureText: isPassword,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap:onTap,
        enabled: isClick,
        validator: validate,
        decoration:  InputDecoration(
        labelText: label,
        prefixIcon: Icon(
        prefix,
        ),

          suffixIcon: suffix != null ? IconButton(
            onPressed: suffixPressed,
            icon: Icon(
              suffix,
            ),
          ) : null ,
        border: OutlineInputBorder(),
        ),
);

Widget buildTasksItem(Map model , context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children:
  
      [
  
        CircleAvatar(
  
          radius: 40,
  
          child: Text
  
            (
  
              '${model['time']}'
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        Expanded(
  
          child: Column(
  
            mainAxisSize: MainAxisSize.min,
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            children:
  
            [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18,
  
                  fontWeight: FontWeight.bold,
  
                  color: Colors.blueAccent,
  
                ),
  
              ),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20,
  
        ),
  
        IconButton(
  
          onPressed: ()
  
          {
  

          },
  
          icon:
  
            Icon
  
            (
  
              Icons.check_box_sharp,
  
              color: Colors.blue,
  
            ),
  
        ),
  
        IconButton(
  
          onPressed: ()
  
          {
  

          },
  
          icon:
  
          Icon
  
            (
  
            Icons.archive,
  
            color: Colors.black45,
  
            ),
  
        ),
  
  
  
      ],
  
    ),
  
  ),
  onDismissed: (direction)
  {
  },
) ;

Widget tasksBuilder({required List<Map> tasks}) => tasks.length == 0 ? Center(
  child: Column(
    mainAxisAlignment:  MainAxisAlignment.center,
    children:
    [
      Icon(
        Icons.menu,
        size: 180,
        color:  Colors.black45,
      ),
      Text(
        'No Tasks Yet , Please Add Some Tasks',
        style:  TextStyle
          (
          color: Colors.grey,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    ],
  ),
) : ListView.separated(
  itemBuilder: (context,index)  => buildTasksItem(tasks[index], context),
  separatorBuilder: (context , index) => Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
  itemCount: tasks.length,
);


Widget bulidArticleItem(articles, context) =>  Padding(

  padding: const EdgeInsets.all(20.0),

  child: Row(

    children:

    [

      Container(

        width: 120,

        height: 120,

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10.0),

          image: DecorationImage(

            image: NetworkImage('${articles['urlToImage']}'),

            fit: BoxFit.cover,

          ),

        ),

      ),

      SizedBox(

        width: 20,

      ),

      Expanded(

        child: Container(

          height: 120,

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisAlignment: MainAxisAlignment.start,

            mainAxisSize: MainAxisSize.min,

            children:

            [

              Expanded(

                child: Text(

                  '${articles['title']}' ,

                  style: Theme.of(context).textTheme.bodyText1,

                  maxLines: 3,

                  overflow: TextOverflow.ellipsis,

                ),

              ),

              Text(

                '${articles['publishedAt']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),

            ],

          ),

        ),

      ),

    ],

  ),

);

Widget articalBulider(list, context , {isSearch = false}) => list.length > 0 ?  ListView.separated(
  physics: BouncingScrollPhysics(),
  itemBuilder: (context,index) => bulidArticleItem(list[index],context),
  separatorBuilder: (context , index) => Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
  itemCount: 15,
) : isSearch ? Container(): Center(child: CircularProgressIndicator());

void navigateTo(context , widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context)  => widget,
  ),
);

void navigatefisnh(context , widget) =>  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context) => widget,
    ),
        (route) => false
);