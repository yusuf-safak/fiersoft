import 'dart:async';
import 'dart:html';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SocialNetworks{
  static void openUserProfileOnlyWeb(var webUrl)async{
    await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
  }
  static void openUserProfile(var nativeUrl, var webUrl)async{
    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }
}


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<String> sliderImages = [
    'assets/images/s1.jpeg',
    'assets/images/s2.jpeg',
    'assets/images/s3.jpeg',
    'assets/images/s4.jpeg',
    'assets/images/s5.jpeg',
    'assets/images/s6.jpeg',
    'assets/images/s7.jpeg',
  ];


  //Timer for Slider
  int _currentIndex = 0;
  Timer? _timer;
  final PageController _pageController = PageController(initialPage: 0);
  _startTimer() {
    setState(() {
      if (_pageController.hasClients) {
        _currentIndex = _pageController.initialPage;

        const duration = Duration(seconds: 3); // 3 seconds interval for auto-scrolling
        _timer = Timer.periodic(duration, (Timer timer) {
          if (_currentIndex < sliderImages.length - 1) {
            _currentIndex++;
          } else {
            _currentIndex = 0;
          }
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      }
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset('assets/images/banner.png'),
                  SizedBox(height: 16,),
                  Text('Projelerimiz', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.sizeOf(context).width * 0.03,
                  ),),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            MediaQuery.sizeOf(context).width * 0.01,
                          ),
                          child: Image.asset('assets/images/randevunetlogo.png',
                          width: MediaQuery.sizeOf(context).width * 0.08,
                          ),
                        ),
                        SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('RandevuNet: Online Randevu!',style: TextStyle(
                                fontSize: MediaQuery.sizeOf(context).width * 0.025,
                                fontWeight: FontWeight.bold
                              ),),
                              Text('RandevuNet güzellik sektörünün online randevu sistemidir. '
                                  'Uygulumamız üzerinden size en yakın ve en beğenilen işletmeleri tespit edip randevu oluşturabilirsiniz.'
                                  ' Eğer bir işletmeniz varsa hızlıca işletme kaydı yapıp RandevuNet kullanıcıları tarafından keşfedilmeyi bekleyebilirsiniz.',style: TextStyle(
                                  fontSize: 13,
                              ),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for(int index = 0 ; index < sliderImages.length; index++)...[
                            SizedBox(
                              height: MediaQuery.sizeOf(context).width * 0.3 * 2/1.6,
                              width: MediaQuery.sizeOf(context).width * 0.3/1.6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.sizeOf(context).width * 0.02
                                ),
                                child: Image.asset(
                                  sliderImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: MediaQuery.sizeOf(context).width * 0.01,)
                          ],
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),

                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              SocialNetworks.openUserProfileOnlyWeb('https://play.google.com/store/apps/details?id=com.randevunet');
                            },
                            child: SvgPicture.asset('assets/images/play_store_download.svg',
                              height: MediaQuery.sizeOf(context).width * 0.08,
                            ),
                          ),
                          SizedBox(width: MediaQuery.sizeOf(context).width * 0.02,),
                          GestureDetector(
                            onTap: (){
                              SocialNetworks.openUserProfileOnlyWeb('https://apps.apple.com/tr/app/randevunet/id6471379885');
                            },
                            child: SvgPicture.asset('assets/images/app_store_download.svg',
                              height: MediaQuery.sizeOf(context).width * 0.08 * 140/60,
                            ),
                          )
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Text('Hemen İndirin'
                          ,style: TextStyle(
                           fontSize:   MediaQuery.sizeOf(context).width * 0.025
                          )
                          ,textAlign: TextAlign.center,),)
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal:
                        MediaQuery.sizeOf(context).width < 600?
                        16.0: MediaQuery.sizeOf(context).width * 0.2,
                    vertical: 16
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10
                          )
                        ]
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Column(
                        children: [
                          SizedBox(height: 8,),
                          Text('Bize Ulaşın', style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.sizeOf(context).width * 0.03,
                          ),),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 16,),
                                TextFormField(
                                  controller: _firstNameController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.black
                                          )
                                      ),
                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                      labelText: 'Ad',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Lütfen adınızı girin';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16,),
                                TextFormField(
                                  controller: _lastNameController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(labelText: 'Soyad',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black
                                        )
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Lütfen soyadınızı girin';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16,),
                                TextFormField(
                                  controller: _emailController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(labelText: 'E-posta',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black
                                        )
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Lütfen e-posta adresinizi girin';
                                    }
                                    // E-posta doğrulama için regex kullanılabilir.
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16,),
                                TextFormField(
                                  controller: _messageController,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: 'Mesaj',
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black
                                        )
                                    ),
                                    labelStyle: TextStyle(
                                        color: Colors.grey
                                    ),
                                  ),
                                  maxLines: 6,
                                  maxLength: 1000,// Birden fazla satır girmek için
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Lütfen bir mesaj yazın';
                                    }
                                    return null;
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        // Form doğrulandığında buraya gelecek, formun gönderme işlemleri burada yapılabilir.
                                        // Örneğin: API'ye post request göndermek gibi.
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          content: Text('Form gönderildi'),
                                        ));
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: MediaQuery.sizeOf(context).width * 0.1,
                                        vertical: 16
                                      )
                                    ),
                                    child: Text('Gönder'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16,),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: Column(
                      children: [
                        Text('FierSoft© | | Tüm Hakları Saklıdır.',style: TextStyle(
                          color: Colors.white
                        ),),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

