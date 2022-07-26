import 'package:bloc_example/flutter17/remote_bloc.dart';
import 'package:bloc_example/flutter17/remote_event.dart';
import 'package:bloc_example/flutter17/remote_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = RemoteBloc(); // khởi tạo bloc  <=== new

  @override
  void initState() {
    super.initState();
    //loadDefaultValues();
    bloc.initValues();
  }

  // void loadDefaultValues() async {
  //   await bloc.initValues();
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        // child: StreamBuilder<RemoteState>(
        //   // sử dụng StreamBuilder để lắng nghe Stream <=== new
        //   stream: bloc.stateController.stream,
        //   // truyền stream của stateController vào để lắng nghe <=== new
        //   initialData: bloc.state,
        //   // giá trị khởi tạo chính là volume 70 hiện tại <=== new
        //   builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
        //     RemoteState? _stateData = snapshot.data;
        //     return Text(
        //         'Âm lượng hiện tại: ${_stateData?.volume}'); // update UI <=== new
        //   },
        // ),
        child: StreamBuilder<RemoteState>(
          stream: bloc.stateController.stream,
          initialData: bloc.state,
          builder: (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
            RemoteState? _stateData = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Kênh hiện tại: ${_stateData?.channel}'),
                Text('Âm lượng hiện tại: ${_stateData?.volume}')
              ],
            ); // update UI <=== new
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () {
                  bloc.eventController.sink.add(
                      IncrementChanelEvent(increment: 3));
                },
                // add event <=== new
                child: Icon(Icons.plus_one),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () {
                  bloc.eventController.sink.add(DecrementChannelEvent(decrement: 1));
                },
                // add event <=== new
                child: Icon(Icons.exposure_minus_1),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                onPressed: () =>
                    bloc.eventController.sink.add(IncrementEvent(5)),
                // add event <=== new
                child: Icon(Icons.volume_up),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () =>
                    bloc.eventController.sink.add(DecrementEvent(10)),
                // add event <=== new
                child: Icon(Icons.volume_down),
              ),
              SizedBox(
                width: 10,
              ),
              FloatingActionButton(
                onPressed: () => bloc.eventController.sink.add(MuteEvent()),
                // add event <=== new
                child: Icon(Icons.volume_mute),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose(); // dispose bloc <=== new
  }


}
