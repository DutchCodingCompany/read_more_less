import 'package:flutter/material.dart';
import 'package:read_more_less/read_more_less.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Widget customButtonBuilder(bool isCollapsed, VoidCallback onPressed) {
  return isCollapsed
      ? GestureDetector(
          onTap: onPressed,
          child: Container(
            color: Colors.red,
            height: 40,
            width: 400,
            child: const Text('Collapsed Container'),
          ),
        )
      : GestureDetector(
          onTap: onPressed,
          child: Container(
            color: Colors.red,
            height: 40,
            width: 400,
            child: const Text('Expanded Container'),
          ),
        );
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ReadMoreLess(
              text: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et lobortis erat. Sed vulputate elit lacinia justo tincidunt varius. Nam convallis semper magna, a volutpat turpis feugiat sed. Morbi ac ligula suscipit, lobortis arcu at, ornare justo. Maecenas vestibulum, eros et imperdiet egestas, tellus enim porttitor risus, sit amet tincidunt est neque nec arcu. Pellentesque egestas dolor vitae nisl varius, ut hendrerit nisl auctor. Morbi eget ex sapien. Donec congue sagittis ante, ac fermentum felis molestie at. Integer pharetra nec est at blandit. Nullam vestibulum at est id sollicitudin. Etiam maximus ipsum orci, nec placerat ligula pharetra vel. Curabitur rutrum justo et mauris eleifend, in tristique dolor molestie. Nullam ut sem quis orci dictum vestibulum eu ac sem. Nam eu consectetur lacus. Nulla ut elit sed urna condimentum efficitur.
''',
            ),
            SizedBox(height: 16),
            ReadMoreLess(
              customButtonBuilder: customButtonBuilder,
              text: '''
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur et lobortis erat. Sed vulputate elit lacinia justo tincidunt varius. Nam convallis semper magna, a volutpat turpis feugiat sed. Morbi ac ligula suscipit, lobortis arcu at, ornare justo. Maecenas vestibulum, eros et imperdiet egestas, tellus enim porttitor risus, sit amet tincidunt est neque nec arcu. Pellentesque egestas dolor vitae nisl varius, ut hendrerit nisl auctor. Morbi eget ex sapien. Donec congue sagittis ante, ac fermentum felis molestie at. Integer pharetra nec est at blandit. Nullam vestibulum at est id sollicitudin. Etiam maximus ipsum orci, nec placerat ligula pharetra vel. Curabitur rutrum justo et mauris eleifend, in tristique dolor molestie. Nullam ut sem quis orci dictum vestibulum eu ac sem. Nam eu consectetur lacus. Nulla ut elit sed urna condimentum efficitur.
''',
            ),
            SizedBox(height: 16),
            ReadMoreLess(
              text: '''
<Html>    
<Head>  
<title>  
Example of Paragraph tag  
</title>  
</Head>  
<Body>   
<p> <!-- It is a Paragraph tag for creating the paragraph -->  
<b> HTML </b> stands for <i> <u> Hyper Text Markup Language. </u> </i> It is used to create a web pages and applications. This language   
is easily understandable by the user and also be modifiable. It is actually a Markup language, hence it provides a flexible way for designing the  
web pages along with the text.   
</p>  
HTML file is made up of different elements. <b> An element </b> is a collection of <i> start tag, end tag, attributes and the text between them</i>.   
</p>  
</Body>  
</Html>  
''',
              readMoreText: 'show more HTML',
              readLessText: 'show less HTML',
            ),
          ],
        ),
      ),
    );
  }
}
