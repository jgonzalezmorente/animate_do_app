import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class NavegacionPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ( _ ) => _NotificationModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,
          title: Text('Notificaciones Page'),
        ),
    
        floatingActionButton: BotonFlotante(),
    
        bottomNavigationBar: BottomNavigation(),
       ),
    );
  }
}


class BotonFlotante extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: FaIcon( FontAwesomeIcons.play ),
      backgroundColor: Colors.pink,
      onPressed: () {

        final notificationModel = Provider.of<_NotificationModel>(context, listen: false );
        notificationModel.numero++;

        if ( notificationModel.numero >= 2 ) {
          notificationModel.bounceController?.forward( from: 0.0 );
        }

      }
    );
  }
}

class BottomNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final int numero = Provider.of<_NotificationModel>( context ).numero;

    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          label: 'Bones',
          icon: FaIcon( FontAwesomeIcons.bone )
        ),
        BottomNavigationBarItem(
          label: 'Notifications',
          icon: Stack(
            children: [
              FaIcon( FontAwesomeIcons.bell ),
              Positioned(
                top: 0.0,
                right: 0.0,
                // child: Icon( Icons.brightness_1, size: 8, color: Colors.redAccent )
                child: BounceInDown(
                  from: 10,
                  animate: numero > 0,
                  child: Bounce(
                    from: 10,
                    controller: ( controller ) => Provider.of<_NotificationModel>( context ).bounceController = controller,
                    child: Container(
                      child: Text( '$numero', style: TextStyle( color: Colors.white, fontSize: 7 ) ),
                      alignment: Alignment.center,
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        shape: BoxShape.circle
                      ),
                    ),
                  ),
                )
              )
            ]
          )
        ),
        BottomNavigationBarItem(
          label: 'My Dog',
          icon: FaIcon( FontAwesomeIcons.dog )
        ),
      ]
    );
  }  
}


class _NotificationModel extends ChangeNotifier {

  int _numero = 0;
  AnimationController? _bounceController;

  int get numero => this._numero;

  set numero( int valor ) {    
    this._numero = valor;
    notifyListeners();
  }

  AnimationController? get bounceController => this._bounceController;
  set bounceController( AnimationController? controller ) {
    this._bounceController = controller;
    //notifyListeners();
  }

}
